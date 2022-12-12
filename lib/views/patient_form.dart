import 'package:flutter/material.dart';

class PatientForm extends StatefulWidget {

  const PatientForm({Key? key}) : super(key: key);

  @override
  State<PatientForm> createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {

  var formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController diseaseController = TextEditingController();
  TextEditingController medicinesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Patient"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      return value == null || value.isEmpty ? "Enter patient's name" : null;
                    },
                  ),
                  TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      return value == null || value.isEmpty ? "Enter patient's age" : null;
                    },
                  ),

                  //DATE PICKER HERE

                  TextFormField(
                    controller: diseaseController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: "Disease Details",
                        border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      return value == null || value.isEmpty ? "Enter patient's disease details" : null;
                    },
                  ),
                  TextFormField(
                    controller: medicinesController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: "Medicines",
                        border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      return value == null || value.isEmpty ? "Enter patient's medicine to administer" : null;
                    },
                  ),

                ],
              ),
            )
        ),
      )
    );
  }
}
