import 'package:flutter/material.dart';
import 'package:med_assistance/models/patient.dart';
import 'package:med_assistance/query_builder.dart';

class UpdateForm extends StatefulWidget {

  final Patient patient;

  const UpdateForm({
    required this.patient,
    Key? key}) : super(key: key);

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {

  var formKey = GlobalKey<FormState>();

  DateTime date = DateTime.now();

  late TextEditingController nameController = TextEditingController(text: widget.patient.name);
  late TextEditingController ageController = TextEditingController(text: (widget.patient.age).toString());

  late TextEditingController diseaseController = TextEditingController(text: widget.patient.diseaseDetails);
  late TextEditingController medicinesController = TextEditingController(text: widget.patient.medicines);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Update Patient"),
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
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text('Date Admitted',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.6)
                                  ),),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text('${date.month}/${date.day}/${date.year}',
                                  style: const TextStyle(
                                      fontSize: 16
                                  ),),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: ElevatedButton(
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
                                  child: const Icon(Icons.calendar_month)),
                            )
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
                          onPressed: () async {

                            if(formKey.currentState!.validate()) {
                              Patient updatedPatient = Patient(
                                  id: widget.patient.id,
                                  name: nameController.text,
                                  age: int.parse(ageController.text),
                                  dateAdmitted: date.toString(),
                                  diseaseDetails: diseaseController.text,
                                  medicines: medicinesController.text);

                              await QueryBuilder.instance.updatePatient(updatedPatient);

                              Navigator.pop(context, updatedPatient);

                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Update Patient"),
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
