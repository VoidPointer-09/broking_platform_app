import 'package:broking_platform_app/screens/order_book/order_book_screen.dart';
import 'package:broking_platform_app/screens/positions/positions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PositionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PositionsBloc, PositionsState>(
        builder: (context, state) {
          if (state is PositionsLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is PositionsError) {
            return Center(child: Text('Error loading positions'));
          }

          if (state is PositionsLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PNL Card (Realized and Unrealized)
                PNLCard(realizedPnl: state.realizedPnl, unrealizedPnl: state.unrealizedPnl),
            
                SizedBox(height: 20),
            
                // List of positions
                Expanded(
                  child: ListView.builder(
                    itemCount: state.positions.length,
                    itemBuilder: (context, index) {
                      var position = state.positions[index];
                      return ListTile(
                        title: Text(position["symbol"], style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("Quantity: ${position["quantity"]} @ ₹${position["entry_price"]}"),
                        trailing: Column(
                          children: [
                            Text("LTP: ₹ ${position["current_price"]}"),
                            Text("P/L: ₹ ${position["current_price"] - position["entry_price"]}"),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}