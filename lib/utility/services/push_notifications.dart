import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gold_line/utility/providers/map_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class PushNotification {
  static const NAVIGATE_TO_DELIVERY_NOTIFICATION = 'delivery';
  static const NAVIGATE_TO_WALLET_NOTIFICATION = 'wallet';
  static const NAVIGATE_TO_NOTIFICATION = 'notifications';

  //delivery stages(status)
  static const DRIVER_ASSIGNED_NOTIFICATION = 'driver_assigned';

  // static const DELIVERY_PICKED_NOTIFICATION = 'delivery_picked'; //riders don't have app
  static const DELIVERY_CANCELED_NOTIFICATION = 'delivery_canceled';
  static const DELIVERY_ACCEPTED_NOTIFICATION = 'delivery_accepted';
  static const DELIVERY_REJECTED_NOTIFICATION = 'delivery_rejected';
  static const DELIVERY_COMPLETED_NOTIFICATION = 'delivery_completed';
  MapProvider mapProvider = MapProvider();
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
    onMessagingListener();
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
    void handleMessage(RemoteMessage message) {
      print("=== data = ${message.toString()}");
      String notificationType = message.data['status'];

      if (notificationType == DRIVER_ASSIGNED_NOTIFICATION) {
        mapProvider.changeWidgetShowed(showWidget: Show.DRIVER_FOUND);
      } else if (notificationType == DELIVERY_CANCELED_NOTIFICATION) {
        mapProvider.changeWidgetShowed(showWidget: Show.HOME);
      } else if (notificationType == DELIVERY_COMPLETED_NOTIFICATION) {
        mapProvider.changeWidgetShowed(showWidget: Show.HOME);
      }
    }

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

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
        var token = {
          'fcm_token': deviceToken,
        };
        var response = await CallApi().postData(token, "profile");
        String message = response["code"];
        print(message);
      } else {
        return;
      }
    }
  }
}

final PushNotification pushNotification = PushNotification();
