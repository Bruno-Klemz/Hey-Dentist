import 'package:http/http.dart' as http;
class DentistAPI {
  Future<http.Response> createDentistFolder({required String? userID, required String body}) async {
    final url = Uri.parse("https://hey-dentist-default-rtdb.firebaseio.com/$userID.json");
    http.Response response = await http.put(url, body: body);
    return response;
  }
}
