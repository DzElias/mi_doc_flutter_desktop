import 'package:flutter/material.dart';
import 'package:midoc/blocs/patient/patient_bloc.dart';
import 'package:midoc/models/patient.dart';
import 'package:midoc/pages/patient/patient.dart';
import 'package:provider/provider.dart';

var tipoSangreList = ["O-", "O+", "A-", "A+", "B-", "B+", "AB-", "AB+"];
var seen = Set<String>();

class NewPatientPage extends StatefulWidget {
  const NewPatientPage({Key key}) : super(key: key);

  @override
  _NewPatientPageState createState() => _NewPatientPageState();
}

class _NewPatientPageState extends State<NewPatientPage> {
  String sexo = '';
  String tipoSangre = 'O-';
  var ciController = TextEditingController();
  var nameController = TextEditingController();
  var rucController = TextEditingController();
  var phoneController = TextEditingController();
  var mailController = TextEditingController();
  var dirController = TextEditingController();
  var obsController = TextEditingController();
  var fechaController = TextEditingController();

  List<String> uniqueList =
      tipoSangreList.where((element) => seen.add(element)).toList();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 900,
                height: 600,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurpleAccent.withOpacity(0.7),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Paciente.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.deepPurpleAccent),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: ciController,
                                decoration: InputDecoration(
                                    labelText: 'Cedula de identidad',
                                    prefixIcon: Icon(Icons.badge)),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text('Sexo: '),
                            SizedBox(
                              width: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                    activeColor: Colors.blue,
                                    value: 'Masc.',
                                    groupValue: sexo,
                                    onChanged: (value) {
                                      setState(() {
                                        sexo = value.toString();
                                      });
                                    }),
                                Text('Masc.')
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                    activeColor: Colors.pink,
                                    value: 'Femen.',
                                    groupValue: sexo,
                                    onChanged: (value) {
                                      setState(() {
                                        sexo = value.toString();
                                      });
                                    }),
                                Text('Femen.')
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Tipo de sangre: '),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: DropdownButton(
                                value: tipoSangre,
                                items: tipoSangreList
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e),
                                          value: e,
                                        ))
                                    .toList(),
                                onChanged: (val) => setState(() {
                                  tipoSangre = val as String;
                                }),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: rucController,
                            decoration: InputDecoration(
                                labelText: 'Ruc',
                                prefixIcon: Icon(Icons.badge)),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                                labelText: 'Nombre completo',
                                prefixIcon: Icon(Icons.person)),
                          ),
                        ), 
                        SizedBox(
                            width: 200,
                            child: TextFormField(
                              controller: fechaController,
                              decoration: InputDecoration(
                                  labelText: 'Fecha Nacimiento',
                                  prefixIcon: Icon(Icons.calendar_month)),
                              onTap: () async {
                                DateTime date = DateTime(1900);
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());

                                date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100));

                                if (date != null) {
                                  fechaController.text = '${date.day}/${date.month}/${date.year}';
                                }
                              },
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                                labelText: 'Telefono',
                                prefixIcon: Icon(Icons.phone)),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: mailController,
                            decoration: InputDecoration(
                                labelText: 'Mail',
                                prefixIcon: Icon(Icons.email)),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: dirController,
                            decoration: InputDecoration(
                                labelText: 'Direccion',
                                prefixIcon: Icon(Icons.location_city)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 500,
                          child: TextFormField(
                            controller: obsController,
                            decoration: InputDecoration(
                                labelText: 'Obs',
                                prefixIcon: Icon(Icons.edit_note)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async{
                            Patient patient = Patient(
                              ci: ciController.text, 
                              nombre: nameController.text ,
                              telefono: phoneController.text ,
                              mail: mailController.text ,
                              tipoSangre: tipoSangre ?? '',
                              obs: obsController.text ,
                              sexo: sexo,
                              fechaNacimiento: fechaController.text ,
                              ruc: rucController.text,
                              dir: dirController.text
                            );

                            await Provider.of<PatientBloc>(context, listen: false, ).createPatient(patient);
                            Navigator.pop(context);
                            Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                PatientPage(
                                                  patient:
                                                      patient,
                                                )));
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              decoration: BoxDecoration(
                                  color: Colors.deepPurpleAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Text('REGISTRAR',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
