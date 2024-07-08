import 'package:dyshez_test/config/app_locator.dart';
import 'package:dyshez_test/config/app_router.dart';
import 'package:dyshez_test/modules/auth/cubits/auth/auth_cubit.dart';
import 'package:dyshez_test/modules/orders/cubits/orders/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Supabase.initialize(
    url: "https://gvvmatlttxfqwsiolbrf.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd2dm1hdGx0dHhmcXdzaW9sYnJmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTk1MjcyODEsImV4cCI6MjAzNTEwMzI4MX0.k_H0PyYjN1Wsj0Iyse0JyoMmTS7XTR1irWSn7MMaS6c",
  );

  await GetItLocator.initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => OrdersCubit(),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData.from(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(227, 2, 111, 1),
          ),
        ),
        routerConfig: GetIt.instance.get<AppRouter>().config(),
      ),
    );
  }
}
