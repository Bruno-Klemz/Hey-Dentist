class Clinic {
  final String name;
  final List<Dentist> dentistList;

  Clinic({required this.name, required this.dentistList});

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(name: json['Name'], dentistList: json['DentistList']);
  }
}

class Dentist {
  final String name, userID;

  Dentist({required this.name, required this.userID});

  factory Dentist.fromJson(Map<String, dynamic> json) {
    return Dentist(name: json['Name'], userID: json['ID']);
  }
}
