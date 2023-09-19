import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midoc/data/mongo.dart';
import 'package:midoc/models/patient.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientsEvent, PatientState> {

  final MongoDatabase mongoDatabase;


  PatientBloc(this.mongoDatabase) : super(LoadingPatients()) {
    on<SavePatientsEvent>((event, emit) async {
      
      emit(LoadedPatients(patients: event.patients));
    });
  }

  getPatients() async {
    List<Patient> patients = await mongoDatabase.getAllPatients();
    add(SavePatientsEvent(patients: patients));
  }

  createPatient(Patient patient) async {
    
    var id = await mongoDatabase.createPatient(patient);
    var patientToSave = patient;
    patientToSave.id = id;
    add(SavePatientsEvent(patients: [...(state as LoadedPatients).patients, patient]));

  }

  deletePatient(String id) async {
    var patients = (state as LoadedPatients).patients;
    patients.removeWhere((element) => element.ci == id);
    await mongoDatabase.deletePatient(id);
    add(SavePatientsEvent(patients: patients));
  }
  
  updatePatient(Patient patient) async {
    var patients = (state as LoadedPatients).patients;
    var index = patients.indexWhere((element) => patient.id.toString() == element.id.toString());
    patients[index] = patient;

    await mongoDatabase.updatePatient(patient);
    add(SavePatientsEvent(patients: patients));

  }
  
}
