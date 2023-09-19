import 'package:flutter/material.dart';
import 'package:midoc/models/patient.dart';
import 'package:midoc/pages/patient/widgets/history_page.dart';
import 'package:midoc/pages/patient/widgets/information_page.dart';

class PatientPage extends StatefulWidget {
  final Patient patient;

  const PatientPage({this.patient});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  String pagestate = '';

  @override
  void initState() {
    pagestate = 'information';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: const Text("Volver",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.deepPurpleAccent.shade200,
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 900,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (pagestate != 'information') {
                          pagestate = 'information';
                        }
                      });
                    },
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: (pagestate == 'information')
                            ? Colors.grey.shade300
                            : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                          child: Text(
                        'Información',
                        style: TextStyle(
                            color: (pagestate == 'information')
                                ? Colors.deepPurpleAccent.shade200
                                : Colors.deepPurpleAccent.shade400,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (pagestate != 'history') {
                          pagestate = 'history';
                        }
                      });
                    },
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: (pagestate == 'information') ? Colors.white : Colors.grey.shade300,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                          child: Text(
                        'Historia clínica',
                        style: TextStyle(
                            color: (pagestate == 'information') ? Colors.deepPurpleAccent.shade400 : Colors.deepPurpleAccent.shade200,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 900,
            height: 600,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurpleAccent.withOpacity(0.7),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: (pagestate == 'information')
                ? InformationPage(patient: widget.patient,)
                : HistoryPage(cedulaPaciente: widget.patient.ci,),
          )
        ])));
  }
}



