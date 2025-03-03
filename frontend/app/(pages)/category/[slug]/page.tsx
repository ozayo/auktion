import CategoryPageClient from './CategoryPageClient';

// Server Component
export default async function CategoryPage({ params }: { params: { slug: string } }) {
  // Await params to ensure it's fully resolved
  const slug = params.slug;
  return <CategoryPageClient slug={slug} />;
} 
