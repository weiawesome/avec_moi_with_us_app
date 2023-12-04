import 'package:avec_moi_with_us/screens/home.dart';
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
  static const add_preference="/add_preference";
  static const index="/";
  static const search="/search";
  static const trending="/trending";
  static const information="/information";
  static const edit_password="/edit_password";
  static const edit_information="/edit_information";
  static const edit_preference="/edit_preference";
  static const history="/history";
  static const favorite="/favorite";
  static const specific_movie="/specific_movie?movie_id";
}
class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.index:
        return MaterialPageRoute(builder: (_) => const MainHomePage());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case Routes.search:
        return MaterialPageRoute(builder: (_) => const MainHomePage());
      case Routes.edit_password:
        return MaterialPageRoute(builder: (_) => const EditPasswordPage());
      case Routes.edit_information:
        return MaterialPageRoute(builder: (_) => const EditInformationPage());
      case Routes.edit_preference:
        return MaterialPageRoute(builder: (_) => const EditPreferencePage());
      case Routes.history:
        return MaterialPageRoute(builder: (_) => const HistoryPage());
      case Routes.specific_movie:
        return MaterialPageRoute(
          builder: (_) => SpecificMoviePage(movieId: settings.arguments as String),
        );
      default:
        return null;
    }
  }
}