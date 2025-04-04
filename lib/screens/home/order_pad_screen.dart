import 'package:flutter/material.dart';

class OrderPadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String orderType = args["type"];
    final String stockCode = args["stock"];

    return Scaffold(
      appBar: AppBar(title: Text(orderType.toUpperCase() + " Order Pad")),
      backgroundColor: orderType == "buy" ? Colors.green[50] : Colors.red[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Stock Symbol: "+ stockCode, style: TextStyle(fontSize: 20)),
            TextField(decoration: InputDecoration(labelText: "Quantity")),
            TextField(decoration: InputDecoration(labelText: "Price")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Order placed successfully!")));
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: orderType == "buy" ? Colors.green : Colors.red,
              ),
              child: Text(orderType.toUpperCase(), style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
