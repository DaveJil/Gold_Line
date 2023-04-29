import 'package:flutter/material.dart';
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
                      'Fill in your details',
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
                  'Kindly fill in your Information below.',
                  style: TextStyle(color: kPrimaryGoldColor, fontSize: 18),
                ),
                SizedBox(
                  height: getHeight(40, context),
                ),
                Stack(children: [
                  Container(
                    height: getHeight(150, context),
                    width: getHeight(136, context),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      border: Border.all(
                        width: 1.appWidth(context),
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 7.23,
                    bottom: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.camera_enhance_rounded,
                            color: Colors.white,
                            size: getHeight(16, context),
                          )),
                    ),
                  ),
                ]),
                SizedBox(
                  height: getHeight(15, context),
                ),
                Text(
                  'Click to Upload Profile Image',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontSize: getHeight(16, context),
                  ),
                ),
                SizedBox(
                  height: getHeight(20, context),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(30, context)),
                  child: TextField(
                    controller: userProvider.otherName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Other Name',
                        hintText: 'Enter your Other/Middle Name'),
                  ),
                ),
                SizedBox(
                  height: getHeight(20, context),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(30, context)),
                  child: TextField(
                    controller: userProvider.gender,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Gender',
                        hintText: 'Are you Male or Female?'),
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(30, context)),
                  child: TextField(
                    controller: userProvider.userLGA,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your LGA',
                        hintText: 'Enter your Residental LGA'),
                  ),
                ),
                SizedBox(
                  height: getHeight(20, context),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(30, context)),
                  child: TextField(
                    controller: userProvider.userState,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your State',
                        hintText: 'Enter your Residental State'),
                  ),
                ),
                SizedBox(
                  height: getHeight(20, context),
                ),
                SizedBox(
                  height: getHeight(30, context),
                ),
                Container(
                  height: getHeight(50, context),
                  width: getWidth(250, context),
                  decoration: BoxDecoration(
                      color: kPrimaryGoldColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      userProvider.updateProfile(context);
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
