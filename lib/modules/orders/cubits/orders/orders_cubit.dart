import 'dart:developer';

import 'package:dyshez_test/data/enums/cubit_status.dart';
import 'package:dyshez_test/data/models/order.dart';
import 'package:dyshez_test/data/repositories/orders_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:equatable/equatable.dart';
part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(const OrdersState());
  final locator = GetIt.instance;

  Future<void> getOrders() async {
    log("Getting orders");
    emit(state.copyWith(state: CubitStatus.loading));
    final orders = await locator.get<OrdersRepository>().getOrders();
    if (orders.isNotEmpty) {
      emit(state.copyWith(state: CubitStatus.loaded, orders: orders));
    } else {
      emit(state.copyWith(state: CubitStatus.error));
    }
  }
}
