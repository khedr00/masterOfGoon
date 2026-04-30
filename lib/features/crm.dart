// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:untitled1/back_end_test/login/user_auth_info.dart';
// import 'package:untitled1/features/employee_home_page.dart';
// import 'package:untitled1/features/main_employees_pages.dart';
// import 'package:untitled1/features/submanager_pages.dart';
// import 'package:untitled1/providers/main_employess_page_selector_provider.dart';
// import 'package:untitled1/providers/submanager_page_selector_provider.dart';

// class Crm extends StatelessWidget {
//   const Crm({super.key, required this.userAuthInfo});
//   final UserAuthInfo userAuthInfo;

//   @override
//   Widget build(BuildContext context) {
//     final mainEmployesspageSelectorProvider =
//         Provider.of<MainEmployessPageSelectorProvider>(context);
//     final submanagerPageSelectorProvider =
//         Provider.of<SubmanagerPageSelectorProvider>(context);
//     late Widget header;
//     switch (userAuthInfo.role) {
//       case 'submanager':
//         {
//           // header = SubmanagerPages(
//           //   pageWidget: submanagerPageSelectorProvider.getPageSelected,
//           //   userAuthInfo: userAuthInfo,
//           // );
//         }
//         break;
//       default:
//         {
//           mainEmployesspageSelectorProvider.setPage(
//             EmployeeHomePage(userAuthInfo: userAuthInfo),
//           );
//           header = MainEmployeesPages(
//             pageWidget: mainEmployesspageSelectorProvider.getPageSelected!,
//             userAuthInfo: userAuthInfo,
//           );
//         }
//     }
//     return Scaffold(body: header);
//   }
// }
