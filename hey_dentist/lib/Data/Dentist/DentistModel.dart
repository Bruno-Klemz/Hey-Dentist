class Dentist {
  final String clinicName, userName;
  final List<Appointment> appointmentList;
  final List<Pacient> pacientList;

  Dentist(
      {required this.appointmentList,
      required this.pacientList,
      required this.clinicName,
      required this.userName});
}

class Pacient {
  final String name, lastName, birthDay;
  final int id;
  final String? rg, cpf;

  Pacient(
      {required this.name,
      required this.lastName,
      required this.birthDay,
      required this.id,
      this.rg,
      this.cpf});

  factory Pacient.fromJson(Map<String, dynamic> json) {
    return Pacient(
        name: json['name'],
        lastName: json['lastName'],
        birthDay: json['birthDay'],
        id: json['id'],
        rg: json['rg']);
  }
}

class Appointment {
  final String pacientName, date, hour;
  final String? procedure, tools, observations;

  Appointment(
      {required this.pacientName,
      required this.date,
      required this.hour,
      this.procedure,
      this.tools,
      this.observations});
}
