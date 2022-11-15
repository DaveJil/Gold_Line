import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gold_line/screens/authentication/sign_in.dart';
import 'package:gold_line/screens/map/map_widget.dart';
import 'package:gold_line/utility/helpers/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text(
                    'Lets get you Started',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                    width: 300,
                    height: 300,
                    child: SvgPicture.asset("assets/signup.svg")),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Full Name',
                        hintText: 'Enter your Full Name'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        hintText: 'Enter secure password'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignInScreen()));
                  },
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(color: kPrimaryGoldColor, fontSize: 22),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: kPrimaryGoldColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const MapWidget()));
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 130,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
