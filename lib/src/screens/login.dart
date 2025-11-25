import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskhub/components/local_storage.dart';
import 'package:taskhub/src/screens/homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {}); // This will rebuild the widget when the text changes
  }

  Widget build(BuildContext context) {
    bool isKeyboardOn = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 1,
                  height: isKeyboardOn
                      ? MediaQuery.sizeOf(context).height * 0.35
                      : MediaQuery.sizeOf(context).height * 0.7,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 25, 54, 97),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/task.webp",
                        height: isKeyboardOn ? 200 : 400,
                      ),
                      Text(
                        "TaskHub",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Container(
                    child: Text(
                      "Start scheduling your activities",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 25, 54, 97),
                                  width: 3),
                              borderRadius: BorderRadius.circular(15)),
                          child: TextField(
                            controller: _textController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 30, right: 18, top: 18, bottom: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide.none, // Increased border width
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Enter your name here',
                                hintStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 187, 186, 186))),
                          ),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              color: _textController.text.isEmpty
                                  ? Colors.grey
                                  : Color.fromARGB(255, 25, 54, 97),
                              borderRadius: BorderRadius.circular(22.5)),
                          child: TextButton(
                            onPressed: () async {
                              if (_textController.text.isNotEmpty) {
                                await storage.write(
                                    key: nameLS, value: _textController.text);
                                Get.to(() => Homescreen());
                              } else {}
                            },
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins"),
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
