import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';

import 'package:med_assistance/models/patient.dart';
import 'package:med_assistance/query_builder.dart';
import 'package:med_assistance/views/patient_details.dart';
import 'package:med_assistance/views/patient_form.dart';
import 'package:med_assistance/views/update_form.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  List patientsList = [];

  late AnimationController animationController;
  // ignore: prefer_typing_uninitialized_variables
  late var colorTween;

  showStatus({required Color color, required String text}) {

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Patient $text"),
            backgroundColor: color,
            padding: const EdgeInsets.all(15),
            behavior: SnackBarBehavior.fixed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )
        )
    );
  }


  deleteStatus(int id) async {
    int status = await QueryBuilder.instance.deletePatient(id);

    if(status == 0) {
      return;
    }
    showStatus(color: Colors.redAccent, text: "Deleted");
  }

  addStatus(Patient newPatient) async {
    int status = await QueryBuilder.instance.addPatient(newPatient);

    if(status == 0) {
      return;
    }

    Patient fetchedPatient = await QueryBuilder.instance.fetchPatient();

    setState(() {
      patientsList.add(fetchedPatient);
    });

    showStatus(color: Colors.lightBlueAccent, text: "Added");
  }

  updateStatus(Patient patient, int index) async {
    var updatedPatient = await Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => UpdateForm(patient: patient)
        ));

    if (updatedPatient == null){
      return;
    }

    int status = await QueryBuilder.instance.updatePatient(updatedPatient);

    if (status == 0) {
      return;
    }

    setState(() {
      patientsList[index] = updatedPatient;
    });


    showStatus(color: Colors.greenAccent, text: "Updated");
  }

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2)
    );
    colorTween = animationController.drive(
        ColorTween(
            begin: Colors.indigo,
            end: Colors.amber
        ));
    animationController.repeat();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medicine Assistance"),
      ),
      body: FutureBuilder(
        future: QueryBuilder.instance.patients(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        padding: const EdgeInsets.only(bottom: 10),
                        child: const Icon(Icons.error_outline,
                            size: 100,
                            color: Colors.redAccent
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Database Error: Problem Fetching Data",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1.5,
                              fontSize: 20
                          ),),
                      )
                    ],
                  )
              );
            }
            if (snapshot.hasData) {

              if(snapshot.data!.isEmpty) {
                return Center(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: Lottie.asset('assets/message.json'),
                        ),

                        const Text("No Existing Patient",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                            ))
                      ],
                    )
                );
              }
              else {
                patientsList.isEmpty ? patientsList = snapshot.data! : null;

                return SlidableAutoCloseBehavior(
                  closeWhenOpened: true,
                  child: Scrollbar(
                    trackVisibility: true,
                    interactive: true,
                    thickness: 8.0,
                    radius: const Radius.circular(5),
                    child: ListView.builder(
                        itemCount: patientsList.length,
                        itemBuilder: (context, index) {
                          final patient = patientsList[index];

                          return Card(
                            margin: const EdgeInsets.only(top: 1, bottom: 0.6),
                            child: Slidable(
                              key: UniqueKey(),
                              endActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                      icon: Icons.mode_edit_outlined,
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      label: "Update",
                                      onPressed: (context) =>
                                          setState(() {
                                            updateStatus(patient, index);
                                          })
                                  ),
                                  SlidableAction(
                                      icon: Icons.delete,
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      label: "Delete",
                                      onPressed: (context) {
                                        deleteStatus(patient.id!);
                                        setState(() {
                                          patientsList.removeAt(index);
                                        });
                                      }
                                  )
                                ],
                              ), child: ListTile(
                                title: Text(patient.name),
                                trailing: const Icon(Icons.arrow_back_ios),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context) => PatientDetails(patient: patient)
                                      ));
                                }
                            ),
                            ),
                          );
                        }),
                  ),
                );
              }
            }

          }
          return Center(
              child: CircularProgressIndicator(
                valueColor: colorTween,
              )
          );
        }

        ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newPatient = await Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => PatientForm(listLength: patientsList.length),
              ));
          if (newPatient == null) {
            return;
          }
          addStatus(newPatient);

        },
        child: const Icon(Icons.person_add_alt_sharp),
      ),
    );
  }
}
