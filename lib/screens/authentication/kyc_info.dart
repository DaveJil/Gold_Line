import 'package:flutter/material.dart';
import 'package:gold_line/screens/authentication/sign_up.dart';
import 'package:gold_line/screens/map/map_widget.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:provider/provider.dart';

import '../../utility/helpers/dimensions.dart';
import '../../utility/providers/user_provider.dart';

class KycInfo extends StatefulWidget {
  const KycInfo({super.key});

  @override
  KycInfoState createState() => KycInfoState();
}

class KycInfoState extends State<KycInfo> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: getHeight(30, context),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: getHeight(24, context),
                      ),
                    ),
                    const Text(
                      'Update your Info',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(
                  height: getHeight(20, context),
                ),
                const Text(
                  'You can edit your Information here.',
                  style: TextStyle(color: kPrimaryGoldColor, fontSize: 18),
                ),
                SizedBox(
                  height: getHeight(40, context),
                ),

                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: getWidth(30, context)),
                  child: TextField(
                    controller: userProvider.email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter your email'),
                  ),
                ),
                SizedBox(
                  height: getHeight(20, context),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(30, context)),
                  child: TextField(
                    controller: userProvider.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone',
                        hintText: 'Enter Phone'),
                  ),
                ),
                SizedBox(
                  height: getHeight(20, context),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(30, context)),
                  child: TextField(
                    controller: userProvider.userAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Address',
                      hintText: 'Enter valid Address',
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(20, context),
                ),
                Container(
                  height: getHeight(50, context),
                  width: getWidth(250, context),
                  decoration: BoxDecoration(
                      color: kPrimaryGoldColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () async{
                     await  userProvider.updateProfile(context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const MapWidget()));
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(130, context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
