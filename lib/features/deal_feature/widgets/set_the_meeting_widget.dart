// import 'package:flutter/material.dart';

// class SetTheMeetingWidget extends StatefulWidget {
//   const SetTheMeetingWidget({super.key});

//   @override
//   State<SetTheMeetingWidget> createState() => _SetTheMeetingWidgetState();
// }

// class _SetTheMeetingWidgetState extends State<SetTheMeetingWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//                         width: width * (_debugWidth / 1920),
//                         height: width * (((_debugHeight / 4) * 2) / 1920),
//                         color: getCardColor(themeProvider.isDarkMode),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                 vertical: width * (10 / 1920),
//                               ),
//                               child: Text(
//                                 'MEETING date at : $_dayName ${_dateTime.toString().substring(0, 16)}',
//                                 style: TextStyle(
//                                   color: getPrimaryTextColor(
//                                     themeProvider.isDarkMode,
//                                   ),
//                                   fontFamily: 'NunitoSans-Bold',
//                                   fontSize: width * (24 / 1920),
//                                 ),
//                               ),
//                             ),
//                             CustomTextField(
//                               fillColor: themeProvider.isDarkMode
//                                   ? darkThirdColorSecondary
//                                   : thirdColorSecondary,
//                               onChanged: _onTextChanged,
//                               hintText: 'Enter Description',
//                               fontSize: 20,
//                               fontFamily: FontFamily.light,
//                               widthOfTextField: _debugWidth / 1.2,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 ButtonWithText(
//                                   widthOfButton: width * (139 / 1920),
//                                   heightOfButton: width * (84 / 1920),
//                                   text: 'cancel',
//                                   buttonAction: () {
//                                     setState(() {
//                                       isClicked = 0;
//                                     });
//                                   },
//                                 ),
//                                 ButtonWithText(
//                                   widthOfButton: width * (139 / 1920),
//                                   heightOfButton: width * (84 / 1920),
//                                   text: 'confirm',
//                                   buttonAction: () async {
//                                     setState(() {
//                                       isClicked = 0;
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: width * (30 / 1920)),
//                           ],
//                         ),
//                       )
//                     : Container(
//                         width: width * (_debugWidth / 1920),
//                         color: getCardColor(themeProvider.isDarkMode),
//                         child: Center(
//                           child: ButtonWithText(
//                             widthOfButton: width * (261 / 1920),
//                             heightOfButton: width * (84 / 1920),
//                             text: 'set up the MEETING',
//                             buttonAction: () {
//                               _pickDate();
//                             },
//                           ),
//                         ),
//                       );
//   }
// }
