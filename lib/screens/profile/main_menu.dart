import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_line/screens/profile/profile.dart';
import 'package:gold_line/screens/profile/settings_page.dart';
import 'package:gold_line/screens/profile/wallet.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/custom_button.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:gold_line/widgets/otherDetailsDivider.dart';
import 'package:provider/provider.dart';

import '../../utility/providers/user_provider.dart';
import '../my_deliveries/interstate/my_deliveries.dart';
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
                print(datum);
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
                                      print(datum!.avatar);
                                      print(datum);
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
                        height: getHeight(15, context),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const UserProfileScreen()));
                        },
                        child: Text(
                          datum!.firstName! + " " + datum.lastName!,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.grey,
                            fontSize: getHeight(20, context),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(8, context),
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
                            'Agent',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.grey,
                              fontSize: getHeight(20, context),
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
                        leading: SvgPicture.asset("assets/my history.svg"),
                        title: const Text("My History"),
                        subtitle:
                            const Text("View all your previous transactions"),
                        trailing: const Icon(
                          Icons.arrow_circle_right_sharp,
                          color: kPrimaryGoldColor,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const MyDeliveriesScreen()));
                        },
                      ),
                      SizedBox(
                        height: getHeight(35, context),
                      ),
                      ListTile(
                        leading: SvgPicture.asset("assets/wallet balance.svg"),
                        title: const Text("Wallet Balance"),
                        subtitle: const Text(
                            "Check all your Commissions from  your Referrals"),
                        trailing: const Icon(
                          Icons.arrow_circle_right_sharp,
                          color: kPrimaryGoldColor,
                        ),
                        onTap: () {
                          changeScreen(context, WalletScreen());
                        },
                      ),
                      SizedBox(
                        height: getHeight(35, context),
                      ),
                      ListTile(
                        leading: SvgPicture.asset("assets/refferals.svg"),
                        title: const Text("Referrals"),
                        subtitle: const Text("Refer Agents to AreaConnect"),
                        trailing: const Icon(
                          Icons.arrow_circle_right_sharp,
                          color: kPrimaryGoldColor,
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
                                        uuid: datum!.uuid!,
                                      )));
                        },
                      ),
                      SizedBox(
                        height: getHeight(35, context),
                      ),
                      ListTile(
                        leading: SvgPicture.asset("assets/my coupons.svg"),
                        title: const Text("My Coupons"),
                        subtitle: const Text("View all your discounted offers"),
                        trailing: const Icon(
                          Icons.arrow_circle_right_sharp,
                          color: kPrimaryGoldColor,
                        ),
                        onTap: () {
                          final snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: "Coming soon",
                              message:
                                  "Coupons for discounts and promos would be available on the next update",
                              contentType: ContentType.help,
                            ),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        },
                      ),
                      SizedBox(
                        height: getHeight(35, context),
                      ),
                      ListTile(
                        leading: SvgPicture.asset("assets/settings.svg"),
                        title: const Text("Settings"),
                        subtitle: const Text("Edit your preferences"),
                        trailing: const Icon(
                          Icons.arrow_circle_right_sharp,
                          color: kPrimaryGoldColor,
                        ),
                        onTap: () {
                          changeScreen(context, const Settings());
                        },
                      ),
                      SizedBox(
                        height: getHeight(20, context),
                      ),
                      CustomButton(
                        width: MediaQuery.of(context).size.width / 3,
                        onPressed: () {
                          userProvider.signOut(context);
                        },
                        text: 'Log Out',
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
