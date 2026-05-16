import 'package:flutter/material.dart';
import 'package:untitled1/features/submanager/widgets/choose_employee/choose_employee_card.dart/choose_employee_card.dart';

class ChooseEmployeeWidget extends StatelessWidget {
  const ChooseEmployeeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChooseEmployeeCard> chooseEmployeeCard = List.filled(
      5,
      ChooseEmployeeCard(),
    );
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * (1140 / 1920),
      height: width * (940 / 1920),
      child: SingleChildScrollView(
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: width * (10 / 1920)),
                  child: Text(
                    'Recommended Employees',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NunitoSans-Bold',
                      fontSize: width * (20 / 1920),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * (1100 / 1920),
                  height: width * (900 / 1920),
                  child: ListView.builder(
                    itemCount: chooseEmployeeCard.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: width * (15 / 1920),
                        ),
                        child: chooseEmployeeCard[i],
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(),
          ],
        ),
      ),
    );
  }
}
