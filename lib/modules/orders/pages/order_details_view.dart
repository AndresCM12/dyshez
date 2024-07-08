import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:dyshez_test/data/models/order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

@RoutePage()
class OrderDetailsView extends StatelessWidget {
  final Order currentOrder;
  const OrderDetailsView({Key? key, required this.currentOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          elevation: 0,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              //RectangleBorder.rounded(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              )),
            ),
            onPressed: () => context.router.maybePop(),
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            'Detalles',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 220,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      currentOrder.restaurant.featuredImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentOrder.restaurant.name,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      getOrderStateText(
                        currentOrder.status,
                        currentOrder.createdAt!,
                      ),
                      if (currentOrder.type == "direct")
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 18,
                              color: Colors.grey[500],
                              weight: 900,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              currentOrder.address,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 22),
                      Text(
                        "Tu pedido",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 12),
                      currentOrder.type == "direct"
                          ? directBody(currentOrder)
                          : promoLiveBody(currentOrder),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Column directBody(Order order) {
    log(order.discount.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...order.products
            .map((e) => Column(
                  children: [
                    Row(
                      children: [
                        Text(e.name),
                        const Spacer(),
                        if (e.discount > 0)
                          Text("\$${e.discount.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough)),
                        Text(
                          "\$${e.price.toStringAsFixed(2)}",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Divider(color: Colors.grey[300]),
                    const SizedBox(height: 4),
                  ],
                ))
            .toList(),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total de los artículos",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                color: Colors.grey[800],
              ),
            ),
            Text(
              "\$${order.total.toStringAsFixed(2)}",
              style: GoogleFonts.poppins(
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        currentOrder.discount > 0
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Descuento",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: Colors.green[800],
                    ),
                  ),
                  Text(
                    "-\$${order.discount.toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(
                      color: Colors.green[800],
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Envío", style: GoogleFonts.poppins()),
            Text("\$${order.deliveryRate.toStringAsFixed(2)}",
                style: GoogleFonts.poppins()),
          ],
        ),
        const SizedBox(height: 4),
        currentOrder.tip > 0
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Propina",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    "\$${order.tip.toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(),
                  ),
                ],
              )
            : const SizedBox(),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            Text(
              "\$${(order.total + order.deliveryRate + order.tip - order.discount).toStringAsFixed(2)}",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Divider(color: Colors.grey[300]),
      ],
    );
  }

  Column promoLiveBody(Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        currentOrder.penalty > 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Penalización por No-Show",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(
                    "\$${order.penalty.toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reserva de Promo Live",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(
                    "\$0.00",
                    style: GoogleFonts.poppins(
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
        const SizedBox(height: 12),
        currentOrder.penalty > 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total pagado",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "\$${order.penalty.toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total pagado",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "\$0.00",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
        const SizedBox(height: 16),
        Divider(color: Colors.grey[300]),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Método de pago",
              style: GoogleFonts.poppins(),
            ),
            Row(
              children: [
                SizedBox(
                  height: 30,
                  child: Image.asset(
                    "assets/icons/${order.paymentMethod.type}.png",
                    height: 20,
                  ),
                ),
                const SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.paymentMethod.cardName,
                      style: GoogleFonts.poppins(),
                    ),
                    Text(
                      "**** **** **** ${order.paymentMethod.lastFourDigits}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[800],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 32),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            foregroundColor: Colors.black,
          ),
          onPressed: () {},
          child: Text("Ver factura", style: GoogleFonts.poppins()),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            foregroundColor: Colors.black,
          ),
          onPressed: () {},
          child: Text("¿Necesitas ayuda?", style: GoogleFonts.poppins()),
        ),
      ],
    );
  }

  Row getOrderStateText(String status, String createdOn) {
    Text orderStateText = const Text("");
    switch (status) {
      case "presented":
        orderStateText = Text(
          "Presentado",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: Colors.green,
          ),
        );
        break;

      case "fulfilled":
        orderStateText = Text(
          "Completado",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: Colors.green,
          ),
        );
        break;

      case "no_presented":
        orderStateText = Text(
          "No presentado",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: Colors.red,
          ),
        );
        break;
      default:
        orderStateText = Text(
          status,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        );
    }
    return Row(
      children: [
        orderStateText,
        const Text(" · "),
        Text(
            DateFormat("MMM dd 'a las' hh:mm a")
                .format(DateTime.parse(createdOn)),
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            )),
      ],
    );
  }
}
