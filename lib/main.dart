import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:foodcafe/src/features/apiConstants.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:foodcafe/src/features/orderlengthProvider.dart';
import 'package:foodcafe/src/features/translations.dart';

import 'package:foodcafe/src/screens/main_screen.dart';

import 'package:foodcafe/src/utils/color.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCevbNzlRp6pKpnTZQ8INeHTbdS0dG6bWM",
        appId: "1:209841588438:android:4e0df983f2800c31b56177",
        messagingSenderId: "209841588438",
        projectId: "foodapp23",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  String? token = await FirebaseMessaging.instance.getToken();
  if (token != null) {
    await sendFCMTokenToServer(token);
  }
  runApp(const MyApp());
}

Future<void> sendFCMTokenToServer(String token) async {
  try {
    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}/restaurant/register-notification"),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${ApiConstants.authToken}',
      },
      body: jsonEncode({
        "token": token,
      }),
    );

    if (response.statusCode == 200) {
      print("FCM token sent to server successfully");
    } else {
      print(
          "Failed to send FCM token to server. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error sending FCM token to server: $e");
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderLengthNotifier(),
      child: GetMaterialApp(
          translations: TranslationsApp(),
          locale: Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'SF Pro',
            scaffoldBackgroundColor: MenuContainer.background,
          ),
          home: MainScreen()),
    );
  }
}
