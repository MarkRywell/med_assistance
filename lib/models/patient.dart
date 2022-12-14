class Patient {

  int? id;
  final String name;
  final int age;
  final String dateAdmitted;
  final String diseaseDetails;
  final String medicines;

  Patient({
    this.id,
    required this.name,
    required this.age,
    required this.dateAdmitted,
    required this.diseaseDetails,
    required this.medicines
  });

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name': name,
      'age' : age,
      'dateAdmitted' : dateAdmitted,
      'diseaseDetails' : diseaseDetails,
      'medicines' : medicines
    };
  }

  factory Patient.fromMap(Map <String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      dateAdmitted: json['dateAdmitted'],
      diseaseDetails: json['diseaseDetails'],
      medicines: json['medicines']
    );
  }

  factory Patient.fromMapObject(Map <String, Object?> json) {
    return Patient(
        id: json['id'] as int,
        name: json['name'] as String,
        age: json['age'] as int,
        dateAdmitted: json['dateAdmitted'] as String,
        diseaseDetails: json['diseaseDetails'] as String,
        medicines: json['medicines'] as String
    );
  }
}