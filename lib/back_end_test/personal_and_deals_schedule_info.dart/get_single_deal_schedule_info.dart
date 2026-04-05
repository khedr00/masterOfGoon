import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/personal_and_deals_schedule_info.dart/schedule_deal_note.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/notes_variations/deal_note_widget.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/deals_only_schedule_widget/deals_notes_widget.dart';

Future<List<DealsNotesWidget>> getSingleDealScheduleInfo({
  required int dealId,
  CancelToken? cancelToken,
}) async {
  await Future.delayed(const Duration(seconds: 3));

  List<Map<String, dynamic>> temp = [
    {
      'date': 'Sunday 2/7/2025',
      'time': '2:00',
      'title': '2',
      'description': 'akucasdfasdfasdfasdfasdfdgl',
      'dealId': dealId,
      'dealName': 'Request to Buy Property Homs City2',
      'propertyNameCode': 'V_234',
    },
    {
      'date': 'Sunday 2/7/2025',
      'time': '2:00',
      'title': '2',
      'description': 'akucasdfasdfasdfasdfasdfdgl',
      'dealId': dealId,
      'dealName': 'Request to Buy Property Homs City2',
      'propertyNameCode': 'V_234',
    },
    {
      'date': 'Sunday 2/7/2025',
      'time': '2:00',
      'title': '2',
      'description': 'akucasdfasdfasdfasdfasdfdgl',
      'dealId': dealId,
      'dealName': 'Request to Buy Property Homs City2',
      'propertyNameCode': 'V_234',
    },
    {
      'date': 'Sunday 2/7/2025',
      'time': '2:00',
      'title': '2',
      'description': 'akucasdfasdfasdfasdfasdfdgl',
      'dealId': dealId,
      'dealName': 'Request to Buy Property Homs City2',
      'propertyNameCode': 'V_234',
    },
    {
      'date': 'Sunday 2/7/2025',
      'time': '2:00',
      'title': '2',
      'description': 'akucasdfasdfasdfasdfasdfdgl',
      'dealId': dealId,
      'dealName': 'Request to Buy Property Homs City2',
      'propertyNameCode': 'V_234',
    },
    {
      'date': 'Sunday 3/7/2025',
      'time': '2:00',
      'title': '2',
      'description': 'akucasdfasdfasdfasdfasdfdgl',
      'dealId': dealId,
      'dealName': 'Request to Buy Property Homs City2',
      'propertyNameCode': 'V_234',
    },
    {
      'date': 'Sunday 3/7/2025',
      'time': '2:00',
      'title': '2',
      'description': 'akucasdfasdfasdfasdfasdfdgl',
      'dealId': dealId,
      'dealName': 'Request to Buy Property Homs City2',
      'propertyNameCode': 'V_234',
    },
    {
      'date': 'Sunday 3/7/2025',
      'time': '2:00',
      'title': '2',
      'description': 'akucasdfasdfasdfasdfasdfdgl',
      'dealId': dealId,
      'dealName': 'Request to Buy Property Homs City2',
      'propertyNameCode': 'V_234',
    },
    {
      'date': 'Sunday 3/7/2025',
      'time': '2:00',
      'title': '2',
      'description': 'akucasdfasdfasdfasdfasdfdgl',
      'dealId': dealId,
      'dealName': 'Request to Buy Property Homs City2',
      'propertyNameCode': 'V_234',
    },
    {
      'date': 'Sunday 3/7/2025',
      'time': '2:00',
      'title': '2',
      'description': 'akucasdfasdfasdfasdfasdfdgl',
      'dealId': dealId,
      'dealName': 'Request to Buy Property Homs City2',
      'propertyNameCode': 'V_234',
    },
    {
      'date': 'Sunday 4/7/2025',
      'time': '2:00',
      'title': '2',
      'description': 'akucasdfasdfasdfasdfasdfdgl',
      'dealId': dealId,
      'dealName': 'Request to Buy Property Homs City2',
      'propertyNameCode': 'V_234',
    },
    {
      'date': 'Sunday 4/7/2025',
      'time': '2:00',
      'title': '2',
      'description': 'akucasdfasdfasdfasdfasdfdgl',
      'dealId': dealId,
      'dealName': 'Request to Buy Property Homs City2',
      'propertyNameCode': 'V_234',
    },
    {
      'date': 'Sunday 4/7/2025',
      'time': '2:00',
      'title': '2',
      'description': 'akucasdfasdfasdfasdfasdfdgl',
      'dealId': dealId,
      'dealName': 'Request to Buy Property Homs City2',
      'propertyNameCode': 'V_234',
    },
  ];

  List<DealsNotesWidget> result = [];

  String? currentDate;
  List<DealNoteWidget> currentNotes = [];

  for (int i = 0; i < temp.length; i++) {
    final item = temp[i];

    if (item['date'] != currentDate) {
      if (currentNotes.isNotEmpty) {
        result.add(
          DealsNotesWidget(dealApoitmentNotes: List.from(currentNotes)),
        );
      }

      currentDate = item['date'];
      currentNotes = [];
    }
    currentNotes.add(
      DealNoteWidget(
        scheduleDealNote: ScheduleDealNote(
          date: item['date'],
          time: item['time'],
          title: item['title'],
          description: item['description'],
          dealId: item['dealId'],
          propertyNameCode: item['propertyNameCode'],
          dealName: item['dealName'],
        ),
      ),
    );
  }

  if (currentNotes.isNotEmpty) {
    result.add(DealsNotesWidget(dealApoitmentNotes: List.from(currentNotes)));
  }

  return result;
}


// List<DealNoteWidget> scheduleNote = [];
  // for (int i = 0; i < temp.length; i++) {
  //   scheduleNote.add(
  //     DealNoteWidget(
  //       scheduleDealNote: ScheduleDealNote(
  //         date: temp[i]['date'],
  //         time: temp[i]['time'],
  //         title: temp[i]['title'],
  //         description: temp[i]['description'],
  //         dealId: temp[i]['dealId'],
  //         propertyNameCode: temp[i]['propertyNameCode'],
  //         dealName: temp[i]['dealName'],
  //       ),
  //     ),
  //   );
  // }
  // return scheduleNote;



