import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taskhub/components/common_algo.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final String taskNote;
  final String taskPriority;
  final DateTime date;
  final bool taskCompleted;
  final TimeOfDay taskTime;
  Function(bool?)? onChanged;
  final Function() onDelete;

  String formattedDate;

  TodoTile({
    super.key,
    required this.taskName,
    required this.taskNote,
    required this.date,
    required this.taskPriority,
    required this.taskCompleted,
    required this.taskTime,
    required this.onChanged,
    required this.onDelete,
  }) : formattedDate = DateFormat('yyyy-MM-dd').format(date);

  @override
  Widget build(BuildContext context) {
    Color getRandomLightColor() {
      Random random = Random();
      // Generate random values for red, green, and blue components
      int red = random.nextInt(55) + 180; // 128-255 (lighter shades of red)
      int green = random.nextInt(55) + 180; // 128-255 (lighter shades of green)
      int blue = random.nextInt(55) + 180; // 128-255 (lighter shades of blue)
      return Color.fromRGBO(
          red, green, blue, 1.0); // Create a Color object with full opacity
    }

    Color randomLightColor = getRandomLightColor();

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 14),
      child: Container(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
          decoration: BoxDecoration(
              color: randomLightColor, borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    child: Text(
                      taskName,
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey.withOpacity(0.2)),
                        child: const Icon(
                          Icons.calendar_month,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${formattedDate.split('-')[2]} ${getMonth(int.parse(formattedDate.split('-')[1]))}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey.withOpacity(0.2)),
                        child: const Icon(
                          Icons.schedule,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        twelveFormat(taskTime),
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.red[300]),
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: randomLightColor,
                        size: 28,
                      ),
                      onPressed: onDelete,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 6),
                        decoration: BoxDecoration(
                            color: randomLightColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          taskCompleted ? 'Completed' : 'In Progress',
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: randomLightColor),
                        child: Text(
                          taskPriority,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ]),
              )
            ],
          )),
    );
  }
}
