import 'package:broking_platform_app/screens/order_book/order_book_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderbookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrderbookBloc, OrderbookState>(
        builder: (context, state) {
          if (state is OrderbookLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OrderbookLoaded) {
            return Column(
              children: [
                PNLCard(realizedPnl: state.realizedPnl, unrealizedPnl: state.unrealizedPnl),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.orders.length,
                    itemBuilder: (context, index) {
                      final order = state.orders[index];
                      return ListTile(
                        title: Text(order["symbol"], style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("Quantity: ${order["quantity"]} | Price: ₹ ${order["price"]}"),
                        trailing: Text(order["status"], style: TextStyle(fontSize: 16, color: Colors.blue)),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text("Failed to load orderbook."));
          }
        },
      ),
    );
  }
}

// PNL Card Widget
class PNLCard extends StatelessWidget {
  final double realizedPnl;
  final double unrealizedPnl;

  PNLCard({required this.realizedPnl, required this.unrealizedPnl});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("PNL Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Realized PNL: ", style: TextStyle(fontSize: 16)),
                Text("₹ ${realizedPnl.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 16, color: realizedPnl >= 0 ? Colors.green : Colors.red)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Unrealized PNL: ", style: TextStyle(fontSize: 16)),
                Text("₹ ${unrealizedPnl.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 16, color: unrealizedPnl >= 0 ? Colors.green : Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
