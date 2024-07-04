import 'package:dyshez_test/config/app_router.dart';
import 'package:dyshez_test/data/providers/auth_provider.dart';
import 'package:dyshez_test/data/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';

class GetItLocator {
  static final GetIt locator = GetIt.instance;

  static Future<void> initializeDependencies() async {
    locator.registerSingleton<AppRouter>(AppRouter());
    locator.registerSingleton<AuthProvider>(AuthProvider());
    locator.registerSingleton<AuthRepository>(AuthRepository());
  }
}
