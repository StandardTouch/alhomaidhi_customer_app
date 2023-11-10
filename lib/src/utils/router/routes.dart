import 'package:alhomaidhi_customer_app/src/features/my%20profile/screens/address/billing_address.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/screens/shopping_cart.dart';
import 'package:alhomaidhi_customer_app/src/features/home/screens/home_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/login/screens/login_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/screens/profile/my_profile_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/signup/screens/signup_screen.dart';
import 'package:alhomaidhi_customer_app/src/shared/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

// add custom default transition
CustomTransitionPage buildPageWithDefaultTransition(
    {required BuildContext context,
    required GoRouterState state,
    required Widget child}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 150),
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      // Change the opacity of the screen using a Curve based on the the animation's
      // value
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/profile",
  routes: [
    GoRoute(
      path: "/login",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context, state: state, child: LoginScreen()),
    ),
    GoRoute(
      path: "/signup",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context, state: state, child: SignupScreen()),
    ),
    // for main routes
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: HomaidhiBottomBar(),
        );
      },
      pageBuilder: (context, state, innerChild) =>
          buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: Scaffold(
                appBar: AppBar(
                  forceMaterialTransparency: true,
                ),
                body: innerChild,
                bottomNavigationBar: HomaidhiBottomBar(),
              )),
      routes: [
        GoRoute(
          path: "/home",
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context, state: state, child: HomeScreen()),
        ),
        GoRoute(
          path: "/cart",
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context, state: state, child: ShoppingCartScreen()),
        ),
        GoRoute(
          path: "/profile",
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context, state: state, child: MyProfileScreen()),
        ),
        GoRoute(
          path: "/address",
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context, state: state, child: BillingAddress()),
        ),
      ],
    )
  ],
);
