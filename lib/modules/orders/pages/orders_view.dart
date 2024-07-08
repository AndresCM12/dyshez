import 'package:auto_route/auto_route.dart';
import 'package:dyshez_test/config/app_router.gr.dart';
import 'package:dyshez_test/data/enums/cubit_status.dart';
import 'package:dyshez_test/modules/orders/cubits/orders/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

@RoutePage()
class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          switch (state.state) {
            case CubitStatus.initial:
              context.read<OrdersCubit>().getOrders();
              return loadingView();

            case CubitStatus.loading:
              return loadingView();

            case CubitStatus.loaded:
              return successView();

            case CubitStatus.error:
              return const Center(
                child: Text('Error al obtener las ordenes'),
              );

            default:
              return const Center(
                child: Text('Error al obtener las ordenes'),
              );
          }
        },
      ),
    );
  }

  Widget successView() {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.grey[100],
        title: Text('Historial',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
        leading: Container(),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Pedidos anteriores',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.grey[300]),
                    itemBuilder: (context, index) {
                      return listItem(state, index, context);
                    },
                    itemCount: state.orders!.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Scaffold loadingView() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Historial',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          //add a burguer icon button
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Scaffold errorView() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Historial',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          //add a burguer icon button
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text('Error al obtener las ordenes'),
      ),
    );
  }

  GestureDetector listItem(OrdersState state, int index, BuildContext context) {
    return GestureDetector(
      onTap: () => AutoRouter.of(context)
          .push(OrderDetailsView(currentOrder: state.orders![index])),
      child: Container(
        padding: const EdgeInsets.only(bottom: 12, top: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                backgroundImage: NetworkImage(
                  state.orders![index].restaurant.featuredImage,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.orders![index].restaurant.name,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  state.orders![index].products.isNotEmpty
                      ? '${state.orders![index].products.length} artículos · \$${(state.orders![index].total + state.orders![index].deliveryRate + state.orders![index].tip - state.orders![index].discount).toStringAsFixed(2)}'
                      : "\$0.00",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
                getOrderType(state.orders![index].type),
                Row(
                  children: [
                    Text(
                      "${DateFormat("MMM dd").format(DateTime.parse(state.orders![index].createdAt!))} · ",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    getOrderStatus(state.orders![index].status),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 20,
                  child: state.orders![index].type == "direct"
                      ? Image.asset("assets/icons/state_two_order.png")
                      : Image.asset("assets/icons/state_one_order.png"),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.arrow_forward_ios,
                  weight: 12,
                  color: Colors.grey[900],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text getOrderStatus(String status) {
    switch (status) {
      case "presented":
        return Text(
          "Presentado",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        );
      case "fulfilled":
        return Text(
          "Completado",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.grey[600],
          ),
        );
      case "no_presented":
        return Text(
          "No presentado",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.red[600],
          ),
        );
      default:
        return Text(
          status,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        );
    }
  }

  Text getOrderType(String type) {
    switch (type) {
      case "direct":
        return Text(
          "Dyshez Direct",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        );
      case "promo_live":
        return Text(
          "Promo Live",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        );
      default:
        return Text(
          type,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        );
    }
  }
}
