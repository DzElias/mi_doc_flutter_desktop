// To parse this JSON data, do
//
//     final history = historyFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
    String motivo;
    String tratamiento;
    String diagnostico;
    String pronostico;
    String fecha;
    String obs;
    String cedulaPaciente;
    ObjectId id;


    History({

        this.id,
         this.cedulaPaciente,
         this.motivo,
         this.tratamiento,
         this.diagnostico,
         this.pronostico,
         this.fecha,
         this.obs,
    });

    factory History.fromJson(Map<String, dynamic> json) => History(
        id: json['_id'],
        motivo: json["motivo"],
        tratamiento: json["tratamiento"],
        diagnostico: json["diagnostico"],
        pronostico: json["Pronostico"],
        fecha: json["fecha"],
        obs: json["obs"],
        cedulaPaciente: json["cedulaPaciente"]
    );

    Map<String, dynamic> toJson() => {
        "motivo": motivo,
        "tratamiento": tratamiento,
        "diagnostico": diagnostico,
        "Pronostico": pronostico,
        "fecha": fecha,
        "obs": obs,
        "cedulaPaciente": cedulaPaciente
    };
}
