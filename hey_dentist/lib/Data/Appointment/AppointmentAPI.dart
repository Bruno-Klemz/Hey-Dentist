import 'package:http/http.dart' as http;

class AppointmentAPI {
  Future<void> createAppointment(
      {required String? userID,
      required String body, required String pacientName, required String date}) async {
    Uri url = Uri.parse('https://hey-dentist-default-rtdb.firebaseio.com/$userID/Appointment/$pacientName/$date.json');
    await http.patch(url, body: body);
  }
}
