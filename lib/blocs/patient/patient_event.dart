part of 'patient_bloc.dart';

abstract class PatientsEvent {
  const PatientsEvent();
}

class SavePatientsEvent extends PatientsEvent {
  final List<Patient> patients;

  SavePatientsEvent({this.patients});
}


