import 'package:flutter/material.dart';
import 'package:med_assistance/models/patient.dart';

class PatientDetails extends StatefulWidget {

  final Patient patient;

  const PatientDetails({
    required this.patient,
    Key? key}) : super(key: key);

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> with SingleTickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState(){
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Patient's Details"),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.person_search_rounded),
            )
          ],
        ),
        body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.3,
                    child: Stack(
                      children: [
                        Container(
                            height: size.height * 0.25,
                            color: Colors.red
                        ),
                        const Positioned(
                            left: 10,
                            bottom: 10,
                            child: CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 75,
                                child: Icon(Icons.person),
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          width: size.width,
                          child: Text(widget.patient.name,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              )),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 10,
                    color: Colors.grey,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                          controller: tabController,
                          isScrollable: true,
                          labelColor: Colors.blue[900],
                          unselectedLabelColor: Colors.grey[600],
                          indicatorSize: TabBarIndicatorSize.tab,

                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.teal[100]
                          ),

                          tabs: [
                            const Tab(text: "Personal Info"),
                            const Tab(text: "Medical Info"),
                          ]
                      ),
                    ),
                  ),
                  const Divider(thickness: 1),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: size.height * 0.3,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Text("Age",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                  )),
                                ),
                                const VerticalDivider(width: 50),
                                SizedBox(
                                  width: 100,
                                  child: Text(": ${widget.patient.age}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14
                                      )),
                                ),
                              ],
                            )
                          ),
                          Container(

                          )
                        ],
                      )
                  )
                ],
              ),
            )
        )
    );
  }
}
