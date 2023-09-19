import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midoc/blocs/patient/patient_bloc.dart';
import 'package:midoc/data/mongo.dart';
import 'package:window_manager/window_manager.dart';

import 'package:midoc/pages/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(1000, 800),
    backgroundColor: Colors.transparent,
    titleBarStyle: TitleBarStyle.normal,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
  });

  

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => PatientBloc(MongoDatabase())),
    ], child: const MaterialApp(
    debugShowCheckedModeBanner: false,
          home: Home()
        ));
   
  }
}
