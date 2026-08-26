import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/back_end_test/personal_and_deals_schedule_info.dart/schedule_deal_note.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/notes_variations/deal_note_widget.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/deals_only_schedule_widget/deals_notes_widget.dart';

Future<List<DealsNotesWidget>> getSingleDealScheduleInfo({
  required String dealId,
  CancelToken? cancelToken,
  required UserAuthInfo userAuthInfo,
}) async {
  DioClient dioClient = DioClient(userAuthInfo: userAuthInfo);

  List<dynamic> temp = [];

  try {
    final dynamic response;
    response = await dioClient.dio.get('${base}api/v1/deals/$dealId/schedules');
    temp = response.data['data'];
  } on DioException catch (e) {
    if (CancelToken.isCancel(e)) {
      throw Exception('Request cancelled');
    }

    if (e.response != null) {
      throw Exception(e.response?.data['message'] ?? 'Server Error');
    }

    throw Exception('Connection Error get Deals schedule only');
  } catch (e) {
    throw Exception(e);
  }

  // A meeting is duplicated for participants. Only the accepted copy belongs
  // in the deal schedule; leave every non-meeting schedule unchanged.
  final schedules = temp.where((item) {
    return item['title'] != 'MEETING' || item['acceptOn'] != null;
  }).toList();

  List<DealsNotesWidget> result = [];

  String? currentDate;
  List<DealNoteWidget> currentNotes = [];

  for (int i = 0; i < schedules.length; i++) {
    final item = schedules[i];

    if (item['date'].toString().substring(0, 10) != currentDate) {
      if (currentNotes.isNotEmpty) {
        result.add(
          DealsNotesWidget(dealApoitmentNotes: List.from(currentNotes)),
        );
      }

      currentDate = item['date'].toString().substring(0, 10);
      currentNotes = [];
    }
    currentNotes.add(
      DealNoteWidget(
        scheduleDealNote: ScheduleDealNote(
          employeeId: 1,
          date: item['date'].toString().substring(0, 10),
          time:
              '${DateTime.parse(item['date']).hour.toString().padLeft(2, '0')}:${DateTime.parse(item['date']).minute.toString().padLeft(2, '0')}',
          title: item['title'],
          description: item['description'],
          dealId: dealId,
          propertyNameCode: '',
          dealName: '',
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



