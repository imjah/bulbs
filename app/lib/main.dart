import 'package:bulbs/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  setTransparentStatusBar();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        colorScheme: ThemeData.light().colorScheme.copyWith(
          primary: const Color(0xFF7986cb),
          secondary: const Color(0xFF7986cb)
        )
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ThemeData.dark().colorScheme.copyWith(
          primary: const Color(0xFF9fa8da),
          secondary: const Color(0xFF9fa8da)
        )
      ),
      home: const HomeScreen()
    )
  );
}

void setTransparentStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent
      )
  );
}
