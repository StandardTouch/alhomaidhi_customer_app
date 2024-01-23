import 'package:alhomaidhi_customer_app/src/features/brands/screens/all_brands_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/brands/screens/brand_products.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/screens/shopping_cart.dart';
import 'package:alhomaidhi_customer_app/src/features/checkout/screens/checkout_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/checkout/screens/success_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/home/features/all%20products/screens/home_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/home/features/product%20details/screens/product_details_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/login/screens/login_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/address/screens/billing_address.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/delete_profile/screens/delete_profile_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_invoices/screens/my_invoices_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/screens/my_order_details.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/screens/my_order_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/profile/screens/my_profile_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/search/screens/search_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/signup/screens/signup_screen.dart';
import 'package:alhomaidhi_customer_app/src/shared/screens/network_error_screen.dart';
import 'package:alhomaidhi_customer_app/src/shared/widgets/bottom_bar.dart';
import 'package:alhomaidhi_customer_app/src/shared/widgets/homaidhi_drawer.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:alhomaidhi_customer_app/src/utils/exceptions/homaidhi_exception.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
        try {
          bool isLoggedIn = await AuthHelper.isUserLoggedIn();
          logger.d(isLoggedIn);
          if (isLoggedIn) {
            return "/home";
          } else {
            FlutterNativeSplash.remove();
            return "/login";
          }
        } on HomaidhiException catch (_) {
          FlutterNativeSplash.remove();
          return "/network_error";
        }
      },
      pageBuilder: (ctx, state) => buildPageWithDefaultTransition(
        context: ctx,
        state: state,
        child: const Scaffold(
          body: Center(
            child: Text("Navigating"),
          ),
        ),
      ),
    ),
    GoRoute(
      path: "/login",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const LoginScreen(),
      ),
      parentNavigatorKey: _rootNavigatorKey,
    ),
    GoRoute(
      path: "/signup",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context, state: state, child: const SignupScreen()),
      parentNavigatorKey: _rootNavigatorKey,
    ),
    GoRoute(
      path: "/address",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const BillingAddress(),
      ),
      parentNavigatorKey: _rootNavigatorKey,
    ),
    GoRoute(
      path: "/network_error",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const NetworkErrorScreen(),
      ),
      parentNavigatorKey: _rootNavigatorKey,
    ),
    GoRoute(
      path: "/delete_profile",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const DeleteProfileScreen(),
      ),
      parentNavigatorKey: _rootNavigatorKey,
    ),
    GoRoute(
      path: "/my_orders",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const MyOrderScreen(),
      ),
      parentNavigatorKey: _rootNavigatorKey,
    ),
    GoRoute(
      path: "/my_invoices",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const MyInvoicesScreen(),
      ),
      parentNavigatorKey: _rootNavigatorKey,
    ),
    GoRoute(
      path: "/my_order_details/:orderId/:productIndex",
      name: "my_order_details",
      builder: (context, state) => MyOrderDetailsScreen(
        orderId: state.pathParameters["orderId"]!,
        productIndex: int.parse(state.pathParameters["productIndex"]!),
      ),
      parentNavigatorKey: _rootNavigatorKey,
    ),
    GoRoute(
      path: "/checkout/:token",
      name: "checkout",
      builder: (context, state) =>
          CheckoutScreen(token: state.pathParameters["token"]!),
      parentNavigatorKey: _rootNavigatorKey,
    ),
    //define here
    GoRoute(
      path: "/all_brands",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const AllBrandScreen(),
      ),
      parentNavigatorKey: _rootNavigatorKey,
    ),

    GoRoute(
      path: "/product_details/:productId",
      name: "product_details_screen",
      builder: (context, state) => ProductDetailsScreen(
        productId: state.pathParameters["productId"]!,
      ),
      parentNavigatorKey: _rootNavigatorKey,
    ),
    GoRoute(
      path: "/brand_products/:brandName",
      name: "brand_products",
      builder: (context, state) => BrandProducts(
        brandName: state.pathParameters["brandName"]!,
      ),
      parentNavigatorKey: _rootNavigatorKey,
    ),
    GoRoute(
      path: "/success",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const SuccessPaymentScreen(),
      ),
      parentNavigatorKey: _rootNavigatorKey,
    ),

    // for main routes
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return Scaffold(
          key: scaffoldKey,
          drawer: const HomaidhiDrawer(),
          extendBody: true,
          body: child,
          bottomNavigationBar: const HomaidhiBottomBar(),
        );
      },
      pageBuilder: (context, state, child) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: Scaffold(
          key: scaffoldKey,
          drawer: const HomaidhiDrawer(),
          extendBody: true,
          body: child,
          bottomNavigationBar: const HomaidhiBottomBar(),
        ),
      ),
      routes: [
        GoRoute(
          path: "/home",
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context, state: state, child: const HomeScreen()),
          parentNavigatorKey: _shellNavigatorKey,
        ),
        GoRoute(
          path: "/search",
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const SearchScreen(),
          ),
          parentNavigatorKey: _shellNavigatorKey,
        ),
        GoRoute(
          path: "/cart",
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: const ShoppingCartScreen()),
          parentNavigatorKey: _shellNavigatorKey,
        ),
        GoRoute(
          path: "/profile",
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context, state: state, child: const MyProfileScreen()),
          parentNavigatorKey: _shellNavigatorKey,
        ),
      ],
    )
  ],
);
