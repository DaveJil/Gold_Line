import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gold_line/utility/providers/map_provider.dart';

class PushNotification {
  MapProvider mapProvider = MapProvider();
  late AndroidNotificationChannel channel;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void initNotification() async {
    channel = const AndroidNotificationChannel(
        'max_importance_channel', 'Max Importance Notifications',
        importance: Importance.max);

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
                    sound: const RawResourceAndroidNotificationSound(
                        'goldline_sound'),
                    icon: 'launch_background')));
      }
    });

    void handleMessage(RemoteMessage message) {
      print("=== data = ${message.toString()}");
      String notificationType = message.data['navigate_to'];
    }

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}

final PushNotification pushNotification = PushNotification();
