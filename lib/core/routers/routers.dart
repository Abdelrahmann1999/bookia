import 'package:bookia/Features/Home/data/model/best_seller_responce/product.dart';
import 'package:bookia/Features/Home/presentation/page/book_details_screen.dart';
import 'package:bookia/Features/Intro/page/splach_screen.dart';
import 'package:bookia/Features/Intro/page/welcome_screen.dart';
import 'package:bookia/Features/auth/data/model/request/verify_code_params.dart';
import 'package:bookia/Features/auth/presentation/page/create_new_pass.dart';
import 'package:bookia/Features/auth/presentation/page/forget_password.dart';
import 'package:bookia/Features/auth/presentation/page/login_screen.dart';
import 'package:bookia/Features/auth/presentation/page/otp_verification_screen.dart';
import 'package:bookia/Features/auth/presentation/page/passwoed_changed.dart';
import 'package:bookia/Features/auth/presentation/page/register_screen.dart';
import 'package:bookia/Features/cart/presintation/page/checkout_screen.dart';
import 'package:bookia/Features/main/main_app_screen.dart';
import 'package:bookia/Features/profile/presination/page/edit_profile_screen.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forget_Password';
  static const String otpverification = '/otpverification';
  static const String createNewPass = '/createNewPass';
  static const String passwordChanged = '/passwordChanged';
  static const String main = '/main';
  static const String details = '/details';
  static const String checkout = '/checkout';
  static const String editProfile = '/editProfile';

  static final GoRouter routers = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplachScreen()),
      GoRoute(path: welcome, builder: (context, state) => welcomeScreen()),
      GoRoute(
        path: Routes.login,
        builder: (context, state) {
          final password =
              (state.extra as Map<String, dynamic>?)?['password'] ?? '';
          return loginScreen(password: password);
        },
      ),

      GoRoute(path: register, builder: (context, state) => RegisterScreen()),
      GoRoute(
        path: forgetPassword,
        builder: (context, state) => ForgetPasswordScreen(),
      ),
      GoRoute(
        path: otpverification,
        builder: (context, state) => OtpVerificationScreen(),
      ),
      GoRoute(
        path: createNewPass,
        builder: (context, state) =>
            CreateNewPassScreen(checkOtpParams: state.extra as CheckOtpParams),
      ),
      GoRoute(
        path: passwordChanged,
        builder: (context, state) => PasswordChangedScreen(),
      ),
      GoRoute(path: main, builder: (context, state) => MainAppScreen()),
      GoRoute(
        path: details,
        builder: (context, state) =>
            BookDetailsScreen(product: state.extra as Product),
      ),
      GoRoute(path: checkout, builder: (context, state) => CheckoutScreen()),
      GoRoute(path: editProfile, builder: (context, state) => EditProfileScreen()),
    ],
  );
}
