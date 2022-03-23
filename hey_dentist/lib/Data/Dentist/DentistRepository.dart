import 'dart:convert';

import 'DentistAPI.dart';

class DentistRepository {
  final DentistAPI api;
  DentistRepository({required this.api});

  Future<int> createDentistFolder(
      {required String? userID,
      required String userName,
      required String clinicName}) async {
    String json = jsonEncode({
      'userInfos': {'username': userName, 'clinicName': clinicName}
    });
    int responseBody =
        (await api.createDentistFolder(userID: userID, body: json)).statusCode;
    return responseBody;
  }
}
