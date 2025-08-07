// Flutter: مصور الجمهورية
// إزالة تسجيل الدخول واستبداله بنموذج معلومات الزبون عند الطلب

import 'package:flutter/material.dart';

void main() {
  runApp(MussawirApp());
}

class MussawirApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مصور الجمهورية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo',
        primarySwatch: Colors.brown,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, size: 100, color: Colors.brown),
            SizedBox(height: 20),
            Text('مصور الجمهورية', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('منذ 1943', style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsPage()));
              },
              child: Text('ابدأ الآن'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.brown, padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12)),
            )
          ],
        ),
      ),
    );
  }
}

class Product {
  final String title;
  final String price;
  final String description;
  final String emoji;

  Product({required this.title, required this.price, required this.description, required this.emoji});
}

class ProductsPage extends StatelessWidget {
  final List<Product> products = [
    Product(title: 'صورة رسمية', price: '5,000 د.ع', description: 'صورة رسمية بخلفية بيضاء حسب المواصفات الحكومية.', emoji: '📸'),
    Product(title: 'تصوير مستندات', price: '1,000 د.ع / صفحة', description: 'تصوير مستندات بدقة عالية.', emoji: '🖨️'),
    Product(title: 'مستلزمات مدرسية', price: 'ابتداءً من 2,000 د.ع', description: 'أقلام، دفاتر، ملفات وأكثر.', emoji: '📚'),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderForm(product: product)));
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

class OrderForm extends StatelessWidget {
  final Product product;
  const OrderForm({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('معلومات الطلب')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('طلب: ${product.title}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: 'الاسم الأول *')),
            TextField(decoration: InputDecoration(labelText: 'الاسم الأخير *')),
            TextField(decoration: InputDecoration(labelText: 'الدولة / المنطقة *', hintText: 'العراق')),
            TextField(decoration: InputDecoration(labelText: 'عنوان الشارع / الحي *')),
            TextField(decoration: InputDecoration(labelText: 'الشقة / الجناح (اختياري)')),
            TextField(decoration: InputDecoration(labelText: 'المدينة *')),
            TextField(decoration: InputDecoration(labelText: 'المنطقة *')),
            TextField(decoration: InputDecoration(labelText: 'الهاتف *')),
            TextField(decoration: InputDecoration(labelText: 'هاتف ثاني (اختياري)')),
            TextField(
              decoration: InputDecoration(labelText: 'ملاحظات الطلب (اختياري)'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            Text('طريقة الدفع: الدفع نقدًا عند الاستلام'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('تم إرسال الطلب'),
                    content: Text('شكراً لك. تم إرسال طلبك بنجاح وسنقوم بالتواصل معك قريباً.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                        child: Text('العودة إلى الرئيسية'),
                      )
                    ],
                  ),
                );
              },
              child: Text('تأكيد الطلب'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
            )
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('السلة')),
      body: Center(child: Text('سلة التسوق فارغة حالياً')),
    );
  }
}

class OrdersPage extends StatelessWidget {
  final List<String> orders = [
    'طلب صورة رسمية - قيد المراجعة',
    'طلب تصوير مستندات - تم التنفيذ',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الطلبات السابقة')),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(orders[index]),
        ),
      ),
    );
  }
}
