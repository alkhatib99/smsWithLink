import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smssenderwithlink/sms_controller/sms_controller.dart';

class MyHomePage extends StatelessWidget {
  final SMSController smsController = Get.put(SMSController());

  MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 227, 227),
      appBar: AppBar(
        title: const Text('Generate Phone Number'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Text(
            'Enter the amount of phone numbers you want to generate'.tr,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              wordSpacing: 1,
              height: 1.5,
              fontFamily: 'Poppins',
              decoration: TextDecoration.none,
              decorationColor: Colors.white,
              decorationStyle: TextDecorationStyle.solid,
              decorationThickness: 1,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            // margin:,

            child: TextField(
              controller: smsController.amountController.value,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 1,
                height: 1.5,
                // fontFamily: 'Poppins',
                decoration: TextDecoration.none,
                decorationColor: Colors.white,
                decorationStyle: TextDecorationStyle.solid,
                decorationThickness: 1,
              ),
              decoration: const InputDecoration(
                labelText: 'Amount of phone numbers',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  wordSpacing: 1,
                  height: 1.5,
                  fontFamily: 'Poppins',
                  decoration: TextDecoration.none,
                  decorationColor: Colors.white,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationThickness: 1,
                ),
                filled: true,
                fillColor: Color.fromRGBO(139, 132, 132, 1),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(139, 132, 132, 1),
                  ),
                  // focusedColor: const Color.fromRGBO(139, 132, 132, 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(139, 132, 132, 1),
                  ),
                  // focusedColor: Color.fromARGB(255, 201, 154, 154),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
              // statesController: / ,
              onPressed: () async {
                if (smsController.generatedPhoneNumbers.isEmpty) {
                  // alert getx told user should generate a phone numbers

                  Get.snackbar(
                    'Generate Phone Numbers'.tr,
                    'You should have a list of phone numbers, /n Please enter the amount of phone numbers you want to generate'
                        .tr,
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 2),
                    snackPosition: SnackPosition.BOTTOM,
                    margin: const EdgeInsets.only(bottom: 20),
                  );
                } else {
                  await smsController.sendSMS('+962781617524', 'fyyfgyfyfy');
                  // ignore: invalid_use_of_protected_member
                  // phoneNumberController.generatedPhoneNumbers.value,

                  // ignore: invalid_use_of_protected_member

                  smsController.generatedPhoneNumbers.clear();
                }
              },
              child: const Text('Send SMS with Link')),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: smsController.generatePhoneNumber,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromRGBO(139, 132, 132, 1),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                side: BorderSide(
                  color: Color.fromRGBO(139, 132, 132, 1),
                ),
                // focusedColor: Color.fromARGB(255, 201, 154, 154),
              ),
              elevation: 0,
            ),
            child: const Text('Generate'),
            // onPressed: phoneNumberController.generatePhoneNumber,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child:
                //make teh econtainer has a shafdow and like a table
                Container(
                    decoration: const BoxDecoration(
                        // color:

                        ),
                    child: Obx(
                      () => SingleChildScrollView(child: columnOfNumbers()),
                    )),
          ),
        ],
      ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: phoneNumberController.generatePhoneNumber,
      //   child: const Icon(Icons.play_circle_fill_outlined),
      // ),
    );
  }

  columnOfNumbers() {
    final widgets = <Widget>[];
    for (int i = 0; i < smsController.generatedPhoneNumbers.length; i++) {
      widgets.add(Column(
        children: [
          Text(
            smsController.generatedPhoneNumbers[i],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              wordSpacing: 1,
              height: 1.5,
              fontFamily: 'Poppins',
              decoration: TextDecoration.none,
              decorationColor: Colors.white,
              decorationStyle: TextDecorationStyle.solid,
              decorationThickness: 1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.white,
            thickness: 1,
          ),
        ],
      ));
    }
    return Column(
      children: widgets,
    );
  }
}

// PhoneNumberController class as GetXController
