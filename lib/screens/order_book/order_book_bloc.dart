import 'package:broking_platform_app/repo/stock_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class OrderbookEvent {}

class LoadOrderbook extends OrderbookEvent {}

abstract class OrderbookState {}

class OrderbookLoading extends OrderbookState {}

class OrderbookLoaded extends OrderbookState {
  final List<Map<String, dynamic>> orders;
  final double realizedPnl;
  final double unrealizedPnl;

  OrderbookLoaded(this.orders, this.realizedPnl, this.unrealizedPnl);
}

class OrderbookError extends OrderbookState {}

class OrderbookBloc extends Bloc<OrderbookEvent, OrderbookState> {
  final StockRepository repository;

  OrderbookBloc(this.repository) : super(OrderbookLoading()) {
    on<LoadOrderbook>((event, emit) async {
      try {
        final response = await repository.fetchOrderbook();

        // Extract orders and PNL from response
        final List<Map<String, dynamic>> orders = List<Map<String, dynamic>>.from(response["orders"]);
        final double realizedPnl = (response["realized_pnl"] as num).toDouble();
        final double unrealizedPnl = (response["unrealized_pnl"] as num).toDouble();

        emit(OrderbookLoaded(orders, realizedPnl, unrealizedPnl));
      } catch (e) {
        emit(OrderbookError());
      }
    });
  }
}
