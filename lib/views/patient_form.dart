import 'package:flutter/material.dart';
import 'package:med_assistance/models/patient.dart';

class PatientForm extends StatefulWidget {

  final int listLength;
  const PatientForm({
    required this.listLength,
    Key? key}) : super(key: key);

  @override
  State<PatientForm> createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {

  var formKey = GlobalKey<FormState>();

  DateTime date = DateTime.now();

  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  TextEditingController diseaseController = TextEditingController();
  TextEditingController medicinesController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Patient"),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: TextFormField(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: TextFormField(
                        controller: ageController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            labelText: "Age",
                            border: OutlineInputBorder()
                        ),
                        validator: (value) {
                          return value == null || value.isEmpty ? "Enter patient's age" : null;
                        },
                      ),
                    ),

                    //DATE PICKER HERE
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Container(
                        width: size.width,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Colors.grey,
                              width: 1
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text('${date.month}/${date.day}/${date.year}',
                                style: const TextStyle(
                                    fontSize: 16
                                ),),
                            ),
                            const VerticalDivider(width: 180),
                            ElevatedButton(
                                onPressed: () async {
                                  DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: date,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100)
                                  );
                                  if(newDate == null){
                                    return;
                                  }
                                  setState(() {
                                    date = newDate;
                                  });
                                },
                                child: const Icon(Icons.calendar_month))
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: TextFormField(
                        controller: diseaseController,
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        decoration: const InputDecoration(
                            labelText: "Disease Details",
                            border: OutlineInputBorder()
                        ),
                        validator: (value) {
                          return value == null || value.isEmpty ? "Enter patient's disease details" : null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: TextFormField(
                        controller: medicinesController,
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        decoration: const InputDecoration(
                            labelText: "Medicines",
                            border: OutlineInputBorder()
                        ),
                        validator: (value) {
                          return value == null || value.isEmpty ? "Enter patient's medicine to administer" : null;
                        },
                      ),
                    ),
                    const SizedBox(height:50),
                    SizedBox(
                        height: 40,
                        width: size.width,
                        child: ElevatedButton(
                          onPressed: () {

                            if(formKey.currentState!.validate()) {
                              Patient newPatient = Patient(
                                  name: nameController.text,
                                  age: int.parse(ageController.text),
                                  dateAdmitted: date.toString(),
                                  diseaseDetails: diseaseController.text,
                                  medicines: medicinesController.text);

                              Navigator.pop(context, newPatient);


                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Add Patient"),
                              VerticalDivider(width: 10),
                              Icon(Icons.person_add_alt_1_outlined)
                            ],
                          ),
                        )
                    )
                  ],
                ),
              )
          ),
        )
    );
  }
}
