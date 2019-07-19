import 'package:flutter/material.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[100],
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: Colors.transparent,
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.black87,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.grey[400],
    ),
  )
);
