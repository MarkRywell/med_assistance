class Patient {

  final String id;
  final String name;
  final int age;
  final String dateAdmitted;
  final String diseaseDetails;
  final String medicines;

  Patient({
    required this.id,
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

}