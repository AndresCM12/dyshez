import 'package:dyshez_test/config/app_router.dart';
import 'package:get_it/get_it.dart';

class GetItLocator {
  static final GetIt locator = GetIt.instance;

  static Future<void> initializeDependencies() async {
    locator.registerSingleton<AppRouter>(AppRouter());
  }
}
