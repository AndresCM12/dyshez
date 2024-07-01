import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        //On every app start, we validate the user's authentication status
        CustomRoute(
          page: EntryPointView.page,
          initial: true,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          path: '/',
        ),

        //Auth routes
        CustomRoute(
          page: AuthRoute.page,
          path: "/auth",
          transitionsBuilder: TransitionsBuilders.fadeIn,
          children: [
            CustomRoute(
              page: LogInView.page,
              path: "log-in",
              transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
            ),
            CustomRoute(
              page: SignUpView.page,
              path: "sign-up",
              transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
            ),
          ],
        ),

        //Dashboard routes
        CustomRoute(
          page: DashBoardRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          path: "/dashboard",
          children: [
            CustomRoute(
              page: HomeView.page,
              path: "home",
            ),
            CustomRoute(
              page: OrdersView.page,
              path: "orders",
            )
          ],
        ),

        //Floating routes
        CustomRoute(
            page: OrderDetailsView.page,
            path: "/orders-details",
            transitionsBuilder: TransitionsBuilders.fadeIn),
      ];
}
