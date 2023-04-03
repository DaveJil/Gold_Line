import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gold_line/goldline.dart';
import 'package:gold_line/utility/providers/get_list_provider.dart';
import 'package:gold_line/utility/providers/map_provider.dart';
import 'package:gold_line/utility/providers/user_provider.dart';
import 'package:once/once.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'utility/providers/user_profile_provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.subscribeToTopic("general");
  FirebaseMessaging.instance.subscribeToTopic("user");
  await FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  runApp(const MyApp());
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
);
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      OnceWidget.showOnEveryNewVersion(builder: () {
        return buildPopupDialog(context);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MapProvider>(create: (BuildContext context) {
          return MapProvider();
        }),
        ChangeNotifierProvider<UserProvider>(create: (BuildContext context) {
          return UserProvider.initialize();
        }),
        ChangeNotifierProvider<UserProfileProvider>(
            create: (BuildContext context) {
          return UserProfileProvider(context: context);
        }),
        ChangeNotifierProvider<GetListProvider>(create: (BuildContext context) {
          return GetListProvider();
        }),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: GoldLine()),
    );
  }
}

Widget buildPopupDialog(BuildContext context) {
  return AlertDialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 20),
    title: const Text('Privacy Policy'),
    content: const SingleChildScrollView(
      child: Text(
        " AREACONNECT LTD. built the Goldline app as a Commercial app. This SERVICE is provided by AREACONNECT LTD. and is intended for use as is. This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service. If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Goldline unless otherwise defined in this Privacy PolicyInformation Collection and Use: For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to Location, Google Maps API. The information that we request will be retained by us and used as described in this privacy policy. The app does use third-party services that may collect information used to identify you. Link to the privacy policy of third-party service providers used by the appGoogle Play Services | Google Analytics for Firebase | Firebase Crashlytic. "
        "i-Motion Nigeria Log Data :We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics."
        "\n\n"
        "Cookies\n"
        "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory. This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service."
        "\n\n"
        "Children's Privacy\n"
        "These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13 years of age."
        "In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do the necessary actions."
        "\n\n"
        "Service Providers\n"
        "We may employ third-party companies and individuals due to the following reasons:"
        "To facilitate our Service;"
        "To provide the Service on our behalf;"
        "To perform Service-related services; or."
        "To assist us in analyzing how our Service is used."
        "We want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose."
        ""
        "\n\n"
        "Security\n"
        "We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security."
        "\n\n"
        "Links to Other Sites\n"
        "This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services."
        "\n\n"
        "Changes to This Privacy Policy\n"
        "We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page."
        "This policy is effective as of 2022-12-31",
      ),
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Accept'),
      ),
      TextButton(
        onPressed: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
        child: const Text(
          'Reject',
          style: TextStyle(color: Colors.red),
        ),
      ),
    ],
  );
}
