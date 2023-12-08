import 'package:avec_moi_with_us/screens/inital/login.dart';
import 'package:avec_moi_with_us/screens/inital/signup.dart';
import 'package:avec_moi_with_us/screens/main/main_home.dart';
import 'package:avec_moi_with_us/screens/main/movie/specific.dart';
import 'package:avec_moi_with_us/screens/main/personal/edit_information.dart';
import 'package:avec_moi_with_us/screens/main/personal/edit_password.dart';
import 'package:avec_moi_with_us/screens/main/personal/edit_preference.dart';
import 'package:avec_moi_with_us/screens/main/personal/history.dart';
import 'package:flutter/material.dart';

class Routes {
  static const login="/login";
  static const signup="/signup";
  static const addPreference="/add_preference";
  static const index="/";
  static const search="/search";
  static const trending="/trending";
  static const information="/information";
  static const editPassword="/edit_password";
  static const editInformation="/edit_information";
  static const editPreference="/edit_preference";
  static const history="/history";
  static const favorite="/favorite";
  static const specificMovie="/specific_movie?movie_id";
}
class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.index:
        return MaterialPageRoute(builder: (_) => const MainHomePage());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case Routes.search:
        return MaterialPageRoute(builder: (_) => const MainHomePage());
      case Routes.editPassword:
        return MaterialPageRoute(builder: (_) => const EditPasswordPage());
      case Routes.editInformation:
        return MaterialPageRoute(builder: (_) => const EditInformationPage());
      case Routes.editPreference:
        return MaterialPageRoute(builder: (_) => const EditPreferencePage());
      case Routes.history:
        return MaterialPageRoute(builder: (_) => const HistoryPage());
      case Routes.specificMovie:
        return MaterialPageRoute(
          builder: (_) => SpecificMoviePage(movieId: settings.arguments as String),
        );
      default:
        return null;
    }
  }
}