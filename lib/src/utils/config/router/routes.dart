import 'package:alhomaidhi_customer_app/src/features/brands/screens/all_brands_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/brands/screens/brand_products.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/screens/shopping_cart.dart';
import 'package:alhomaidhi_customer_app/src/features/home/features/all%20products/screens/home_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/home/features/product%20details/models/single_product_model.dart';
import 'package:alhomaidhi_customer_app/src/features/home/features/product%20details/screens/product_details_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/login/screens/login_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/address/screens/billing_address.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/screens/my_order_details.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/screens/my_order_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/profile/screens/my_profile_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/search/screens/search_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/signup/screens/signup_screen.dart';
import 'package:alhomaidhi_customer_app/src/shared/widgets/bottom_bar.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

// this is custom default transition
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
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      redirect: (context, state) async {
        bool isLoggedIn = await AuthHelper.isUserLoggedIn();
        if (isLoggedIn) {
          return "/home";
        } else {
          return "/login";
        }
      },
    ),
    GoRoute(
      path: "/login",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context, state: state, child: const LoginScreen()),
    ),
    GoRoute(
      path: "/signup",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context, state: state, child: SignupScreen()),
    ),
    GoRoute(
      path: "/address",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const BillingAddress(),
      ),
    ),
    GoRoute(
      path: "/my_orders",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const MyOrderScreen(),
      ),
    ),
    GoRoute(
      path: "/my_order_details/:orderId/:productIndex",
      name: "my_order_details",
      builder: (context, state) => MyOrderDetailsScreen(
        orderId: state.pathParameters["orderId"]!,
        productIndex: int.parse(state.pathParameters["productIndex"]!),
      ),
    ), //define here
    GoRoute(
      path: "/all_brands",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const AllBrandScreen(),
      ),
    ),
    GoRoute(
      path: "/product_details/:productId",
      name: "product_details_screen",
      builder: (context, state) => ProductDetailsScreen(
        productId: state.pathParameters["productId"]!,
      ),
    ),
    GoRoute(
      path: "/brand_products/:brandName",
      name: "brand_products",
      builder: (context, state) => BrandProducts(
        brandName: state.pathParameters["brandName"]!,
      ),
    ),

    // for main routes
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          appBar: AppBar(
            forceMaterialTransparency: true,
          ),
          bottomNavigationBar: const HomaidhiBottomBar(),
        );
      },
      pageBuilder: (context, state, child) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: Scaffold(
          body: child,
          bottomNavigationBar: const HomaidhiBottomBar(),
        ),
      ),
      routes: [
        GoRoute(
          path: "/home",
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context, state: state, child: const HomeScreen()),
        ),
        GoRoute(
          path: "/search",
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context, state: state, child: const SearchScreen()),
        ),
        GoRoute(
          path: "/cart",
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: const ShoppingCartScreen()),
        ),
        GoRoute(
          path: "/profile",
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context, state: state, child: const MyProfileScreen()),
        ),
      ],
    )
  ],
);
