import 'package:broking_platform_app/screens/positions/positions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PositionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Positions'),
      ),
      body: BlocBuilder<PositionsBloc, PositionsState>(
        builder: (context, state) {
          if (state is PositionsLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is PositionsError) {
            return Center(child: Text('Error loading positions'));
          }

          if (state is PositionsLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PNL Card (Realized and Unrealized)
                  PnlCard(realizedPnl: state.realizedPnl, unrealizedPnl: state.unrealizedPnl),

                  SizedBox(height: 20),

                  // List of positions
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.positions.length,
                      itemBuilder: (context, index) {
                        var position = state.positions[index];
                        return PositionTile(position: position);
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}

class PnlCard extends StatelessWidget {
  final double realizedPnl;
  final double unrealizedPnl;

  PnlCard({required this.realizedPnl, required this.unrealizedPnl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PNL Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Realized PNL: ₹${realizedPnl.toStringAsFixed(2)}'),
            Text('Unrealized PNL: ₹${unrealizedPnl.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}

class PositionTile extends StatelessWidget {
  final Map<String, dynamic> position;

  PositionTile({required this.position});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  position['symbol'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('Quantity: ${position['quantity']}'),
                Text('Price: ₹${position['current_price']}'),
                Text('Entry Price: ₹${position['entry_price']}'),
              ],
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
