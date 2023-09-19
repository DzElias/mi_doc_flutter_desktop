import 'package:flutter/material.dart';
import 'package:midoc/blocs/patient/patient_bloc.dart';
import 'package:midoc/models/patient.dart';
import 'package:provider/provider.dart';

var tipoSangreList = ["O-", "O+", "A-", "A+", "B-", "B+", "AB-", "AB+"];

class InformationPage extends StatefulWidget {
  const InformationPage({ this.patient});
  final Patient patient;

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
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

  @override
  void initState() {
    super.initState();
    sexo = widget.patient.sexo;
    tipoSangre = widget.patient.tipoSangre;
    ciController.text = widget.patient.ci;
    nameController.text = widget.patient.nombre;
    rucController.text = widget.patient.ruc;
    phoneController.text = widget.patient.telefono;
    mailController.text = widget.patient.mail;
    dirController.text = widget.patient.dir;
    obsController.text = widget.patient.obs;
    fechaController.text = widget.patient.fechaNacimiento;
  }

  @override
  void setState(VoidCallback fn) {
    
    super.setState(fn);
    onChange(); 
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${ciController.text} - ${nameController.text}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.deepPurpleAccent.shade400)),
                    const Text('Los cambios se guardan automaticamente.', style: TextStyle(fontSize: 14),),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text('Sexo: '),
                const SizedBox(
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
                    const Text('Masc.')
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
                    const Text('Femen.')
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const Text('Tipo de sangre: '),
                const SizedBox(
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
            ),
            SizedBox(
                width: 200,
                child: TextFormField(
                  controller: fechaController,
                  decoration: const InputDecoration(
                      labelText: 'Fecha Nacimiento',
                      prefixIcon: Icon(Icons.calendar_month)),
                  onTap: () async {
                    DateTime date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());

                    date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));

                    if (date != null) {
                      fechaController.text =
                          '${date.day}/${date.month}/${date.year}';
                      onChange();
                    }
                  },
                )),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200,
              child: TextFormField(
                controller: phoneController,
                onChanged: (value){
                  onChange();
                },
                decoration: const InputDecoration(
                    labelText: 'Telefono', prefixIcon: Icon(Icons.phone)),
              ),
            ),
            SizedBox(
              width: 200,
              child: TextFormField(
                onChanged: (value){
                  onChange();
                },
                controller: mailController,
                decoration: const InputDecoration(
                    labelText: 'Mail', prefixIcon: Icon(Icons.email)),
              ),
            ),
            SizedBox(
              width: 200,
              child: TextFormField(
                onChanged: (value){
                  onChange();
                },
                controller: dirController,
                decoration: const InputDecoration(
                    labelText: 'Direccion',
                    prefixIcon: Icon(Icons.location_city)),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200,
              child: TextFormField(
                onChanged: (value){
                  onChange();
                },
                controller: rucController,
                decoration: const InputDecoration(
                    labelText: 'Ruc', prefixIcon: Icon(Icons.badge)),
              ),
            ),
            SizedBox(
              width: 500,
              child: TextFormField(
                onChanged: (value){
                  onChange();
                },
                controller: obsController,
                decoration: const InputDecoration(
                    labelText: 'Obs', prefixIcon: Icon(Icons.edit_note)),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 100,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                  showDeletePatientDialog(context, widget.patient.ci);
                },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Text(
                    'ELIMINAR PACIENTE',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<dynamic> showDeletePatientDialog(BuildContext context, String patientId) {
    return showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: const Text(
                              'Seguro que quieres eliminar al paciente?'),
                          actions: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancelar',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                            const SizedBox(width: 20,),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: ()async{
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Provider.of<PatientBloc>(context, listen: false).deletePatient(patientId);
                                },
                                child: const Text(
                                  'Confirmar',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              ),
                            )
                          ],
                        ));
  }
  onChange()async{
    Patient patientToUpdate = Patient(
      id: widget.patient.id,
      sexo: sexo,
      tipoSangre: tipoSangre ?? '',
      ci: ciController.text,
      nombre: nameController.text,
      ruc: rucController.text,
      telefono: phoneController.text,
      mail: mailController.text,
      dir: dirController.text,
      obs: obsController.text,
      fechaNacimiento: fechaController.text

    );

    await Provider.of<PatientBloc>(context, listen: false).updatePatient(patientToUpdate);
  }
}
