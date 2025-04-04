import 'package:broking_platform_app/repo/stock_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PositionsEvent {}

class LoadPositions extends PositionsEvent {}

abstract class PositionsState {}

class PositionsLoading extends PositionsState {}

class PositionsLoaded extends PositionsState {
  final List<Map<String, dynamic>> positions;
  final double realizedPnl;
  final double unrealizedPnl;

  PositionsLoaded(this.positions, this.realizedPnl, this.unrealizedPnl);
}

class PositionsError extends PositionsState {}

class PositionsBloc extends Bloc<PositionsEvent, PositionsState> {
  final StockRepository repository;

  PositionsBloc(this.repository) : super(PositionsLoading()) {
    on<LoadPositions>((event, emit) async {
      try {
        final response = await repository.fetchPositions();

        // Extract positions and PNL data
        final List<Map<String, dynamic>> positions = List<Map<String, dynamic>>.from(response["positions"]);
        final double realizedPnl = (response["realized_pnl"] as num).toDouble();
        final double unrealizedPnl = (response["unrealized_pnl"] as num).toDouble();

        emit(PositionsLoaded(positions, realizedPnl, unrealizedPnl));
      } catch (e) {
        emit(PositionsError());
      }
    });
  }
}
