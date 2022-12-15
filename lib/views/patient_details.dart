import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_assistance/custom_widgets/custom_text.dart';
import 'package:med_assistance/models/patient.dart';
import 'package:lottie/lottie.dart';

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

  late var date = DateFormat('E, d MMM yyyy HH:mm').format(DateTime.parse(widget.patient.dateAdmitted));

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.3,
                child: Stack(
                  children: [
                    Container(
                        height: size.height * 0.25,
                        width: size.width,
                        color: Colors.tealAccent.withOpacity(0.4),
                        child: Lottie.network('https://assets8.lottiefiles.com/packages/lf20_vPnn3K.json')
                    ),
                     Positioned(
                        left: 10,
                        bottom: 10,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 75,
                            backgroundColor: Colors.tealAccent.withOpacity(0.8),
                            child: Lottie.network('https://assets7.lottiefiles.com/packages/lf20_5aaicf2r.json',
                              fit: BoxFit.fill
                          ),
                          )
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

                      tabs: const [
                        Tab(text: "Personal Info"),
                        Tab(text: "Medical Info"),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(icon: const Icon(Icons.numbers), textTitle: 'Age', textData: widget.patient.age.toString())
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(icon: const Icon(Icons.date_range), textTitle: 'Date \nAdmitted', textData: date),
                          CustomText(icon: const Icon(Icons.medical_information_outlined), textTitle: 'Disease \nDetails', textData: widget.patient.diseaseDetails),
                          CustomText(icon: const Icon(Icons.medication_rounded), textTitle: 'Medicines', textData: widget.patient.medicines)
                        ],
                      )
                    ],
                  )
              )
            ],
          ),
        )
    );
  }
}
