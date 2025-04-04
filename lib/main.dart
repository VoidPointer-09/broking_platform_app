import 'package:broking_platform_app/repo/stock_repository.dart';
import 'package:broking_platform_app/screens/auth/auth_bloc.dart';
import 'package:broking_platform_app/screens/auth/login_screen.dart';
import 'package:broking_platform_app/screens/holdings/holdings_bloc.dart';
import 'package:broking_platform_app/screens/home/home_screen.dart';
import 'package:broking_platform_app/screens/home/order_pad_screen.dart';
import 'package:broking_platform_app/screens/order_book/order_book_bloc.dart';
import 'package:broking_platform_app/screens/positions/positions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final repository = StockRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(
            create: (_) => HoldingsBloc(repository)..add(LoadHoldings())),
        BlocProvider(
            create: (_) => OrderbookBloc(repository)..add(LoadOrderbook())),
        BlocProvider(
            create: (_) => PositionsBloc(repository)..add(LoadPositions())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        routes: {
          "/dashboard": (context) => HomeScreen(),
          "/orderPad": (context) => OrderPadScreen(),
        },
      ),
    ),
  );
}
