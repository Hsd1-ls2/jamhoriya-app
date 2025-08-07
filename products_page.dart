class Product {
  final String title;
  final String price;
  final String description;
  final String emoji;

  Product({required this.title, required this.price, required this.description, required this.emoji});
}

class ProductsPage extends StatelessWidget {
  final List<Product> products = [
    Product(
      title: 'صورة رسمية',
      price: '5,000 د.ع',
      description: 'صورة رسمية بخلفية بيضاء حسب المواصفات الحكومية.',
      emoji: '📸',
    ),
    Product(
      title: 'تصوير مستندات',
      price: '1,000 د.ع / صفحة',
      description: 'تصوير مستندات بدقة عالية.',
      emoji: '🖨️',
    ),
    Product(
      title: 'مستلزمات مدرسية',
      price: 'ابتداءً من 2,000 د.ع',
      description: 'أقلام، دفاتر، ملفات وأكثر.',
      emoji: '📚',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المنتجات'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage())),
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersPage())),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: Text(product.emoji, style: TextStyle(fontSize: 32)),
              title: Text(product.title, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(product.price),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductDetailPage(product: product)),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
    );
  }
}
