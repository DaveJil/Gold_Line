import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gold_line/screens/authentication/sign_in.dart';
import 'package:gold_line/screens/authentication/sign_up.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/custom_button.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';

class LoginChoice extends StatefulWidget {
  const LoginChoice({super.key});

  @override
  LoginChoiceState createState() => LoginChoiceState();
}

class LoginChoiceState extends State<LoginChoice> {
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.appWidth(context),
              vertical: 10.appHeight(context),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: getHeight(40, context),
                ),
                SizedBox(
                    width: 300,
                    height: 300,
                    child: SvgPicture.asset("assets/started.svg")),
                SizedBox(
                  height: getHeight(20, context),
                ),
                const Text(
                  'Lets get you Started',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                SizedBox(
                  height: getHeight(10, context),
                ),
                const Center(
                  child: Text(
                    'Welcome, Please Choose your Login / SignUp Option',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: kPrimaryGoldColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: getHeight(40, context),
                ),
                const Text(
                  'Are you an Agent or a User?',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                SizedBox(
                  height: getHeight(40, context),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomButton(
                          onPressed: () {
                            changeScreen(context, SignUpScreen());
                          },
                          text: 'Sign Up As Agent',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomButton(
                          onPressed: () {
                            changeScreen(context, SignUpScreen());
                          },
                          text: 'SignUp As Driver',
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(10, context),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignInScreen()));
                  },
                  child: Text(
                    'or Proceed to Login',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: kPrimaryGoldColor,
                      fontWeight: FontWeight.w300,
                      fontSize: getHeight(22, context),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(10, context),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context),
                    );
                  },
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: getHeight(22, context),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(40, context),
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

Widget _buildPopupDialog(BuildContext context) {
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

class BuildCheckBox extends StatefulWidget {
  const BuildCheckBox({Key? key}) : super(key: key);

  @override
  State<BuildCheckBox> createState() => _BuildCheckBoxState();
}

class _BuildCheckBoxState extends State<BuildCheckBox> {
  bool _isAgree = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
            value: _isAgree,
            activeColor: kPrimaryGoldColor,
            onChanged: (bool? value) {
              setState(() {
                _isAgree = !_isAgree;
              });
            }),
        SizedBox(
          width: 10.appWidth(context),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => _buildPopupDialog(context),
              );
            },
            child: const AutoSizeText(
              "I agree with the terms and conditions that come with using this application.",
              maxLines: 3,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                // fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
