import 'package:midoc/models/history.dart';
import 'package:midoc/models/patient.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {

  Future<List<History>> getPatientHistory(String cedula)async{
    List<History> historyList = [];
    var db = await Db.create('mongodb://localhost:27017/midoc');
    await db.open();
    var historyCollection = db.collection('historyCollection');
    var historyJsonList = await historyCollection.find({"cedulaPaciente": cedula}).toList();
    
    for(var history in historyJsonList){
      historyList.add(History.fromJson(history));
    }
    return historyList;
  }

  Future<String> createPatientHistory(History history)async{
    var db = await Db.create('mongodb://localhost:27017/midoc');
    await db.open();
    var historyCollection = db.collection('historyCollection');
    var inserted = await historyCollection.insertOne(history.toJson());
    return inserted.id.toString();

  }
  

  Future<List<Patient>> getAllPatients () async {
    List<Patient> patients = [];
    var db = await Db.create('mongodb://localhost:27017/midoc');
    await db.open();
    var patientCollection = db.collection('patientsCollection');
    var patientsJson = await patientCollection.find().toList();
    
    for(var patient in patientsJson){
      patients.add(Patient.fromJson(patient)); 
    }

    return patients;
  }
  
  Future<ObjectId> createPatient (Patient patient) async {
    var db = await Db.create('mongodb://localhost:27017/midoc');
    await db.open();
    var patientCollection = db.collection('patientsCollection');
    var inserted = await patientCollection.insertOne(patient.toJson());
    return inserted.id;
    
    
  }

  Future<void> deletePatient (String id) async {
    var db = await Db.create('mongodb://localhost:27017/midoc');
    await db.open();
    var patientCollection = db.collection('patientsCollection');
    var deleted = await patientCollection.deleteOne({'ci': id});
    print(deleted.id);
  }




  Future<void> updatePatient(Patient patient) async {
    var db = await Db.create('mongodb://localhost:27017/midoc');
    await db.open();
    var patientCollection = db.collection('patientsCollection');
    await patientCollection.replaceOne(where.eq('ci', patient.ci), patient.toJson(), );
  }

  Future<void> updateHistory(History history) async {
    var db = await Db.create('mongodb://localhost:27017/midoc');
    await db.open();
    var historyCollection = db.collection('historyCollection');
    await historyCollection.replaceOne({"cedulaPaciente": history.cedulaPaciente, "fecha": history.fecha}, history.toJson(), );
  }

  Future<void> deleteHistory(String cedulaPaciente, String fecha) async {
    var db = await Db.create('mongodb://localhost:27017/midoc');
    await db.open();
    var historyCollection = db.collection('historyCollection');
    var res = await historyCollection.deleteOne({"cedulaPaciente": cedulaPaciente, "fecha": fecha});
    print(res);
  }

  // Future<Patient> deletePatient() async{
  //   var db = await Db.create('mongodb://localhost:27017');
  //   await db.open();
  //   var patientCollection = db.collection('patientsCollection');
  // }
}