import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/login/login.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/buttons/button_with_text.dart';
import 'package:untitled1/core/widgets/custom_text_field/custom_text_field.dart';
import 'package:untitled1/features/crm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          width: width,
          height: width * (1080 / 1920),
          child: Image.asset(
            'assets/images/backGround.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        SizedBox(
          width: width,
          height: width * (1080 / 1920),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/newl.png',
                width: width * (777 / 1920),
                height: width * (777 / 1920),
              ),
              Container(
                width: width * (911 / 1920),
                height: width * (883 / 1920),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * (10 / 1920)),
                  color: Color(0xffF0F0F0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Sign in  to EstateHub',
                      style: TextStyle(
                        fontFamily: 'NunitoSans-Bold',
                        fontSize: width * (64 / 1920),
                      ),
                    ),
                    Text(
                      'You must become a member to login and access the entire site',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'NunitoSans-Regular',
                        fontSize: width * (36 / 1920),
                      ),
                    ),
                    CustomTextField(
                      fillColor: Colors.white,
                      onChanged: (v) {
                        name = v.trim();
                      },
                      hintText: 'Name',
                      widthOfTextField: 636,
                      fontSize: 32,
                      fontFamily: FontFamily.bold,
                      maxLines: 1,
                    ),
                    CustomTextField(
                      fillColor: Colors.white,
                      onChanged: (v) {
                        password = v.trim();
                      },
                      hintText: 'Password',
                      widthOfTextField: 636,
                      fontSize: 32,
                      fontFamily: FontFamily.bold,
                      maxLines: 1,
                    ),
                    ButtonWithText(
                      widthOfButton: width * (350 / 1920),
                      heightOfButton: width * (90 / 1920),
                      text: 'Sign in',
                      fontSize: width * (40 / 1920),
                      textColor: Colors.white,
                      buttonAction: () async {
                        if (name.isNotEmpty && password.isNotEmpty) {
                          UserAuthInfo userAuthInfo = await getUserAuthInfo(
                            name: name,
                            password: password,
                          );

                          if (context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return Crm(
                                    userAuthInfo: UserAuthInfo(
                                      id: userAuthInfo.id,
                                      role: userAuthInfo.role,
                                      accessToken: userAuthInfo.accessToken,
                                      refreshToken: userAuthInfo.refreshToken,
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        } else {}
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
