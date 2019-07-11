import 'package:flutter/material.dart';

class NavObj {
  final icon;
  final String title;
  final String routeName;
  final String routeNameRoot;

  const NavObj(this.title, this.routeName, {
    this.icon = Icons.home,
    this.routeNameRoot = '',
  });
}

