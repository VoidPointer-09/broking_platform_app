import 'package:flutter/material.dart';

class FloatingTradeButton extends StatefulWidget {
  @override
  _FloatingTradeButtonState createState() => _FloatingTradeButtonState();
}

class _FloatingTradeButtonState extends State<FloatingTradeButton> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_isExpanded)
          Positioned(
            bottom: 80,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    Navigator.pushNamed(context, "/orderPad", arguments: {"type": "buy"});
                  },
                  child: Icon(Icons.add_shopping_cart),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () {
                    Navigator.pushNamed(context, "/orderPad", arguments: {"type": "sell"});
                  },
                  child: Icon(Icons.money_off),
                ),
              ],
            ),
          ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: () {
              setState(() => _isExpanded = !_isExpanded);
            },
            child: Icon(_isExpanded ? Icons.close : Icons.attach_money),
          ),
        ),
      ],
    );
  }
}
