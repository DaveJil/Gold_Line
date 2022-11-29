import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gold_line/screens/authentication/sign_up.dart';
import 'package:gold_line/utility/helpers/constants.dart';

class LoginChoice extends StatefulWidget {
  const LoginChoice({super.key});

  @override
  LoginChoiceState createState() => LoginChoiceState();
}

class LoginChoiceState extends State<LoginChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                    width: 300,
                    height: 300,
                    child: SvgPicture.asset("assets/started.svg")),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Lets get you Started',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Welcome, Please Choose your Login / SignUp Option',
                  style: TextStyle(
                      color: kPrimaryGoldColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Are you an Agent or a User?',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: kPrimaryGoldColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignUpScreen()));
                          },
                          child: const Text(
                            'Sign Up as an Agent',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: kPrimaryGoldColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignUpScreen()));
                          },
                          child: const Text(
                            'Sign Up as a User',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const BuildCheckBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildCheckBox extends StatefulWidget {
  const BuildCheckBox({Key? key}) : super(key: key);

  @override
  State<BuildCheckBox> createState() => _BuildCheckBoxState();
}

class _BuildCheckBoxState extends State<BuildCheckBox> {
  bool _isFragile = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
            value: _isFragile,
            activeColor: kPrimaryGoldColor,
            onChanged: (bool? value) {
              setState(() {
                _isFragile = _isFragile;
              });
            }),
        SizedBox(
          width: 15,
        ),
        const Text(
          "I agree with the terms and conditions that come with \n using this application.",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
            // fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
