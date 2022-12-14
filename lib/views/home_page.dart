import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:med_assistance/query_builder.dart';
import 'package:med_assistance/views/patient_details.dart';
import 'package:med_assistance/views/patient_form.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  List patients = [
    {

    }
  ];

  late AnimationController animationController;
  late var colorTween;

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
          // if(snapshot.connectionState == ConnectionState.done) {
          //   if (snapshot.hasError) {
          //     return Center(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Container(
          //               width: 100,
          //               height: 100,
          //               padding: const EdgeInsets.only(bottom: 10),
          //               child: const Icon(Icons.error_outline,
          //                   size: 100,
          //                   color: Colors.redAccent
          //               ),
          //             ),
          //             const Padding(
          //               padding: EdgeInsets.all(20),
          //               child: Text("Database Error: Problem Fetching Data",
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                     height: 1.5,
          //                     fontSize: 20
          //                 ),),
          //             )
          //           ],
          //         )
          //     );
          //   }
            if (snapshot.hasData) {

              patients.isEmpty ? patients = snapshot.data! : null;

              SlidableAutoCloseBehavior(
                closeWhenOpened: true,
                child: Scrollbar(
                  trackVisibility: true,
                  interactive: true,
                  thickness: 8.0,
                  radius: const Radius.circular(5),
                  child: ListView.builder(
                      itemCount: patients.length,
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
              );
            }
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
          // return Center(
          //     child: CircularProgressIndicator(
          //       valueColor: colorTween,
          //     )
          // );
        ,
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
