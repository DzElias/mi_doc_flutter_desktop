import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midoc/blocs/patient/patient_bloc.dart';
import 'package:midoc/models/patient.dart';
import 'package:midoc/pages/home/widgets/searchWidget.dart';
import 'package:midoc/pages/new_patient.dart/new_patient.dart';
import 'package:midoc/pages/patient/patient.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Patient> patientsFiltered = [];
  @override
  void initState() {
    Provider.of<PatientBloc>(context, listen: false).getPatients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurpleAccent.shade200,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 900,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          border: Border.all(color: Colors.deepPurpleAccent)),
                      width: 300,
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Buscar Paciente',
                            labelStyle:
                                TextStyle(color: Colors.deepPurpleAccent),
                            suffixIcon: Icon(Icons.search),
                            iconColor: Colors.deepPurpleAccent,
                            fillColor: Colors.deepPurpleAccent,
                            focusColor: Colors.deepPurpleAccent,
                            suffixIconColor: Colors.deepPurpleAccent,
                            hoverColor: Colors.deepPurpleAccent),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              patientsFiltered = [];
                            });
                          }
                          var state =
                              Provider.of<PatientBloc>(context, listen: false)
                                  .state;
                          if (state is LoadedPatients) {
                            var patientsList = state.patients;
                            List<Patient> filtered = patientsList
                                .where((element) =>
                                    (element.ci.toLowerCase().contains(value) ||
                                        element.nombre
                                            .toLowerCase()
                                            .contains(value)))
                                .toList();
                            setState(() {
                              patientsFiltered = filtered;
                            });
                          }
                        },
                      ),
                    ),
                    MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: NewPatientWidget())
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
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
                child: BlocBuilder<PatientBloc, PatientState>(
                  builder: (context, state) {
                    if (state is LoadedPatients && state.patients.isEmpty) {
                      return const Center(
                        child: Text("Registra un paciente para comenzar..."),
                      );
                    }
                    if (state is LoadedPatients) {
                      return PatientsListView(
                        patients: (patientsFiltered.isEmpty)
                            ? state.patients
                            : patientsFiltered,
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class PatientsListView extends StatelessWidget {
  final List<Patient> patients;
  const PatientsListView({
    this.patients,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: patients.length,
        itemBuilder: (_, i) {
          Patient patient = patients[i];
          return Container(
            child: (i == 0)
                ? Column(
                    children: [
                     Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Center(
                                  child: Text(
                                'Cedula',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                            ),
                            SizedBox(
                              width: 300,
                              child: Center(
                                  child: Text('Nombre/Apellido',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))),
                            ),
                            SizedBox(
                              width: 100,
                              child: Center(
                                  child: Text('Telefono',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))),
                            ),
                            SizedBox(
                              width: 300,
                              child: Center(
                                  child: Text('Mail',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Center(
                                  child: Text(
                                patient.ci,
                                style: const TextStyle(fontSize: 18),
                              )),
                            ),
                            SizedBox(
                              width: 300,
                              child: Center(
                                  child: Text(patient.nombre,
                                      style: const TextStyle(fontSize: 18))),
                            ),
                            SizedBox(
                              width: 100,
                              child: Center(
                                  child: Text(patient.telefono,
                                      style: const TextStyle(fontSize: 18))),
                            ),
                            SizedBox(
                              width: 300,
                              child: Center(
                                  child: Text(patient.mail,
                                      style: const TextStyle(fontSize: 18))),
                            ),
                            MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => PatientPage(
                                                  patient: patient,
                                                )));
                                  },
                                ))
                          ]),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 100,
                            child: Center(
                                child: Text(
                              patient.ci,
                              style: const TextStyle(fontSize: 18),
                            )),
                          ),
                          SizedBox(
                            width: 300,
                            child: Center(
                                child: Text(patient.nombre,
                                    style: const TextStyle(fontSize: 18))),
                          ),
                          SizedBox(
                            width: 100,
                            child: Center(
                                child: Text(patient.telefono,
                                    style: const TextStyle(fontSize: 18))),
                          ),
                          SizedBox(
                            width: 300,
                            child: Center(
                                child: Text(patient.mail,
                                    style: const TextStyle(fontSize: 18))),
                          ),
                          MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => PatientPage(
                                                patient: patient,
                                              )));
                                },
                              ))
                        ]),
                  ),
          );
        });
  }
}

class NewPatientWidget extends StatelessWidget {
  const NewPatientWidget();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const NewPatientPage())),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
            child: Text(
          'Registrar paciente',
          style:
              TextStyle(fontSize: 18, color: Colors.deepPurpleAccent.shade400),
        )),
      ),
    );
  }
}
