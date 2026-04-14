import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'inicio.dart';
import 'capturaempleados.dart';
import 'verempleados.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Antigravity Enterprise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color(0xFF0F172A), // Slate 900
        primaryColor: Color(0xFF1E293B), // Slate 800
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF3B82F6), // Blue 500
          secondary: Color(0xFF60A5FA), // Blue 400
          surface: Color(0xFF1E293B),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400, letterSpacing: 2.0),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white70),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Inicio(),
        '/captura': (context) => CapturaEmpleados(),
        '/ver': (context) => VerEmpleados(),
      },
    );
  }
}
