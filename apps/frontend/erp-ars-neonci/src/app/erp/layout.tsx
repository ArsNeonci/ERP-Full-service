export default function ErpLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <section className="erp-layout">
      {children}
    </section>
  );
}