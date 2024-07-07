import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskhub/components/todotile.dart';
import 'package:taskhub/data/task.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:taskhub/src/screens/homescreen.dart';
import 'package:taskhub/src/screens/login.dart';
import 'package:taskhub/src/screens/rootscreen.dart';

void main() async {
  //initialize hive
  await Hive.initFlutter();

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  //register the type adapter
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());

  //open a box
  await Hive.openBox<Task>('tasks');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}

class TimeOfDayAdapter extends TypeAdapter<TimeOfDay> {
  @override
  final int typeId = 100;

  @override
  TimeOfDay read(BinaryReader reader) {
    final hour = reader.readInt();
    final minute = reader.readInt();
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  void write(BinaryWriter writer, TimeOfDay obj) {
    writer.writeInt(obj.hour);
    writer.writeInt(obj.minute);
  }
}
