import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:history_app/core/utils.dart';

import 'routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'History app',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.welcome, // Set the starting screen
        onGenerateRoute: AppRoutes.generateRoute, // Use centralized routing
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor:
                    Utils.getMaterialColor(Color.fromRGBO(218, 207, 184, 1))),
            textTheme: GoogleFonts.robotoMonoTextTheme()));
  }
}
