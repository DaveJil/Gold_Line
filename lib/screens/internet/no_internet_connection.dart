import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class NoInternetConnection extends StatefulWidget {
  const NoInternetConnection({super.key});

  @override
  NoInternetConnectionState createState() => NoInternetConnectionState();
}

class NoInternetConnectionState extends State<NoInternetConnection> {
  ConnectivityResult? connectionStatus;

  @override
  void initState() {
    super.initState();
    // Start monitoring connectivity
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        connectionStatus = result;
      });

      if (connectionStatus == ConnectivityResult.wifi ||
          connectionStatus == ConnectivityResult.mobile) {
        // Connection is restored, perform necessary actions
        print('Connection restored');
      Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('No/Bad Internet'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Image.asset('assets/no_internet.png'),
      ),
    );
  }
}
