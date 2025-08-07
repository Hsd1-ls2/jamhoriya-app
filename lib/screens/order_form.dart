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
