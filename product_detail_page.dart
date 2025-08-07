class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.emoji, style: TextStyle(fontSize: 80)),
            SizedBox(height: 20),
            Text(product.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(product.description),
            SizedBox(height: 20),
            Text('السعر: ${product.price}', style: TextStyle(fontSize: 18)),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderForm(product: product)),
                  );
                },
                child: Text('طلب المنتج'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
              ),
            )
          ],
        ),
      ),
    );
  }
}
