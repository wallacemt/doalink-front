import 'package:doalink/components/maps/map.dart';
import 'package:doalink/components/menu_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MapScreen(),
      drawer: MenuWidget(),
    );
  }
}
