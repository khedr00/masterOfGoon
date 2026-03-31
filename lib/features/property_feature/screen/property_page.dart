import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/property_card/property_card.dart';

class PropertyPage extends StatefulWidget {
  const PropertyPage({super.key});

  @override
  State<PropertyPage> createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Center(child: PropertyCard()));
  }
}
