import 'package:flutter/material.dart';

void main() {
  runApp(MussawirApp());
}

class MussawirApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مصور الجمهورية',
      theme: ThemeData(primarySwatch: Colors.brown, fontFamily: 'Cairo'),
      home: ProductListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "title": "مجموعة ريش Milwaukee",
      "price": 85000,
      "description": "مجموعة ريش حفر Milwaukee Multi Material & Screw Bit Set وشد 39 قطعة",
      "image": "assets/images/product1.jpg"
    },
    {
      "id": 2,
      "title": "بطارية ليثيوم PKnergy",
      "price": 3000000,
      "description": "بطارية ليثيوم PKnergy 51.2V 130Ah 6.65kWh Powerwall",
      "image": "assets/images/product2.jpg"
    }
  ];

  Map<int,int> cart = {};

  void addToCart(int productId){
    setState(() {
      cart[productId] = (cart[productId] ?? 0) + 1;
    });
  }

  void goToCart(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(cart: cart, products: products)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مصور الجمهورية'),
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: goToCart)
        ],
      ),
      body: Column(
        children: [
          // شعار أعلى الصفحة (إن وُجد)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(children: [
              if (true) ...[
                Image.asset('assets/images/logo.jpg', width: 72, height: 72, fit: BoxFit.cover),
                SizedBox(width: 12),
                Expanded(child: Text('مصور الجمهورية — منذ 1943', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              ]
            ]),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: ListTile(
                    leading: Image.asset(p['image'], width: 64, height: 64, fit: BoxFit.cover),
                    title: Text(p['title']),
                    subtitle: Text('${p['price']} د.ع'),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(product: p, addToCart: addToCart))),
                    trailing: ElevatedButton(onPressed: () => addToCart(p['id']), child: Text('أضف')),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final Map<String,dynamic> product;
  final Function addToCart;
  ProductDetailPage({required this.product, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['title'])),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(product['image'], height: 200, fit: BoxFit.cover),
            SizedBox(height: 12),
            Text(product['description']),
            SizedBox(height: 12),
            Align(alignment: Alignment.centerLeft, child: Text('السعر: ${product['price']} د.ع', style: TextStyle(fontWeight: FontWeight.bold))),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: ()=> addToCart(product['id']), child: Text('أضف إلى السلة')),
                SizedBox(width: 12),
                ElevatedButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => OrderFormPage(product: product))), child: Text('اطلب الآن')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  final Map<int,int> cart;
  final List<Map<String,dynamic>> products;
  CartPage({required this.cart, required this.products});
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<int,int> get cart => widget.cart;
  List<Map<String,dynamic>> get products => widget.products;

  void removeItem(int id){
    setState(()=> cart.remove(id));
  }

  void updateQty(int id, int qty){
    setState(()=> cart[id] = qty);
  }

  int getTotal(){
    int total = 0;
    cart.forEach((id,qty){
      final p = products.firstWhere((e)=> e['id']==id);
      total += p['price'] * qty;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('السلة')),
      body: cart.isEmpty ? Center(child: Text('السلة فارغة')) : Column(
        children: [
          Expanded(child: ListView(
            children: cart.keys.map((id){
              final p = products.firstWhere((e)=> e['id']==id);
              final qty = cart[id] ?? 1;
              return ListTile(
                leading: Image.asset(p['image'], width: 50, height:50, fit: BoxFit.cover),
                title: Text(p['title']),
                subtitle: Text('${p['price']} د.ع × $qty'),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(icon: Icon(Icons.remove), onPressed: ()=> updateQty(id, qty>1?qty-1:1)),
                  Text('$qty'),
                  IconButton(icon: Icon(Icons.add), onPressed: ()=> updateQty(id, qty+1)),
                  IconButton(icon: Icon(Icons.delete), onPressed: ()=> removeItem(id)),
                ],),
              );
            }).toList(),
          )),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Text('الإجمالي: ${getTotal()} د.ع', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                ElevatedButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => OrderFormPage(cart: cart, products: products))), child: Text('اتمام الطلب')),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OrderFormPage extends StatefulWidget {
  final Map<String,dynamic>? product;
  final Map<int,int>? cart;
  final List<Map<String,dynamic>>? products;
  OrderFormPage({this.product, this.cart, this.products});

  @override
  _OrderFormPageState createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _country = TextEditingController(text: 'العراق');
  final _street = TextEditingController();
  final _apartment = TextEditingController();
  final _city = TextEditingController();
  final _region = TextEditingController();
  final _phone = TextEditingController();
  final _phone2 = TextEditingController();
  final _notes = TextEditingController();

  int calculateTotal(){
    int total = 0;
    if(widget.product!=null){
      total = widget.product!['price'];
    } else if(widget.cart!=null && widget.products!=null){
      widget.cart!.forEach((id,qty){
        final p = widget.products!.firstWhere((e)=> e['id']==id);
        total += p['price'] * qty;
      });
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final total = calculateTotal();
    return Scaffold(
      appBar: AppBar(title: Text('معلومات الشحن')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _firstName, decoration: InputDecoration(labelText: 'الاسم الأول *'), validator: (v)=> v==null||v.isEmpty?'مطلوب':'' ),
              TextFormField(controller: _lastName, decoration: InputDecoration(labelText: 'الاسم الأخير *'), validator: (v)=> v==null||v.isEmpty?'مطلوب':'' ),
              TextFormField(controller: _country, decoration: InputDecoration(labelText: 'الدولة / المنطقة *')),
              TextFormField(controller: _street, decoration: InputDecoration(labelText: 'عنوان الشارع / الحي *'), validator: (v)=> v==null||v.isEmpty?'مطلوب':'' ),
              TextFormField(controller: _apartment, decoration: InputDecoration(labelText: 'الشقة، الجناح، الوحدة (اختياري)')),
              TextFormField(controller: _city, decoration: InputDecoration(labelText: 'المدينة *'), validator: (v)=> v==null||v.isEmpty?'مطلوب':'' ),
              TextFormField(controller: _region, decoration: InputDecoration(labelText: 'المنطقة *'), validator: (v)=> v==null||v.isEmpty?'مطلوب':'' ),
              TextFormField(controller: _phone, decoration: InputDecoration(labelText: 'هاتف *'), validator: (v)=> v==null||v.isEmpty?'مطلوب':'' ),
              TextFormField(controller: _phone2, decoration: InputDecoration(labelText: 'هاتف ثاني (اختياري)')),
              TextFormField(controller: _notes, decoration: InputDecoration(labelText: 'ملاحظات الطلب (اختياري)'), maxLines: 3),
              SizedBox(height: 12),
              ListTile(title: Text('طريقة الدفع'), subtitle: Text('الدفع نقدًا عند الاستلام')),
              SizedBox(height: 12),
              Text('تفاصيل الطلب', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              if(widget.product!=null) ...[
                Text('${widget.product!['title']} - ${widget.product!['price']} د.ع'),
                SizedBox(height: 8),
              ] else if(widget.cart!=null && widget.products!=null) ...[
                ...widget.cart!.entries.map((e){
                  final p = widget.products!.firstWhere((x)=> x['id']==e.key);
                  return Text('${p['title']} x ${e.value} - ${p['price']*e.value} د.ع');
                }).toList(),
                SizedBox(height: 8),
              ],
              Text('المجموع: $total د.ع'),
              SizedBox(height: 16),
              ElevatedButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  showDialog(context: context, builder: (_)=> AlertDialog(
                    title: Text('تأكيد الطلب'),
                    content: Text('سيتم استخدام بياناتك لمعالجة الطلب. هل تؤكد؟'),
                    actions: [
                      TextButton(onPressed: ()=> Navigator.pop(context), child: Text('إلغاء')),
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> OrderSuccessPage()));
                      }, child: Text('تأكيد')),
                    ],
                  ));
                }
              }, child: Text('تأكيد الطلب')),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تم الطلب')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 80),
            SizedBox(height: 12),
            Text('تم استلام طلبك بنجاح!', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('سيتم التواصل معك لتأكيد حالة الشحن.'),
            SizedBox(height: 16),
            ElevatedButton(onPressed: ()=> Navigator.popUntil(context, (route)=> route.isFirst), child: Text('العودة')),
          ],
        ),
      ),
    );
  }
}
