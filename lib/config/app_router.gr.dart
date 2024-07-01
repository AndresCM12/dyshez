// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:dyshez_test/modules/auth/auth_page.dart' as _i1;
import 'package:dyshez_test/modules/auth/pages/entry_point_view.dart' as _i3;
import 'package:dyshez_test/modules/auth/pages/log_in_view.dart' as _i5;
import 'package:dyshez_test/modules/auth/pages/sign_up_view.dart' as _i8;
import 'package:dyshez_test/modules/dashboard/pages/dashboard_page.dart' as _i2;
import 'package:dyshez_test/modules/dashboard/pages/home_view.dart' as _i4;
import 'package:dyshez_test/modules/orders/pages/order_details_view.dart'
    as _i6;
import 'package:dyshez_test/modules/orders/pages/orders_view.dart' as _i7;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthPage(),
      );
    },
    DashBoardRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.DashBoardPage(),
      );
    },
    EntryPointView.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.EntryPointView(),
      );
    },
    HomeView.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeView(),
      );
    },
    LogInView.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.LogInView(),
      );
    },
    OrderDetailsView.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.OrderDetailsView(),
      );
    },
    OrdersView.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.OrdersView(),
      );
    },
    SignUpView.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SignUpView(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthPage]
class AuthRoute extends _i9.PageRouteInfo<void> {
  const AuthRoute({List<_i9.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DashBoardPage]
class DashBoardRoute extends _i9.PageRouteInfo<void> {
  const DashBoardRoute({List<_i9.PageRouteInfo>? children})
      : super(
          DashBoardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashBoardRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.EntryPointView]
class EntryPointView extends _i9.PageRouteInfo<void> {
  const EntryPointView({List<_i9.PageRouteInfo>? children})
      : super(
          EntryPointView.name,
          initialChildren: children,
        );

  static const String name = 'EntryPointView';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomeView]
class HomeView extends _i9.PageRouteInfo<void> {
  const HomeView({List<_i9.PageRouteInfo>? children})
      : super(
          HomeView.name,
          initialChildren: children,
        );

  static const String name = 'HomeView';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LogInView]
class LogInView extends _i9.PageRouteInfo<void> {
  const LogInView({List<_i9.PageRouteInfo>? children})
      : super(
          LogInView.name,
          initialChildren: children,
        );

  static const String name = 'LogInView';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.OrderDetailsView]
class OrderDetailsView extends _i9.PageRouteInfo<void> {
  const OrderDetailsView({List<_i9.PageRouteInfo>? children})
      : super(
          OrderDetailsView.name,
          initialChildren: children,
        );

  static const String name = 'OrderDetailsView';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.OrdersView]
class OrdersView extends _i9.PageRouteInfo<void> {
  const OrdersView({List<_i9.PageRouteInfo>? children})
      : super(
          OrdersView.name,
          initialChildren: children,
        );

  static const String name = 'OrdersView';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SignUpView]
class SignUpView extends _i9.PageRouteInfo<void> {
  const SignUpView({List<_i9.PageRouteInfo>? children})
      : super(
          SignUpView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpView';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
