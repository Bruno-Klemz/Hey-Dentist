class Appointment {
  final String pacientName, dentistName, date, initialHour, endHour;

  Appointment({
    required this.pacientName,
    required this.dentistName,
    required this.date,
    required this.initialHour,
    required this.endHour,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
        pacientName: json['PacientName'],
        dentistName: json['DentistName'],
        date: json['Date'],
        initialHour: json['InitialHour'],
        endHour: json['EndHour']);
  }

  Map<String, dynamic> toJson() => {
        'PacientName': pacientName,
        'DentistName': dentistName,
        'Date': date,
        'InitialHour': initialHour,
        'EndHour': endHour
      };
}
