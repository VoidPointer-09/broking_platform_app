import 'package:broking_platform_app/screens/holdings/holdings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HoldingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Holdings")),
      body: BlocBuilder<HoldingsBloc, HoldingsState>(
        builder: (context, state) {
          if (state is HoldingsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HoldingsLoaded) {
            return ListView.builder(
              itemCount: state.holdings.length,
              itemBuilder: (context, index) {
                final holding = state.holdings[index];
                return ListTile(
                  title: Text(holding["symbol"]),
                  subtitle: Text("Quantity: ${holding["quantity"]}, Price: ${holding["price"]}"),
                );
              },
            );
          } else {
            return Center(child: Text("Failed to load holdings"));
          }
        },
      ),
    );
  }
}
