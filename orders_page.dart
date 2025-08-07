import 'package:flutter/material.dart';

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
