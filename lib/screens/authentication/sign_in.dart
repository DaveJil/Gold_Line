import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gold_line/screens/authentication/sign_up.dart';
import 'package:gold_line/screens/map/map_widget.dart';
import 'package:gold_line/utility/helpers/constants.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 150),
                child: Text(
                  "Welcome, Enter your Login Details",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 400,
                  height: 400,
                  child: SvgPicture.asset("assets/login.svg")),
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
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SignUpScreen()));
                },
                child: const Text(
                  'New User? Create an account',
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
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SignUpScreen()));
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(color: kPrimaryGoldColor, fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
