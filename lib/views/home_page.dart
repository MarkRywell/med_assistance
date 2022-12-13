import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:med_assistance/views/patient_details.dart';
import 'package:med_assistance/views/patient_form.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List patient = [
    {

    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medicine Assistance"),
      ),
      body: SlidableAutoCloseBehavior(
        closeWhenOpened: true,
        child: Scrollbar(
          trackVisibility: true,
          interactive: true,
          thickness: 8.0,
          radius: const Radius.circular(5),
          child: ListView.builder(
              itemCount: patient.length,
              itemBuilder: (context, index) {


                return Card(
                  margin: const EdgeInsets.only(top: 1, bottom: 0.6),
                  child: Slidable(
                    key: UniqueKey(),
                    endActionPane: const ActionPane(
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                          icon: Icons.mode_edit_outlined,
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          label: "Update",
                          onPressed: null,
                        ),
                        SlidableAction(
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          label: "Delete",
                          onPressed: null,
                        )
                      ],
                    ), child: ListTile(
                      title: const Text("Mark Gaje"),
                      trailing: const Icon(Icons.arrow_back_ios),
                      onTap: () {
                          Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => PatientDetails()
                          ));
                      }
                  ),
                  ),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => PatientForm(),
              ));
        },
        child: const Icon(Icons.person_add_alt_sharp),
      ),
    );
  }
}
