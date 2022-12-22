import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class PushNotification {
  late AndroidNotificationChannel channel;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void initNotification() async {
    channel = const AndroidNotificationChannel(
        'high_importance_channel', 'High Importance Notifications',
        importance: Importance.high);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }

  void onMessagingListener() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print('NEW NOTIFICATIONS : $message');
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;

      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    icon: 'launch_background')));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('NEW NOTIFICATION : $message');
    });
  }

  Future getNotificationToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fcm_token = prefs.getString("fcm_token");
    print("testing");
    print(fcm_token);
    var request = {"fcm_token": fcm_token};
    var response = await CallApi().postData(request, "profile");
    String message = response["code"];
    print(message);
    print(response);
    print("response is " + response);
    if (fcm_token == null) {
      await FirebaseMessaging.instance.requestPermission();
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      await prefs.setString('fcm_token', deviceToken!);
      Map<String, dynamic> token = {
        'fcm_token': deviceToken,
      };
      var response = await CallApi().postData(token, "profile");
      String message = response["code"];
      print(message);
    } else {
      return;
    }
  }

  //  Authorization - YOUR Server key of Cloud Messaging
  Future<void> sendNotification(
      String to, Map<String, dynamic> data, String title, String body) async {
    Uri uri = Uri.https('fcm.googleapis.com', '/fcm/send');

    await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=HERE YOUR Server key Cloud Messaging'
        },
        body: jsonEncode(<String, dynamic>{
          'notification': {'body': body, 'title': title},
          'priority': 'high',
          'ttl': '4500s',
          'data': data,
          'to': to
        }));
  }

  Future<void> sendNotificationMultiple(List<String> toList,
      Map<String, dynamic> data, String title, String body) async {
    Uri uri = Uri.https('fcm.googleapis.com', '/fcm/send');

    await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=HERE YOUR Server key of Cloud Messaging'
        },
        body: jsonEncode(<String, dynamic>{
          'notification': {'body': body, 'title': title},
          'priority': 'high',
          'ttl': '4500s',
          'data': data,
          'registration_ids': toList
        }));
  }
}

final PushNotification pushNotification = PushNotification();
