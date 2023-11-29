import 'package:avec_moi_with_us/blocs/provider/theme_provider.dart';
import 'package:avec_moi_with_us/blocs/utils/bloc_navigator.dart';
import 'package:avec_moi_with_us/screens/home.dart';
import 'package:avec_moi_with_us/screens/main/main_home.dart';
import 'package:avec_moi_with_us/styles/custom_style.dart';
import 'package:avec_moi_with_us/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ThemeProvider(),
          ),
          BlocProvider(
            create: (context) => PageBloc(),
          ),
        ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Avec Moi With Us',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: LightStyle.theme,
      darkTheme: DarkStyle.theme,
      themeMode: themeProvider.themeMode,
      home: HomePage(),
    );
  }
}


