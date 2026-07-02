import 'package:flutter/material.dart';

import '../../calculator/presentation/calculator_screen.dart';
import '../../products/presentation/product_list_screen.dart';
import '../../products/presentation/product_search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    ProductSearchScreen(),
    ProductListScreen(),
    CalculatorScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2),
            label: "Products",
          ),
          NavigationDestination(
            icon: Icon(Icons.calculate),
            label: "Calculator",
          ),
        ],
      ),
    );
  }
}