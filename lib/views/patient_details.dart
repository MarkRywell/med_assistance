import 'package:flutter/material.dart';

class PatientDetails extends StatelessWidget {

  const PatientDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient's Details"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(

          ),
        )
      )
    );
  }
}
