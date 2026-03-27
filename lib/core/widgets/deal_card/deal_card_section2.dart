import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class DealCardSection2 extends StatelessWidget {
  const DealCardSection2({
    super.key,
    required this.clientImage,
    required this.clientName,
    required this.lastMessage,
    required this.timePassed,
    required this.clientScoreLeading,
  });
  final Image clientImage;
  final String clientName;
  final String lastMessage;
  final String timePassed;
  final int clientScoreLeading;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (331 / 1920),
      height: width * (194 / 1920),
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(width * (10 / 1920)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: width * (9 / 1920),
          left: width * (9 / 1920),
          right: width * (9 / 1920),
        ),
        child: Container(
          width: width * (331 / 1920),
          height: width * (194 / 1920),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(width * (10 / 1920)),
              bottomRight: Radius.circular(width * (10 / 1920)),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: width * (15 / 1920),
                  left: width * (15 / 1920),
                  bottom: width * (8 / 1920),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * (75 / 1920),
                      height: width * (75 / 1920),
                      child: clientImage,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: width * (20 / 1920),
                        top: width * (5 / 1920),
                      ),
                      child: Column(
                        children: [
                          Text(
                            clientName,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'NunitoSans-SemiBold',
                              fontSize: width * (18 / 1920),
                            ),
                          ),
                          Text(
                            '${clientScoreLeading.toString()}%',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'NunitoSans-SemiBold',
                              fontSize: width * (18 / 1920),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * (238 / 1920),
                height: width * (66 / 1920),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * (10 / 1920)),
                ),
                child: Center(
                  child: Text(
                    lastMessage,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NunitoSans-SemiBold',
                      fontSize: width * (14 / 1920),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: width * (2 / 1920),
                  left: width * (138 / 1920),
                ),
                child: Text(
                  ' $timePassed minutes ago',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 53, 53, 53),
                    fontFamily: 'NunitoSans-SemiBold',
                    fontSize: width * (12 / 1920),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
