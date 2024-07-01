import 'package:auto_route/auto_route.dart';
import 'package:dyshez_test/config/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        LogInView(),
        SignUpView(),
      ],
      builder: (context, child) => Scaffold(body: child),
    );
  }
}
