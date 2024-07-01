import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: const Center(
        child: Text('Orders View'),
      ),
    );
  }
}
