import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskhub/utils/colors.dart';
import 'package:taskhub/utils/styles.dart';

void showConfirmationDialogBox(String title, String message,
    VoidCallback onConfirm, VoidCallback onCancel) {
  Get.dialog(Dialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Text(
            title,
            style: heading1,
          ),
          SizedBox(height: 10),
          Text(
            message,
            style: TextStyle(color: Colors.grey[600], fontSize: 15),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(40)),
                child: TextButton(
                    onPressed: () => {onConfirm()},
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    )),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(40)),
                child: TextButton(
                    onPressed: () => {onCancel()},
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    )),
              )
            ],
          )
        ],
      ),
    ),
  ));
}
