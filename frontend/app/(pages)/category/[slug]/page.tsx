import CategoryPageClient from './CategoryPageClient';

// Server Component
export default function CategoryPage({ params }: { params: { slug: string } }) {
  return <CategoryPageClient slug={params.slug} />;
}
