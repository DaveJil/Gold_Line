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
                  'You can edit your Information here.',
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
                          onPressed: () {
                            userProvider.updateProfilePic(context);
                          },
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
                    controller: userProvider.firstName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                        hintText: 'Enter your First Name'),
                  ),
                ),
                SizedBox(
                  height: getHeight(20, context),
                ),

                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: getWidth(30, context)),
                  child: TextField(
                    controller: userProvider.lastName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
                        hintText: 'Enter your last Name'),
                  ),
                ),
                SizedBox(
                  height: getHeight(20, context),
                ),

                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: getWidth(30, context)),
                  child: TextField(
                    controller: userProvider.email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Other Name',
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select User Type"),
                      SizedBox(width: 15,),
                      UserType()
                    ],
                  )
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
