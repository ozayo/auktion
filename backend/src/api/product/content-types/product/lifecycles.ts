// ./src/api/product/content-types/product/lifecycles.ts

export default {
  /**
   * 1) beforeCreate
   *    - Eğer "ending_date" belirtilmemişse 10 gün sonrasını atar.
   */
  async beforeCreate(event: any) {
    const { data } = event.params;
    if (!data.ending_date) {
      const newDate = new Date();
      newDate.setDate(newDate.getDate() + 10);
      data.ending_date = newDate.toISOString();
    }
  },

  /**
   * 2) afterUpdate
   *    - Otomatik olarak "lottery winner" belirler
   *    - Şartlar:
   *       a) lottery_product = true
   *       b) manual_lottery = false (otomatik çekiliş devrede)
   *       c) ending_date geçmiş (şu andan önce)
   *       d) lottery_winner henüz atanmamış
   *    - Rastgele "lottery_users" içinden birinin biduser.documentId'sini seçip "lottery_winner" alanına yazar
   */
  async afterUpdate(event: any) {
    const { result } = event; // Güncellenen Product kaydı (any)

    try {
      // 1) lottery_product = true mü?
      if (!result.lottery_product) return;

      // 2) manual_lottery = true ise otomatik çekiliş yapma
      if (result.manual_lottery) {
        console.log(`[afterUpdate] manual_lottery=true, otomatik çekiliş iptal. Ürün: ${result.title}`);
        return;
      }

      // 3) ending_date geçmiş mi?
      const now = new Date();
      const productEndDate = new Date(result.ending_date || '');
      if (productEndDate > now) {
        // Bitiş tarihi henüz geçmemiş
        return;
      }

      // 4) lottery_winner zaten var mı?
      if (result.lottery_winner) {
        return;
      }

      // 5) "fresh" olarak ürünü tekrar çekiyoruz
      //    => Bu sayede "lottery_users" ve altındaki "biduser" populate'lı gelir
      const freshProduct: any = await strapi.entityService.findOne(
        'api::product.product',
        // Numeric ID kullanıyorsanız "result.id":
        result.id,
        {
          // Eğer "documentId" bazlı güncelleme yapıyorsanız:
          // where: { documentId: result.documentId },
          populate: {
            lottery_users: {
              populate: 'biduser',
            },
          },
        }
      );

      // 6) lottery_users var mı?
      if (!freshProduct?.lottery_users?.length) {
        console.warn('[afterUpdate] lottery_users boş veya undefined.');
        return;
      }

      // 7) Rastgele bir "lottery_user" seç
      const randomIndex = Math.floor(Math.random() * freshProduct.lottery_users.length);
      const chosenLotteryUser = freshProduct.lottery_users[randomIndex];

      // 8) biduser.documentId var mı?
      if (!chosenLotteryUser?.biduser?.documentId) {
        console.warn(`[afterUpdate] Seçilen lottery_user'da biduser veya documentId yok!`);
        return;
      }

      const winnerBidUserDocId = chosenLotteryUser.biduser.documentId;

      // 9) Ürüne "lottery_winner" olarak atıyoruz
      await strapi.entityService.update('api::product.product', result.id, {
        data: {
          lottery_winner: winnerBidUserDocId,
        },
      });

      console.log(
        `🎉 [afterUpdate] Otomatik çekiliş tamam! Kazanan => ${winnerBidUserDocId} (Product: ${freshProduct.title})`
      );

    } catch (err) {
      console.error('Lottery winner atama hatası:', err);
    }
  },
};
