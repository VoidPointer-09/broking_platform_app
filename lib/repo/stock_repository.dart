import 'dart:async';

const mockUsers = [
  {'username': '8378819787', 'password': 'password123'},
  {'username': '8378819788', 'password': 'password456'},
  {'username': '8378819789', 'password': 'password789'},
];


class StockRepository {
  Future<List<Map<String, dynamic>>> fetchHoldings() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      {"symbol": "TCS", "quantity": 10, "price": 150.0},
      {"symbol": "INFY", "quantity": 5, "price": 700.0}
    ];
  }

  Future<Map<String, dynamic>> fetchOrderbook() async {
    await Future.delayed(Duration(seconds: 1));
    return {
      "orders": [
        {"symbol": "AAPL", "quantity": 10, "price": 150.0, "status": "Completed"},
        {"symbol": "GOOGL", "quantity": 5, "price": 2800.0, "status": "Pending"}
      ],
      "realized_pnl": 120.0,
      "unrealized_pnl": -45.0
    };
  }

  Future<Map<String, dynamic>> fetchPositions() async {
    await Future.delayed(Duration(seconds: 1));
    return {
      "positions": [
        {"symbol": "AAPL", "quantity": 10, "entry_price": 145.0, "current_price": 150.0},
        {"symbol": "GOOGL", "quantity": 5, "entry_price": 2800.0, "current_price": 2780.0}
      ],
      "realized_pnl": 75.0,
      "unrealized_pnl": -25.0
    };
  }
}
