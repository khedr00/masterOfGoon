import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/deals/deal_card_info/client_info_inside_deal_card.dart';

Future<ClientInfoInsideDealCard> getClientInfoInsideDealCard({
  required int dealId,
  CancelToken? cancelToken,
}) async {
  await Future.delayed(const Duration(seconds: 3));
  if (dealId == 1) {
    return ClientInfoInsideDealCard(
      clientPhoto: 'assets/images/profilePhoto-icon.png',
      clientName: 'aliAhmad',
      clientLeadScoring: 23,
    );
  }
  if (dealId == 2) {
    return ClientInfoInsideDealCard(
      clientPhoto: 'assets/images/profilePhoto-icon.png',
      clientName: 'aliAhmad1',
      clientLeadScoring: 24,
    );
  }
  if (dealId == 3) {
    return ClientInfoInsideDealCard(
      clientPhoto: 'assets/images/profilePhoto-icon.png',
      clientName: 'aliAhmad2',
      clientLeadScoring: 25,
    );
  }
  if (dealId == 4) {
    return ClientInfoInsideDealCard(
      clientPhoto: 'assets/images/profilePhoto-icon.png',
      clientName: 'aliAhmad4',
      clientLeadScoring: 25,
    );
  }
  if (dealId == 5) {
    return ClientInfoInsideDealCard(
      clientPhoto: 'assets/images/profilePhoto-icon.png',
      clientName: 'aliAhmad4',
      clientLeadScoring: 26,
    );
  }
  if (dealId == 6) {
    return ClientInfoInsideDealCard(
      clientPhoto: 'assets/images/profilePhoto-icon.png',
      clientName: 'aliAhmad5',
      clientLeadScoring: 27,
    );
  }
  return ClientInfoInsideDealCard(
    clientPhoto: 'assets/images/profilePhoto-icon.png',
    clientName: 'aliAhmad5',
    clientLeadScoring: 27,
  );
}
