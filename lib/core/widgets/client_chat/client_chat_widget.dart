import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class ClientChatWidget extends StatelessWidget {
  const ClientChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (509 / 1920),
      // height: width * (954 / 1920),
      decoration: BoxDecoration(
        border: Border.all(width: width * (4 / 1920), color: primaryColor),
        borderRadius: BorderRadius.circular(width * (50 / 1920)),
      ),
      child: Column(
        children: [
          Container(
            width: width * (509 / 1920),
            height: width * (95 / 1920),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width * (50 / 1920)),
                topRight: Radius.circular(width * (50 / 1920)),
              ),
              color: primaryColor,
            ),
          ),
          Container(
            width: width * (509 / 1920),
            height: width * (770 / 1920),
            color: Colors.white,
          ),
          Container(
            width: width * (509 / 1920),
            height: width * (75 / 1920),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(width * (50 / 1920)),
                bottomRight: Radius.circular(width * (50 / 1920)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
