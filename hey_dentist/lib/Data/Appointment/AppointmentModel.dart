class Appointment {
  final String pacientName, dentistName, date, initialHour, endHour, procedure;

  Appointment({
    required this.pacientName,
    required this.dentistName,
    required this.date,
    required this.initialHour,
    required this.endHour,
    required this.procedure
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
        pacientName: json['PacientName'],
        dentistName: json['DentistName'],
        date: json['Date'],
        initialHour: json['InitialHour'],
        endHour: json['EndHour'], procedure: json['Procedure']);
  }

  Map<String, dynamic> toJson() => {
        'PacientName': pacientName,
        'DentistName': dentistName,
        'Date': date,
        'InitialHour': initialHour,
        'EndHour': endHour, 'Procedure': procedure
      };
}
