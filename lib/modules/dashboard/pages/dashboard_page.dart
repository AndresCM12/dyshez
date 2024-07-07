import 'package:auto_route/auto_route.dart';
import 'package:dyshez_test/config/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeView(),
        OrdersView(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final theme = Theme.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: tabsRouter.setActiveIndex,
            backgroundColor: theme.colorScheme.onPrimaryContainer,
            surfaceTintColor: theme.colorScheme.onPrimaryContainer,
            overlayColor: MaterialStateProperty.all(
              theme.colorScheme.onPrimaryContainer,
            ),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            indicatorColor: theme.colorScheme.onPrimaryContainer,
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_outlined,
                    color:
                        theme.colorScheme.onTertiaryContainer.withOpacity(0.5)),
                selectedIcon: Icon(Icons.home_rounded,
                    color: theme.colorScheme.onTertiaryContainer),
                label: 'Inicio',
              ),
              NavigationDestination(
                icon: Icon(Icons.receipt_outlined,
                    color:
                        theme.colorScheme.onTertiaryContainer.withOpacity(0.5)),
                selectedIcon: Icon(Icons.receipt_rounded,
                    color: theme.colorScheme.onTertiaryContainer),
                label: 'Órdenes',
              ),
            ],
          ),
        );
      },
    );
  }
}
