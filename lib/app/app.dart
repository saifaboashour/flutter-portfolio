import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import 'portfolio_page.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seif Abuashour — Senior Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const PortfolioPage(),
    );
  }
}
