import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/back_end_test/personal_and_deals_schedule_info.dart/schedule_deal_note.dart';
import 'package:untitled1/back_end_test/personal_and_deals_schedule_info.dart/schedule_note.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/notes_variations/deal_note_widget.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/notes_variations/personal_note_widget.dart';

Future<dynamic> getPersonalAndDealsScheduleInfo({
  required UserAuthInfo userAuthInfo,
  required DateTime dateTime,
  CancelToken? cancelToken,
}) async {
  DioClient dioClient = DioClient(userAuthInfo: userAuthInfo);

  final startOfDay = DateTime.utc(dateTime.year, dateTime.month, dateTime.day);

  final endOfDay = startOfDay.add(const Duration(days: 1));

  final newIsoDate = startOfDay.toIso8601String();
  final nextIsoDate = endOfDay.toIso8601String();
  List<dynamic> temp;

  try {
    final dynamic response;
    response = await dioClient.dio.get(
      '${base}api/v1/schedules?date[gte]=$newIsoDate&date[lt]=$nextIsoDate',
    );
    temp = response.data['data'];
  } on DioException catch (e) {
    if (CancelToken.isCancel(e)) {
      throw Exception('Request cancelled');
    }

    if (e.response != null) {
      throw Exception(e.response?.data['message'] ?? 'Server Error');
    }

    throw Exception('Connection Error get personal and Deals schedule');
  } catch (e) {
    throw Exception(e);
  }

  // List<Map<String, dynamic>> temp = [
  //   {
  //     'time': '1:00',
  //     'title': 'call ahmad 1',
  //     'description':
  //         "don't forget about theasdfaefaewfewfawefasfasdf pool and the garden jhjdh jpap8eq[fqvm [opepifqew [AP[qw--jdOAISSIDUSDF]]]]",
  //   },
  //   {
  //     'time': '1:00',
  //     'title': 'call ahmad 2',
  //     'description':
  //         "don't forget about theasdfaefaewfewfawefasfasdf pool and the garden jhjdh jpap8eq[fqvm [opepifqew [AP[qw--jdOAISSIDUSDF]]]]",
  //   },
  //   {
  //     'time': '2:00',
  //     'title': '1',
  //     'description':
  //         "don't forget about theasdfaefaewfewfawefasfasdf pool and the garden jhjdh jpap8eq[fqvm [opepifqew [AP[qw--jdOAISSIDUSDF]]]]",
  //   },
  //   {
  //     'time': '2:00',
  //     'title': '2',
  //     'description': 'akucasdfasdfasdfasdfasdfdgl',
  //     'dealId': 1,
  //     'dealName': 'Request to Buy Property Homs City',
  //     'propertyNameCode': 'V_234',
  //   },
  //   {
  //     'time': '4:00',
  //     'title': 'call ahmad 3',
  //     'description':
  //         "don't forget about theasdfaefaewfewfawefasfasdf pool and the garden jhjdh jpap8eq[fqvm [opepifqew [AP[qw--jdOAISSIDUSDF]]]]",
  //   },
  //   {
  //     'time': '5:00',
  //     'title': 'call ahmad 4',
  //     'description':
  //         "don't forget about theasdfaefaewfewfawefasfasdf pool and the garden jhjdh jpap8eq[fqvm [opepifqew [AP[qw--jdOAISSIDUSDF]]]]",
  //   },
  //   {
  //     'time': '7:00',
  //     'title': 'call ahmad 5',
  //     'description':
  //         "don't forget about theasdfaefaewfewfawefasfasdf pool and the garden jhjdh jpap8eq[fqvm [opepifqew [AP[qw--jdOAISSIDUSDF]]]]",
  //   },
  //   {
  //     'time': '2:00',
  //     'title': '2',
  //     'description': 'akucasdfasdfasdfasdfasdfdgl',
  //     'dealId': 1,
  //     'dealName': 'Request to Buy Property Homs City',
  //     'propertyNameCode': 'V_234',
  //   },
  //   {
  //     'time': '2:00',
  //     'title': '2',
  //     'description': 'akucasdfasdfasdfasdfasdfdgl',
  //     'dealId': 1,
  //     'dealName': 'Request to Buy Property Homs City',
  //     'propertyNameCode': 'V_234',
  //   },
  //   {
  //     'time': '2:00',
  //     'title': '2',
  //     'description': 'akucasdfasdfasdfasdfasdfdgl',
  //     'dealId': 1,
  //     'dealName': 'Request to Buy Property Homs City',
  //     'propertyNameCode': 'V_234',
  //   },
  // ];

  // A meeting exists once per participant. Keep only its accepted copy; all
  // other schedule types must remain untouched.
  final schedules = temp.where((item) {
    return item['title'] != 'MEETING' || item['acceptOn'] != null;
  }).toList();

  List<dynamic> scheduleNote = [];
  for (int i = 0; i < schedules.length; i++) {
    if (schedules[i]['type'] == 'BUY_RENT_DEAL' ||
        schedules[i]['type'] == 'SALE_LEASE_DEAL') {
      scheduleNote.add(
        DealNoteWidget(
          scheduleDealNote: ScheduleDealNote(
            employeeId: 1,
            time:
                '${DateTime.parse(schedules[i]['date']).hour.toString().padLeft(2, '0')}:${DateTime.parse(schedules[i]['date']).minute.toString().padLeft(2, '0')}',
            title: schedules[i]['title'],
            description: schedules[i]['description'],
            dealId: schedules[i]['type'] == 'BUY_RENT_DEAL'
                ? schedules[i]['buyRentDeal']['id']
                : schedules[i]['saleLeaseDeal']['id'],
            propertyNameCode: '',
            dealName: '',
          ),
        ),
      );
    } else {
      scheduleNote.add(
        PersonalNoteWidget(
          scheduleNote: ScheduleNote(
            time:
                '${DateTime.parse(schedules[i]['date']).hour.toString().padLeft(2, '0')}:${DateTime.parse(schedules[i]['date']).minute.toString().padLeft(2, '0')}',
            title: schedules[i]['title'],
            description: schedules[i]['description'],
          ),
        ),
      );
    }
  }

  return scheduleNote;
}
