import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/login.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/buttons/button_with_text.dart';
import 'package:untitled1/core/widgets/custom_text_field/custom_text_field.dart';
import 'package:untitled1/features/employee_home_page.dart';
import 'package:untitled1/features/general_manager_pages.dart/general_manager_pages.dart';
import 'package:untitled1/features/general_manager_pages.dart/generalmanager_home_page.dart';
import 'package:untitled1/features/main_employees_pages.dart';
import 'package:untitled1/features/submanager/submanager_home_page.dart';
import 'package:untitled1/features/submanager/submanager_pages.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/widgets/body_home_page.dart';
import 'package:untitled1/providers/generalmanager_page_selector_provider.dart';
import 'package:untitled1/providers/main_employess_page_selector_provider.dart';
import 'package:untitled1/providers/submanager_page_selector_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = '';
  String password = '';

  bool isLoading = false;

  Future<void> login() async {
    if (name.isEmpty || password.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    try {
      final submanagerProvider = Provider.of<SubmanagerPageSelectorProvider>(
        context,
        listen: false,
      );

      final employeeProvider = Provider.of<MainEmployessPageSelectorProvider>(
        context,
        listen: false,
      );

      final generalmanagerPageSelectorProvider =
          Provider.of<GeneralmanagerPageSelectorProvider>(
            context,
            listen: false,
          );

      UserAuthInfo userAuthInfo = await getUserAuthInfo(
        name: name,
        password: password,
      );

      if (!mounted) return;

      if (userAuthInfo.role == 'submanager') {
        submanagerProvider.selectPage(
          SubmanagerHomePage(userAuthInfo: userAuthInfo),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SubmanagerPages(userAuthInfo: userAuthInfo),
          ),
        );
      } else if (userAuthInfo.role == 'general') {
        generalmanagerPageSelectorProvider.selectPage(GeneralmanagerHomePage());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => GeneralManagerPages(userAuthInfo: userAuthInfo),
          ),
        );
      } else if (userAuthInfo.role == 'support') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Scaffold(body: BodyHomePage())),
        );
      } else {
        employeeProvider.selectPage(
          EmployeeHomePage(userAuthInfo: userAuthInfo),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainEmployeesPages(userAuthInfo: userAuthInfo),
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
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
                    color: const Color(0xffF0F0F0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Sign in to EstateHub',
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
                        hintText: 'Email',
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
                      isLoading
                          ? const CircularProgressIndicator()
                          : ButtonWithText(
                              widthOfButton: width * (350 / 1920),
                              heightOfButton: width * (90 / 1920),
                              text: 'Sign in',
                              fontSize: width * (40 / 1920),
                              textColor: Colors.white,
                              buttonAction: login,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
