import 'package:alhomaidhi_customer_app/src/features/login/screens/login_screen.dart';
import 'package:alhomaidhi_customer_app/src/features/signup/screens/signup_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: "/login",
  routes: [
GoRoute(path: "/login", builder: (context, state) => LoginScreen(),),
GoRoute(path: "/signup", builder: (context, state) => SignupScreen(),)

],);