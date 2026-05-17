import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class ComplaintCard extends StatelessWidget {
  const ComplaintCard({
    super.key,
    required this.clientName,
    required this.clientEmail,
    required this.clientPhone,
    required this.clientLeadScore,
    required this.complaintTitle,
    required this.complaintMessage,
    required this.date,
    required this.clientType,
  });

  final String clientName;
  final String clientEmail;
  final String clientPhone;
  final int clientLeadScore;
  final String complaintTitle;
  final String complaintMessage;
  final String date;
  final String clientType;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * (778 / 1920),
      constraints: BoxConstraints(minHeight: width * (257 / 1920)),
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(width * (14 / 1920)),
      ),

      child: Padding(
        padding: EdgeInsets.all(width * (10 / 1920)),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// LEFT SECTION
              Container(
                width: width * (265 / 1920),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6F8DBF), Color(0xFF9CB9E7)],
                  ),
                  borderRadius: BorderRadius.circular(width * (10 / 1920)),
                ),

                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * (18 / 1920),
                    vertical: width * (18 / 1920),
                  ),

                  child: Column(
                    children: [
                      /// PROFILE
                      Row(
                        children: [
                          Container(
                            width: width * (78 / 1920),
                            height: width * (78 / 1920),

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFEAE8D9),
                            ),

                            child: Padding(
                              padding: EdgeInsets.all(width * (6 / 1920)),
                              child: Image.asset(
                                'assets/images/profilePhoto-icon.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          SizedBox(width: width * (14 / 1920)),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  clientName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans-Bold',
                                    color: Colors.black,
                                    fontSize: width * (24 / 1920),
                                  ),
                                ),

                                SizedBox(height: width * (5 / 1920)),

                                Text(
                                  'Lead Scoring : $clientLeadScore%',
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans-SemiBold',
                                    color: Colors.black,
                                    fontSize: width * (16 / 1920),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: width * (24 / 1920)),

                      /// EMAIL
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/Notes.png',
                            width: width * (38 / 1920),
                            height: width * (38 / 1920),
                          ),

                          SizedBox(width: width * (12 / 1920)),

                          Expanded(
                            child: Text(
                              clientEmail,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontFamily: 'NunitoSans-Bold',
                                color: Colors.black,
                                fontSize: width * (18 / 1920),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: width * (22 / 1920)),

                      /// PHONE
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/Phone.png',
                            width: width * (38 / 1920),
                            height: width * (38 / 1920),
                          ),

                          SizedBox(width: width * (18 / 1920)),

                          Text(
                            clientPhone,
                            style: TextStyle(
                              fontFamily: 'NunitoSans-Bold',
                              color: Colors.black,
                              fontSize: width * (20 / 1920),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: width * (12 / 1920)),

              /// RIGHT SECTION
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF7D9DD1), Color(0xFFA8C2EB)],
                    ),
                    borderRadius: BorderRadius.circular(width * (10 / 1920)),
                  ),

                  child: Padding(
                    padding: EdgeInsets.all(width * (18 / 1920)),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// TOP BAR
                        Row(
                          children: [
                            Container(
                              width: width * (120 / 1920),
                              height: width * (42 / 1920),

                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(
                                  width * (10 / 1920),
                                ),
                              ),

                              child: Center(
                                child: Text(
                                  clientType,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'NunitoSans-Bold',
                                    fontSize: width * (18 / 1920),
                                  ),
                                ),
                              ),
                            ),

                            Spacer(),

                            Text(
                              date,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NunitoSans-Bold',
                                fontSize: width * (22 / 1920),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: width * (18 / 1920)),

                        /// TITLE
                        Center(
                          child: Text(
                            complaintTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'NunitoSans-ExtraBold',
                              fontSize: width * (28 / 1920),
                            ),
                          ),
                        ),

                        SizedBox(height: width * (18 / 1920)),

                        /// MESSAGE
                        Text(
                          complaintMessage,
                          style: TextStyle(
                            height: 1.5,
                            color: Colors.black,
                            fontFamily: 'NunitoSans-Bold',
                            fontSize: width * (18 / 1920),
                          ),
                        ),
                      ],
                    ),
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
