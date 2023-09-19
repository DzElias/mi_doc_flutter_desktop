import 'package:flutter/material.dart';
import 'package:midoc/data/mongo.dart';
import 'package:midoc/models/history.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage( {this.cedulaPaciente});

  final String cedulaPaciente;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<History> patientHistory = [];
  var motivoController = TextEditingController();
  var tratamientoController = TextEditingController();
  var diagnosticoController = TextEditingController();
  var pronosticoController = TextEditingController();
  var obsController = TextEditingController();

  History notNewHistory;

  @override
  void initState() {
    getPatientHistory();
    super.initState();
  }

  getPatientHistory() async {
    patientHistory =
        await MongoDatabase().getPatientHistory(widget.cedulaPaciente);
    setState(() {});
  }

  registerNotNewHistory(History history) {
    notNewHistory = history;
    motivoController.text = history.motivo;
    tratamientoController.text = history.tratamiento;
    diagnosticoController.text = history.diagnostico;
    pronosticoController.text = history.pronostico;
    obsController.text = history.obs;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: EdgeInsets.all(10),
            width: 300,
            height: 600,
            child: (patientHistory.isNotEmpty)
                ? ListView.separated(
                    separatorBuilder: (_, i) => SizedBox(
                          height: 10,
                        ),
                    itemCount: patientHistory.length,
                    itemBuilder: (_, i) {
                      return (i == 0)
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        'Fecha',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        'Motivo',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                Divider(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      registerNotNewHistory(patientHistory[i]);
                                    });
                                  },
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2, color: Colors.black12)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              '${patientHistory[i].fecha}',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              '${patientHistory[i].motivo}',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  registerNotNewHistory(patientHistory[i]);
                                });
                              },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.black12)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          '${patientHistory[i].fecha}',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          '${patientHistory[i].motivo}',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                    })
                : Center(
                    child: Text('Este paciente aun no tiene historia clinica.'),
                  )),
        Container(
            width: 500,
            height: 600,
            child: Column(
              children: [
                Text(
                  (notNewHistory == null)
                      ? 'Nueva Consulta'
                      : 'Consulta Fecha ${notNewHistory.fecha}',
                  style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    controller: motivoController,
                    decoration: InputDecoration(
                      labelText: 'Motivo',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    controller: diagnosticoController,
                    decoration: InputDecoration(
                      labelText: 'Diagnostico',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    controller: tratamientoController,
                    decoration: InputDecoration(
                      labelText: 'Tratamiento',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    controller: pronosticoController,
                    decoration: InputDecoration(
                      labelText: 'Pronostico',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    controller: obsController,
                    decoration: InputDecoration(
                      labelText: 'Obs',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    notNewHistory != null
                        ? MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                showDeleteHistoryDialog(
                                    context,notNewHistory.cedulaPaciente, notNewHistory.fecha, notNewHistory.id.toString());
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Text('ELIMINAR CONSULTA',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          )
                        : SizedBox(),
                        SizedBox(width: 10,),
                    notNewHistory != null
                        ? MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  notNewHistory = null;
                                  motivoController.text = '';
                                  tratamientoController.text = '';
                                  diagnosticoController.text = '';
                                  pronosticoController.text = '';
                                  obsController.text = '';
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.deepPurpleAccent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Text('NUEVA CONSULTA',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      width: 10,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () async {
                          if (notNewHistory == null) {
                            History newHistory = History(
                                cedulaPaciente: widget.cedulaPaciente,
                                motivo: motivoController.text,
                                tratamiento: tratamientoController.text,
                                diagnostico: diagnosticoController.text,
                                pronostico: pronosticoController.text,
                                obs: obsController.text,
                                fecha:
                                    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}');

                            setState(() {
                              patientHistory.add(newHistory);
                            });

                            await MongoDatabase()
                                .createPatientHistory(newHistory);
                          } else {
                            History updatedHistory = History(
                                cedulaPaciente: widget.cedulaPaciente,
                                motivo: motivoController.text,
                                tratamiento: tratamientoController.text,
                                diagnostico: diagnosticoController.text,
                                pronostico: pronosticoController.text,
                                obs: obsController.text,
                                fecha:
                                    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}');

                            await MongoDatabase().updateHistory(updatedHistory);
                            var index = patientHistory.indexWhere((element) =>
                                element.cedulaPaciente ==
                                notNewHistory.cedulaPaciente);
                            patientHistory[index] = updatedHistory;
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(
                              (notNewHistory == null)
                                  ? 'REGISTRAR'
                                  : 'GUARDAR CAMBIOS',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ))
      ],
    );
  }

  Future<dynamic> showDeleteHistoryDialog(
      BuildContext context, String cedulaPaciente, String fecha,String consultaId) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Seguro que quieres eliminar esta consulta?'),
              actions: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        patientHistory.removeWhere(
                            (element) => element.id.toString() == consultaId);
                        setState(() {
                          notNewHistory = null;
                          motivoController.text = '';
                          tratamientoController.text = '';
                          diagnosticoController.text = '';
                          pronosticoController.text = '';
                          obsController.text = '';
                        });
                      });
                      await MongoDatabase().deleteHistory(cedulaPaciente, fecha);
                      Navigator.pop(context);
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
}
