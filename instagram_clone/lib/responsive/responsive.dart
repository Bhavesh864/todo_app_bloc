import 'package:flutter/material.dart';

import '../utils/dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({required this.webScreenLayout, required this.mobileScreenLayout, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < webScreenSize) {
        return mobileScreenLayout;
      }
      return webScreenLayout;
    });
  }
}
