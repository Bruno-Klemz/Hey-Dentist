import 'package:http/http.dart' as http;

class DentistAPI {
  Future<http.Response> createDentistFolder(
      {required String? userID, required String body}) async {
    final url = Uri.parse(
        "https://hey-dentist-default-rtdb.firebaseio.com/$userID.json");
    http.Response response = await http.put(url, body: body);
    return response;
  }

  Future<http.Response> createNewPacient(
      {required String? userID, required String body}) async {
    final url = Uri.parse(
        "https://hey-dentist-default-rtdb.firebaseio.com/$userID/Pacient.json");
    http.Response response = await http.patch(url, body: body);
    return response;
  }

  Future<http.Response> getDentistByID(String? userID) async {
    final url = Uri.parse(
        "https://hey-dentist-default-rtdb.firebaseio.com/$userID.json");

    http.Response response = await http.get(url);
    return response;
  }
}
