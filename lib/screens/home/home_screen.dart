import 'package:broking_platform_app/screens/holdings/holdings_screen.dart';
import 'package:broking_platform_app/screens/order_book/order_book_screen.dart';
import 'package:broking_platform_app/screens/positions/positions_screen.dart';
import 'package:broking_platform_app/widgets/floating_trade_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [HoldingsScreen(), OrderbookScreen(), PositionsScreen()];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: "Holdings"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Orderbook"),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: "Positions"),
        ],
      ),
      floatingActionButton: FloatingTradeButton(),
    );
  }
}
