import 'package:mongo_dart/mongo_dart.dart';
class Patient {
  ObjectId id;
  final String ci;
  final String nombre;
  final String telefono;
  final String tipoSangre;
  final String mail;
  final String obs;
  final String sexo;
  final String fechaNacimiento;
  final String ruc;
  final String dir;

  Patient({
     this.id,
     this.ci, 
     this.nombre, 
     this.telefono, 
     this.tipoSangre, 
     this.mail, 
     this.obs, 
     this.sexo, 
     this.fechaNacimiento, 
     this.ruc,
     this.dir
  });


  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["_id"],
        ci: json["ci"],
        nombre: json["nombre"],
        telefono: json["telefono"],
        tipoSangre: json["tipoSangre"],
        mail: json["mail"],
        obs: json["obs"],
        sexo: json["sexo"],
        fechaNacimiento: json["fechaNacimiento"],
        ruc: json["ruc"], 
        dir: json["dir"]
    );

    Map<String, dynamic> toJson() => {
        "ci": ci,
        "nombre": nombre,
        "telefono": telefono,
        "tipoSangre": tipoSangre,
        "mail": mail,
        "obs": obs,
        "sexo": sexo,
        "fechaNacimiento": fechaNacimiento,
        "ruc": ruc,
        "dir": dir
    };
}