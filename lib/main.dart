import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivedatabase/mainscreen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

import 'DTPicker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox('tasks');
  await Hive.openBox('doneTasks');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DtPicker>(
          create: (context) => DtPicker(),
        ),
      ],
      child: MaterialApp(
        home: MainScreen(),
      ),
    );
  }
}
