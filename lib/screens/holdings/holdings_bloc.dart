import 'package:broking_platform_app/repo/stock_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HoldingsEvent {}

class LoadHoldings extends HoldingsEvent {}

abstract class HoldingsState {}

class HoldingsLoading extends HoldingsState {}

class HoldingsLoaded extends HoldingsState {
  final List<Map<String, dynamic>> holdings;
  HoldingsLoaded(this.holdings);
}

class HoldingsError extends HoldingsState {}

class HoldingsBloc extends Bloc<HoldingsEvent, HoldingsState> {
  final StockRepository repository;

  HoldingsBloc(this.repository) : super(HoldingsLoading()) {
    on<LoadHoldings>((event, emit) async {
      try {
        final holdings = await repository.fetchHoldings();
        emit(HoldingsLoaded(holdings));
      } catch (e) {
        emit(HoldingsError());
      }
    });
  }
}
