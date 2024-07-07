part of 'orders_cubit.dart';

final class OrdersState extends Equatable {
  final CubitStatus state;
  final List<Order>? orders;

  const OrdersState({
    this.state = CubitStatus.initial,
    this.orders,
  });

  OrdersState copyWith({
    CubitStatus? state,
    List<Order>? orders,
  }) {
    return OrdersState(
      state: state ?? this.state,
      orders: orders ?? this.orders,
    );
  }

  @override
  List<Object?> get props => [
        state,
        orders,
      ];
}
