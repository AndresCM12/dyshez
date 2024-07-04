import 'package:auto_route/auto_route.dart';
import 'package:dyshez_test/modules/auth/cubits/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EntryPointView extends StatelessWidget {
  const EntryPointView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthCubit>().checkUserSession(context);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
        ),
      ),
    );
  }
}
