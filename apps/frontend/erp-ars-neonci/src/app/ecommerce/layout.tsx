export default function EcommerceLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <section className="ecommerce-layout">
      {children}
    </section>
  );
}