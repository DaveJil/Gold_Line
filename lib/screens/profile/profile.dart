import 'package:flutter/material.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: getHeight(30, context),
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
                            icon: const Icon(
                              Icons.camera_enhance_rounded,
                              color: Colors.white,
                              size: 16,
                            )),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: getHeight(15, context),
                  ),
                  Text(
                    'Click to Update Profile Image',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                      fontSize: getHeight(16, context),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(20, context),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        "${userProvider.firstName.text} ${userProvider.lastName.text}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getHeight(20, context),
                  ),
                  const Text(
                    "Gender",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    userProvider.gender.text,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: getHeight(20, context),
                  ),
                  const Text(
                    "House Address",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    userProvider.userAddress.text,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: getHeight(20, context),
                  ),
                  const Text(
                    "LGA",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    userProvider.userLGA.text,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: getHeight(20, context),
                  ),
                  const Text(
                    "State",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    userProvider.userState.text,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: getHeight(50, context),
                  ),
                  Container(
                    height: getHeight(50, context),
                    width: getWidth(250, context),
                    decoration: BoxDecoration(
                        color: kPrimaryGoldColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 25),
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
      ),
    );
  }
}
