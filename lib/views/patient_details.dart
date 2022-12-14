import 'package:flutter/material.dart';
import 'package:med_assistance/models/patient.dart';

class PatientDetails extends StatelessWidget {

  final Patient patient;

  const PatientDetails({
    required this.patient,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient's Details"),
        actions: const [
          Icon(Icons.person_pin_sharp)
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(patient.id.toString()),
              Text(patient.name),
              Text(patient.diseaseDetails)
            ],
          ),
        )
      )
    );
  }
}
