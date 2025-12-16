import 'package:flutter/material.dart';
import 'package:my_exercise/exercise_14/register.dart';
import 'package:my_exercise/exercise_14/profile_screen.dart';

class AuthFlowWrapper extends StatelessWidget {
  const AuthFlowWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const Navigator(
      initialRoute: '/login',
      onGenerateRoute: _onGenerateRoute,
    );
  }
  static Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case '/':
      case '/login':
        builder = (BuildContext _) => const Register();
        break;
      case ProfileScreen.routeName:
        builder = (BuildContext _) => const ProfileScreen();
        break;
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
    return MaterialPageRoute(builder: builder, settings: settings);
  }
}