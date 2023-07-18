import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_line/screens/my_deliveries/select_type.dart';
import 'package:gold_line/screens/profile/settings_page.dart';
import 'package:gold_line/screens/profile/supportScreen.dart';
import 'package:gold_line/screens/profile/wallet/wallet.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/custom_button.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:gold_line/widgets/otherDetailsDivider.dart';
import 'package:provider/provider.dart';

import '../../utility/providers/user_provider.dart';
import 'referral.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late Future userProfile;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProfile = userProvider.getUserData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryGoldColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: getHeight(20, context),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: AutoSizeText(
          ' Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: FutureBuilder(
          future: userProvider.getUserData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                );

                // if we got our data
              } else if (snapshot.hasData) {
                // Extracting data from snapshot object
                final datum = snapshot.data;
                //print(datum);
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      SizedBox(
                        height: getHeight(30, context),
                      ),
                      InkWell(
                        onTap: () {
                          userProvider.updateProfilePic(context);
                        },
                        child: Center(
                          child: Stack(children: [
                            FutureBuilder(
                                future: userProvider.getUserData(context),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    // If we got an error
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text(
                                          '${snapshot.error} occurred',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      );

                                      // if we got our data
                                    } else if (snapshot.hasData) {
                                      // Extracting data from snapshot object
                                      final datum = snapshot.data;
                                      //print(datum!.avatar);
                                      //print(datum);
                                      return Container(
                                        padding: EdgeInsets.all(16),
                                        height: getHeight(150, context),
                                        width: getHeight(136, context),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey,
                                            image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: NetworkImage(
                                                  datum!.avatar ??
                                                      "https://png.pngtree.com/png-clipart/20210310/original/pngtree-default-male-avatar-png-image_5939655.jpg",
                                                )),
                                            border: Border.all(
                                              width: 1.appWidth(context),
                                              style: BorderStyle.solid,
                                            )),
                                      );
                                    }
                                  }

                                  return Container(
                                      height: getHeight(150, context),
                                      width: getHeight(136, context),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey,
                                          border: Border.all(
                                            width: 1.appWidth(context),
                                            style: BorderStyle.solid,
                                          )));
                                }),
                            const Positioned(
                              right: 7.23,
                              bottom: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(10, context),
                      ),
                      TextButton(
                        onPressed: () {
                        },
                        child: Text(
                          "${datum!.firstName!} ${datum.lastName!}",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.grey,
                            fontSize: getHeight(20, context),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(5, context),
                      ),
                      Text(
                        // widget.firstName,
                        datum.email!,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: getHeight(16, context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: getHeight(10, context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.supervised_user_circle,
                            color: kPrimaryGoldColor,
                            size: getHeight(30, context),
                          ),
                          SizedBox(
                            width: getWidth(10, context),
                          ),
                          Text(
                            datum.appRole ?? "Agent",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.grey,
                              fontSize: getHeight(15, context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      OtherDetailsDivider(),
                      SizedBox(
                        height: getHeight(20, context),
                      ),
                      ListTile(
                        leading: SizedBox(
                          height: getHeight(60, context),
                          width: getWidth(60, context),
                          child: SvgPicture.asset("assets/my history.svg"),
                        ),
                        title: Text(
                          "My History",
                          style: TextStyle(
                              fontSize: getHeight(20, context),
                              fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          "View all your previous transactions",
                          style: TextStyle(
                              fontSize: getHeight(16, context),
                              fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(
                          Icons.arrow_circle_right_sharp,
                          color: kPrimaryGoldColor,
                          size: getHeight(20, context),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const MyDeliveriesOptionScreen()));
                        },
                      ),
                      SizedBox(
                        height: getHeight(20, context),
                      ),
                      ListTile(
                        leading: SizedBox(
                          height: getHeight(60, context),
                          width: getWidth(60, context),
                          child: SvgPicture.asset("assets/wallet balance.svg"),
                        ),
                        title: Text(
                          "Wallet Balance",
                          style: TextStyle(
                              fontSize: getHeight(20, context),
                              fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          "Check all your Commissions.",
                          style: TextStyle(
                              fontSize: getHeight(16, context),
                              fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(
                          Icons.arrow_circle_right_sharp,
                          color: kPrimaryGoldColor,
                          size: getHeight(20, context),
                        ),
                        onTap: () {
                          changeScreen(context, WalletScreen());
                        },
                      ),
                      SizedBox(
                        height: getHeight(20, context),
                      ),


                      ListTile(
                        leading: SizedBox(
                          height: getHeight(60, context),
                          width: getWidth(60, context),
                          child: SvgPicture.asset("assets/refferals.svg"),
                        ),
                        title: Text(
                          "Referrals",
                          style: TextStyle(
                              fontSize: getHeight(20, context),
                              fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          "Refer Agents to AreaConnect",
                          style: TextStyle(
                              fontSize: getHeight(16, context),
                              fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(
                          Icons.arrow_circle_right_sharp,
                          color: kPrimaryGoldColor,
                          size: getHeight(20, context),
                        ),
                        onTap: () {
                          // final snackBar = SnackBar(
                          //   elevation: 0,
                          //   behavior: SnackBarBehavior.floating,
                          //   backgroundColor: Colors.transparent,
                          //   content: AwesomeSnackbarContent(
                          //     title: "Coming Soon",
                          //     message:
                          //         "You would soon be able to refer your friends and earn money",
                          //     contentType: ContentType.help,
                          //   ),
                          // );
                          // ScaffoldMessenger.of(context)
                          //   ..hideCurrentSnackBar()
                          //   ..showSnackBar(snackBar);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ReferralPage(
                                    uuid: datum.uuid!,
                                  )));
                        },
                      ),
                      SizedBox(
                        height: getHeight(20, context),
                      ),
                      ListTile(
                        leading: SizedBox(
                          height: getHeight(60, context),
                          width: getWidth(60, context),
                          child: SvgPicture.asset("assets/my coupons.svg"),
                        ),
                        title: Text(
                          "Support",
                          style: TextStyle(
                              fontSize: getHeight(20, context),
                              fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          "Contact Goldline Support Team",
                          style: TextStyle(
                              fontSize: getHeight(16, context),
                              fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(
                          Icons.arrow_circle_right_sharp,
                          color: kPrimaryGoldColor,
                          size: getHeight(20, context),
                        ),
                        onTap: () {
                          changeScreen(context, const SupportScreen());
                        },
                      ),
                      SizedBox(
                        height: getHeight(20, context),
                      ),
                      ListTile(
                        leading: SizedBox(
                          height: getHeight(60, context),
                          width: getWidth(60, context),
                          child: SvgPicture.asset("assets/settings.svg"),
                        ),
                        title: Text(
                          "Settings",
                          style: TextStyle(
                              fontSize: getHeight(20, context),
                              fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          "Edit your preferences",
                          style: TextStyle(
                              fontSize: getHeight(16, context),
                              fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(
                          Icons.arrow_circle_right_sharp,
                          color: kPrimaryGoldColor,
                          size: getHeight(20, context),
                        ),
                        onTap: () {
                          changeScreen(context, const Settings());
                        },
                      ),
                      SizedBox(
                        height: getHeight(20, context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomButton(
                            onPressed: () {
                              userProvider.signOut(context);
                            },
                            text: 'Log Out',
                          ),
                          SizedBox(width: 10,),
                          CustomButton(
                            color: Colors.redAccent,
                            onPressed: () {
                              userProvider.deleteAccount(context);
                            },
                            text: 'Delete Account',
                          ),
                        ],
                      ),
                    ],
                  )),
                );
              }
            }

            return const CircularProgressIndicator(color: kPrimaryGoldColor);
          }),
    );
  }
}
