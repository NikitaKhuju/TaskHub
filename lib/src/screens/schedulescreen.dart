import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskhub/data/task.dart';
import 'package:taskhub/src/screens/homescreen.dart';

class ScheduleScreen extends StatefulWidget {
  final Function() onTaskAdded;

  const ScheduleScreen({Key? key, required this.onTaskAdded}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  //reference the hive box
  Box<Task> taskBox = Hive.box<Task>('tasks');

  DateTime selectedDate = DateTime.now();
  int selectedPriority = 0;
  TimeOfDay selectedTime = const TimeOfDay(hour: 0, minute: 0);

  List<String> priorityOptions = ['Low', 'Medium', 'High'];

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  var _taskController; // _ -> private variable
  var _descriptionController;
  void saveNewTask() {
    setState(() {
      Task newTask = Task(
          _taskController.text,
          false,
          selectedDate,
          _descriptionController.text,
          priorityOptions[selectedPriority],
          selectedTime);
      taskBox.add(newTask);
      _taskController.clear();
      _descriptionController.clear();
      resetDate();

      // Notify the callback function that a new task has been added
      widget.onTaskAdded();
    });
  }

  void resetDate() {
    setState(() {
      selectedDate = DateTime.now();
    });
  }

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _taskController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                  ),
                  color: Color.fromARGB(255, 25, 54, 97),
                ),
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 60, bottom: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).pop(), //get.back()
                              child: const Icon(
                                Icons.close,
                                size: 30,
                                color: Colors.white,
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
                          ]),
                      const SizedBox(height: 25),
                      const Text('Title',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400)),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _taskController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            fillColor: const Color.fromARGB(255, 45, 76, 122),
                            filled: true,
                            labelText: 'Enter your title',
                            labelStyle: const TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w200)),
                      )
                    ])),
            Container(
              color: const Color.fromARGB(255, 25, 54, 97),
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(40)),
                  ),
                  padding: const EdgeInsets.fromLTRB(25, 40, 25, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                ' Date',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 115, 209, 209)),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 240, 240, 240)),
                                child: GestureDetector(
                                  child: Text(
                                    '${selectedDate.toLocal()}'.split(' ')[0],
                                    style: const TextStyle(
                                        fontSize: 23,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w700),
                                  ),
                                  onTap: () {
                                    selectDate(context);
                                  },
                                ),
                              )
                            ]),
                        const SizedBox(width: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(' Time',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Color.fromARGB(255, 115, 209, 209))),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 240, 240, 240)),
                                child: GestureDetector(
                                    child: Text(
                                        '$selectedTime'
                                            .split('(')[1]
                                            .split(')')[0],
                                        style: const TextStyle(
                                            fontSize: 23,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w700)),
                                    onTap: () {
                                      selectTime(context);
                                    }),
                              )
                            ])
                      ]),
                      const SizedBox(height: 20),
                      const Text(' Note',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 115, 209, 209))),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 240, 240, 240))),
                          fillColor: const Color.fromARGB(255, 240, 240, 240),
                          filled: true,
                          labelText: 'Write your important note',
                          labelStyle: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w200),
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildPriorityButtons(),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _taskController.text = '';
                              _descriptionController.text = '';
                              resetDate();
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor:
                                    const Color.fromARGB(255, 247, 163, 124),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 20, vertical: 15)),
                            child: const Text(
                              'Reset',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (_taskController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please fill in the title.'),
                                    ),
                                  );
                                  return;
                                }
                                saveNewTask();
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                      const Color.fromARGB(255, 247, 163, 124),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 20, vertical: 15)),
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPriorityButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        priorityOptions.length,
        (index) => OutlinedButton(
          onPressed: () {
            setState(() {
              selectedPriority = index;
            });
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: selectedPriority == index
                ? const Color.fromARGB(255, 115, 209, 209)
                : Colors.white,
            foregroundColor:
                selectedPriority == index ? Colors.white : Colors.black,
            side: const BorderSide(color: Color.fromARGB(255, 115, 209, 209)),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            priorityOptions[index],
            style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
