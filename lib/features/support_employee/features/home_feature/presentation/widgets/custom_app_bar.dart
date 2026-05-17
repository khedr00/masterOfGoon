import 'package:flutter/material.dart';
import 'package:untitled1/features/support_employee/core/widgets/custom_font.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/widgets/custom_icon.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        CustomIcon(image: 'assets/images/Slider.png'),
        SizedBox(width: width * 0.03),

        CustomIcon(image: 'assets/images/Search.png'),
        SizedBox(width: width * 0.05),
        CustomFont(
          name: 'Complaints',
          fontColor: const Color.fromARGB(255, 42, 40, 40),
          fontSize: width * 0.035,
        ),
        SizedBox(width: width * 0.05),
        CustomIcon(image: 'assets/images/Chat.png'),
      ],
    );
  }
}
