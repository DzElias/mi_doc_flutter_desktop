part of 'patient_bloc.dart';

abstract class PatientState {
  const PatientState();
}

class LoadingPatients extends PatientState{}

class LoadedPatients extends PatientState{

  final List<Patient> patients;

  LoadedPatients({this.patients});
}
