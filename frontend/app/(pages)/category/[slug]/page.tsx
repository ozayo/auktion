import CategoryPageClient from './CategoryPageClient';

// Server Component
export default async function CategoryPage({ params }: { params: { slug: string } }) {
// we use await to use params
  const resolvedParams = await Promise.resolve(params);
  const slug = resolvedParams.slug;
  
  return <CategoryPageClient slug={slug} />;
} 
