part of 'orders_cubit.dart';

final class OrdersState extends Equatable {
  final CubitStatus state;
  final List<Order>? orders;
  final String filterByDate;
  final String filterByType;
  final String filterByStatus;

  const OrdersState({
    this.state = CubitStatus.initial,
    this.orders,
    this.filterByDate = "desc",
    this.filterByType = "all",
    this.filterByStatus = "all",
  });

  OrdersState copyWith({
    CubitStatus? state,
    List<Order>? orders,
    String? filterByDate,
    String? filterByType,
    String? filterByStatus,
  }) {
    return OrdersState(
      state: state ?? this.state,
      orders: orders ?? this.orders,
      filterByDate: filterByDate ?? this.filterByDate,
      filterByType: filterByType ?? this.filterByType,
      filterByStatus: filterByStatus ?? this.filterByStatus,
    );
  }

  @override
  List<Object?> get props => [
        state,
        orders,
        filterByDate,
        filterByType,
        filterByStatus,
      ];
}
