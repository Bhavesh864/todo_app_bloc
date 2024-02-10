import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/GUID_gen.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/task_observer.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/bloc_imports.dart';
import 'screens/tasks_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
  Bloc.observer = const TaskObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc()..add(AddTask(task: Task(title: 'Task 1', id: GUIDGen().toString()))),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Tasks App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TasksScreen(),
      ),
    );
  }
}
