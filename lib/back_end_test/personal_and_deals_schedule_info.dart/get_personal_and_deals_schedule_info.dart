import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/personal_and_deals_schedule_info.dart/schedule_deal_note.dart';
import 'package:untitled1/back_end_test/personal_and_deals_schedule_info.dart/schedule_note.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/notes_variations/deal_note_widget.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/notes_variations/personal_note_widget.dart';

Future<List<dynamic>> getPersonalAndDealsScheduleInfo({
  required int employeeId,
  required DateTime dateTime,
  CancelToken? cancelToken,
}) async {
  await Future.delayed(const Duration(seconds: 3));
  List<Map<String, dynamic>> temp = [
    {
      'time': '1:00',
      'title': 'call ahmad 1',
      'description':
          "don't forget about theasdfaefaewfewfawefasfasdf pool and the garden jhjdh jpap8eq[fqvm [opepifqew [AP[qw--jdOAISSIDUSDF]]]]",
    },
    {
      'time': '1:00',
      'title': 'call ahmad 2',
      'description':
          "don't forget about theasdfaefaewfewfawefasfasdf pool and the garden jhjdh jpap8eq[fqvm [opepifqew [AP[qw--jdOAISSIDUSDF]]]]",
    },
    {
      'time': '2:00',
      'title': '1',
      'description':
          "don't forget about theasdfaefaewfewfawefasfasdf pool and the garden jhjdh jpap8eq[fqvm [opepifqew [AP[qw--jdOAISSIDUSDF]]]]",
    },
    {
      'time': '2:00',
      'title': '2',
      'description': 'akucasdfasdfasdfasdfasdfdgl',
      'dealId': 1,
      'dealName': 'Request to Buy Property Homs City',
      'propertyNameCode': 'V_234',
    },
    {
      'time': '4:00',
      'title': 'call ahmad 3',
      'description':
          "don't forget about theasdfaefaewfewfawefasfasdf pool and the garden jhjdh jpap8eq[fqvm [opepifqew [AP[qw--jdOAISSIDUSDF]]]]",
    },
    {
      'time': '5:00',
      'title': 'call ahmad 4',
      'description':
          "don't forget about theasdfaefaewfewfawefasfasdf pool and the garden jhjdh jpap8eq[fqvm [opepifqew [AP[qw--jdOAISSIDUSDF]]]]",
    },
    {
      'time': '7:00',
      'title': 'call ahmad 5',
      'description':
          "don't forget about theasdfaefaewfewfawefasfasdf pool and the garden jhjdh jpap8eq[fqvm [opepifqew [AP[qw--jdOAISSIDUSDF]]]]",
    },
    {
      'time': '2:00',
      'title': '2',
      'description': 'akucasdfasdfasdfasdfasdfdgl',
      'dealId': 1,
      'dealName': 'Request to Buy Property Homs City',
      'propertyNameCode': 'V_234',
    },
    {
      'time': '2:00',
      'title': '2',
      'description': 'akucasdfasdfasdfasdfasdfdgl',
      'dealId': 1,
      'dealName': 'Request to Buy Property Homs City',
      'propertyNameCode': 'V_234',
    },
    {
      'time': '2:00',
      'title': '2',
      'description': 'akucasdfasdfasdfasdfasdfdgl',
      'dealId': 1,
      'dealName': 'Request to Buy Property Homs City',
      'propertyNameCode': 'V_234',
    },
  ];

  List<dynamic> scheduleNote = [];
  for (int i = 0; i < temp.length; i++) {
    if (temp[i].containsKey('dealId')) {
      scheduleNote.add(
        DealNoteWidget(
          scheduleDealNote: ScheduleDealNote(
            employeeId: employeeId,
            time: temp[i]['time'],
            title: temp[i]['title'],
            description: temp[i]['description'],
            dealId: temp[i]['dealId'],
            propertyNameCode: temp[i]['propertyNameCode'],
            dealName: temp[i]['dealName'],
          ),
        ),
      );
    }
    scheduleNote.add(
      PersonalNoteWidget(
        scheduleNote: ScheduleNote(
          time: temp[i]['time'],
          title: temp[i]['title'],
          description: temp[i]['description'],
        ),
      ),
    );
  }
  return scheduleNote;
}
