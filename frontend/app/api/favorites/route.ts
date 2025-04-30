import { NextRequest, NextResponse } from 'next/server';
import { getAuthToken } from '@/app/data/services/get-token';
import { getStrapiURL } from '@/lib/utils';
import { cookies } from 'next/headers';

// Kullanıcının tüm favorilerini getir
export async function GET(request: NextRequest) {
  // JWT token'ı get-token servisinden al
  const authToken = await getAuthToken();
  
  if (!authToken) {
    return NextResponse.json({ 
      ok: false, 
      error: 'Unauthorized' 
    }, { status: 401 });
  }

  try {
    const baseUrl = getStrapiURL();
    // Kullanıcıyı, favorileri ve ürün detaylarını populate ile çek
    const userRes = await fetch(`${baseUrl}/api/users/me?populate[user_favorites][populate][product][populate][main_picture]=true&populate[user_favorites][populate][product][populate][categories]=true`, {
      headers: { 'Authorization': `Bearer ${authToken}` }
    });
    if (!userRes.ok) {
      const errorData = await userRes.text();
      throw new Error(`Failed to fetch user data: ${errorData}`);
    }
    const userData = await userRes.json();
    // user_favorites dizisini al
    const favorites = (userData.user_favorites || userData.user_favorites?.data || userData.user_favorites) || [];
    // Her favori kaydında product objesi olmalı
    const mappedFavorites = favorites
      .map((fav: any) => {
        // Strapi v4'te data/attributes olabilir, v3'te direkt olabilir
        const product = fav.product?.data ? { id: fav.product.data.id, ...(fav.product.data.attributes || {}) } : fav.product;
        if (!product) return null;
        return {
          favoriteId: fav.id,
          favoriteDocumentId: fav.documentId,
          ...product
        };
      })
      .filter(Boolean);
    return NextResponse.json({ ok: true, data: mappedFavorites });
  } catch (error) {
    return NextResponse.json({ 
      ok: false, 
      error: error instanceof Error ? error.message : 'Unknown error' 
    }, { status: 500 });
  }
}

// Favorileri güncelle (ekle/çıkar)
export async function PUT(req: Request) {
  try {
    // İstek gövdesini al
    const body = await req.json();
    const { productId, action, favoriteId, documentId, favoriteDocumentId } = body;
    console.log("Favorite action request:", { productId, action, favoriteId, documentId, favoriteDocumentId });

    // Gerekli parametreleri kontrol et
    if (!productId) {
      return NextResponse.json(
        { ok: false, error: "productId parameter is required" },
        { status: 400 }
      );
    }

    if (!action || (action !== "add" && action !== "remove")) {
      return NextResponse.json(
        { ok: false, error: "action parameter must be 'add' or 'remove'" },
        { status: 400 }
      );
    }

    // JWT token'ı al
    const authToken = await getAuthToken();
    if (!authToken) {
      console.error("Authentication required for favorites action");
      return NextResponse.json(
        { ok: false, error: "Authentication required" },
        { status: 401 }
      );
    }

    const baseUrl = getStrapiURL() || "";
    
    // Favori ekleme işlemi
    if (action === "add") {
      console.log(`Adding product ${productId} to favorites`);
      
      try {
        // Kullanıcı bilgilerini al
        const userResponse = await fetch(`${baseUrl}/api/users/me`, {
          headers: {
            'Authorization': `Bearer ${authToken}`,
            'Content-Type': 'application/json'
          }
        });

        if (!userResponse.ok) {
          const errorText = await userResponse.text();
          console.error("Failed to fetch user data:", errorText);
          return NextResponse.json(
            { ok: false, error: `User data fetch failed: ${errorText}` },
            { status: userResponse.status }
          );
        }

        const userData = await userResponse.json();
        const userId = userData.id;
        
        // Ürün bilgilerini al (varsa)
        const productData = documentId ? 
          { documentId } :
          { id: productId };
        
        // Favori ekle
        const addFavoriteResponse = await fetch(`${baseUrl}/api/user-favorites`, {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${authToken}`,
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            data: {
              user: userId,
              product: productId
            }
          })
        });

        if (!addFavoriteResponse.ok) {
          const errorText = await addFavoriteResponse.text();
          console.error("Failed to add favorite:", errorText);
          return NextResponse.json(
            { ok: false, error: `Adding favorite failed: ${errorText}` },
            { status: addFavoriteResponse.status }
          );
        }

        const favoriteData = await addFavoriteResponse.json();
        console.log("Favorite added successfully:", favoriteData);
        
        return NextResponse.json({
          ok: true,
          data: favoriteData,
          message: "Product added to favorites successfully"
        });
      } catch (error) {
        console.error("Error adding favorite:", error);
        return NextResponse.json(
          { ok: false, error: error instanceof Error ? error.message : "Unknown error" },
          { status: 500 }
        );
      }
    } 
    // Favori silme işlemi
    else if (action === "remove") {
      // favoriteDocumentId veya favoriteId'yi kullan
      if (!favoriteId && !favoriteDocumentId) {
        return NextResponse.json(
          { ok: false, error: "favoriteId or favoriteDocumentId is required for removal" },
          { status: 400 }
        );
      }

      // Favoriden silme işlemi gerçekleştir
      console.log(`Removing favorite for product ${productId} with favoriteId: ${favoriteId}, favoriteDocumentId: ${favoriteDocumentId}`);
      
      let deleteUrl;
      let deleteId;
      
      // Öncelik favoriteDocumentId'ye ver (Strapi v5 için)
      if (favoriteDocumentId) {
        deleteUrl = `${baseUrl}/api/user-favorites/${favoriteDocumentId}`;
        deleteId = favoriteDocumentId;
      } else {
        // Eğer favoriteDocumentId yoksa, favoriteId'yi kullan ama önce document ID'yi bul
        // Favori detaylarını getir
        const favoriteDetailsUrl = `${baseUrl}/api/user-favorites/${favoriteId}`;
        console.log(`Fetching favorite details from: ${favoriteDetailsUrl}`);
        
        try {
          const detailsResponse = await fetch(favoriteDetailsUrl, {
            headers: {
              'Authorization': `Bearer ${authToken}`,
              'Content-Type': 'application/json'
            }
          });
          
          if (!detailsResponse.ok) {
            const errorData = await detailsResponse.text();
            console.error("Error fetching favorite details:", errorData);
            return NextResponse.json(
              { ok: false, error: `Failed to fetch favorite details: ${errorData}` },
              { status: detailsResponse.status }
            );
          }
          
          const favoriteDetails = await detailsResponse.json();
          console.log("Favorite details:", favoriteDetails);
          
          // documentId'yi bul
          const documentId = favoriteDetails.data?.documentId || favoriteDetails.documentId;
          
          if (documentId) {
            deleteUrl = `${baseUrl}/api/user-favorites/${documentId}`;
            deleteId = documentId;
          } else {
            deleteUrl = `${baseUrl}/api/user-favorites/${favoriteId}`;
            deleteId = favoriteId;
            console.warn("No documentId found, falling back to ID");
          }
        } catch (error) {
          console.error("Error processing favorite details:", error);
          // Hata olursa yine de favoriteId ile devam et
          deleteUrl = `${baseUrl}/api/user-favorites/${favoriteId}`;
          deleteId = favoriteId;
        }
      }
      
      console.log(`DELETE request to: ${deleteUrl}`);
      
      const deleteResponse = await fetch(deleteUrl, {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${authToken}`,
          'Content-Type': 'application/json'
        }
      });
      
      if (!deleteResponse.ok) {
        const errorData = await deleteResponse.text();
        console.error("Error removing favorite:", errorData);
        return NextResponse.json(
          { ok: false, error: `Failed to remove favorite: ${errorData}` },
          { status: deleteResponse.status }
        );
      }
      
      console.log(`Successfully removed favorite with ID ${deleteId}`);
      return NextResponse.json({ 
        ok: true, 
        data: { message: "Favorite removed successfully", id: deleteId } 
      });
    }
    
    // Eğer action parametresi geçerliyse ama işlem yapılmadıysa (ki olmamalı)
    return NextResponse.json(
      { ok: false, error: "Invalid action or missing parameters" },
      { status: 400 }
    );
  } catch (error) {
    console.error("Error processing favorites request:", error);
    return NextResponse.json(
      { ok: false, error: error instanceof Error ? error.message : "Unknown error" },
      { status: 500 }
    );
  }
}

// Favori ürünü silme işlemi
export async function DELETE(req: Request) {
  console.log("DELETE request to /api/favorites");
  
  // URL parametrelerini al
  const url = new URL(req.url);
  const favoriteId = url.searchParams.get("favoriteId");
  const documentId = url.searchParams.get("documentId");
  
  if (!favoriteId && !documentId) {
    console.error("No favoriteId or documentId provided in DELETE request");
    return NextResponse.json({ ok: false, error: "favoriteId or documentId is required" }, { status: 400 });
  }
  
  // API URL'sini oluştur
  const baseUrl = process.env.NEXT_PUBLIC_STRAPI_API_URL || "http://localhost:1337";
  
  // Cookie'den JWT tokenını al
  const cookieStore = await cookies(); // Promise döndürdüğü için await kullanılmalı
  const token = cookieStore.get("jwt")?.value || "";
  
  if (!token) {
    console.error("No JWT token found in cookies");
    return NextResponse.json({ ok: false, error: "Authentication required" }, { status: 401 });
  }
  
  let deleteUrl: string;
  
  if (favoriteId) {
    // favoriteId ile silme
    deleteUrl = `${baseUrl}/api/user-favorites/${favoriteId}`;
  } else if (documentId) {
    // documentId ile silme - burada doğrudan documentId kullanıyoruz (yeni Strapi sürümleri)
    deleteUrl = `${baseUrl}/api/user-favorites/${documentId}`;
  } else {
    return NextResponse.json({ ok: false, error: "No ID provided for deletion" }, { status: 400 });
  }
  
  console.log(`DELETE request to Strapi API: ${deleteUrl}`);
  console.log(`Authorization token exists: ${!!token}`);
  console.log(`Authorization token length: ${token?.length}`);
  
  try {
    // Strapi API'ye DELETE isteği gönder
    const response = await fetch(deleteUrl, {
      method: "DELETE",
      headers: {
        "Authorization": `Bearer ${token}`,
        "Content-Type": "application/json",
      }
    });
    
    // Yanıt başlıklarını logla
    const responseHeaders: Record<string, string> = {};
    response.headers.forEach((value, key) => {
      responseHeaders[key] = value;
    });
    console.log(`Response headers: ${JSON.stringify(responseHeaders)}`);
    console.log(`Response status: ${response.status}`);
    
    if (!response.ok) {
      let errorMessage = `Failed to delete favorite with status ${response.status}`;
      
      try {
        const errorResponse = await response.text();
        console.error("Error response from Strapi:", errorResponse);
        errorMessage = errorResponse || errorMessage;
      } catch (e) {
        console.error("Could not parse error response:", e);
      }
      
      return NextResponse.json({ ok: false, error: errorMessage }, { status: response.status });
    }
    
    // Yanıtı işle
    let responseData;
    try {
      const text = await response.text();
      responseData = text ? JSON.parse(text) : {};
    } catch (e) {
      console.log("No JSON response or empty response");
      responseData = {};
    }
    
    console.log("Delete favorite response:", responseData);
    return NextResponse.json({ ok: true, data: responseData });
  } catch (error) {
    console.error("Error deleting favorite:", error);
    return NextResponse.json(
      { ok: false, error: error instanceof Error ? error.message : "Unknown error" },
      { status: 500 }
    );
  }
} 