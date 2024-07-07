import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskhub/components/local_storage.dart';
import 'package:taskhub/components/todotile.dart';
import 'package:taskhub/data/task.dart';
import './schedulescreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  //reference the hive box
  late Box<Task> taskBox;
  String username = "Nikita";

  @override
  void initState() {
    super.initState();
    taskBox = Hive.box<Task>('tasks');
    initializeData();
  }

  void initializeData() async {
    String? name = await storage.read(key: nameLS);
    setState(() {
      username = name ?? "User";
    });
  }

  void checkboxChanged(bool? value, int index) {
    Task task = taskBox.getAt(index)!;
    taskBox.putAt(
        index,
        Task(task.taskName, !task.taskCompleted, task.date, task.taskNote,
            task.taskPriority, task.taskTime));
    setState(() {});
  }

  void deleteTask(int index) {
    taskBox.deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => {
                      Get.to(ScheduleScreen(
                        onTaskAdded: () {
                          setState(() {
                            //Update the taskBox to reflect the new task
                            taskBox = Hive.box<Task>('tasks');
                          });
                        },
                      )),
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(6, 6, 15, 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.amber[300]),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.black),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.amber[300],
                                      size: 17,
                                    )),
                                const SizedBox(width: 10),
                                const Text(
                                  'Create New Task',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.amber[300],
                                borderRadius: BorderRadius.circular(50)),
                            child: Image.asset(
                              "assets/images/profile.png",
                              height: 20,
                              width: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "$username's Tasks",
                    style: TextStyle(
                        fontSize: 26,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: taskBox.length,
                itemBuilder: (context, index) {
                  Task task = taskBox.getAt(index)!;
                  return TodoTile(
                    taskName: task.taskName,
                    taskNote: task.taskNote,
                    taskPriority: task.taskPriority,
                    date: task.date,
                    taskCompleted: task.taskCompleted,
                    taskTime: task.taskTime,
                    onChanged: (value) => checkboxChanged(value, index),
                    onDelete: () => deleteTask(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Center(
      //   child: Text('No any tasks'),
      // ),
    );
  }
}
