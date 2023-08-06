import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/screens/map/map_widget.dart';
import 'package:gold_line/screens/profile/wallet/deposit%20screen.dart';
import 'package:gold_line/screens/profile/wallet/transaction_item.dart';
import 'package:gold_line/screens/profile/wallet/withdrawal_screen.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';

import '../../../utility/helpers/constants.dart';
import '../../../utility/helpers/routing.dart';
import '../../../utility/providers/getTransactionHistory.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            removeScreenUntil(context, MapWidget());
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Wallet Balance",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(height: 50.appHeight(context)),
                Text(
                  "Available Balance",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 10.appHeight(context)),
                FutureBuilder(
                    future: getWalletBalance(context),
                    builder: (context, snapshot) {
                      // Checking if future is resolved
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If we got an error
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              '${snapshot.error} occurred',
                              style: TextStyle(
                                  fontSize: 18, color: kPrimaryGoldColor),
                            ),
                          );

                          // if we got our data
                        } else if (snapshot.hasData) {
                          // Extracting data from snapshot object
                          final data = snapshot.data;
                          return Text(
                            "₦$data",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 40),
                          );
                        }
                      }

                      return CircularProgressIndicator(
                        color: kPrimaryGoldColor,
                      );
                    }),
                SizedBox(height: 30.appHeight(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth / 3,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryGoldColor,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10)),
                          onPressed: () {
                            changeScreen(context, DepositScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.plus),
                              SizedBox(
                                width: 7,
                              ),
                              Text("Fund")
                            ],
                          )),
                    ),
                    SizedBox(
                      width: screenWidth / 10,
                    ),
                    SizedBox(
                      width: screenWidth / 3,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[400],
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 5)),
                          onPressed: () {
                            changeScreen(context, WithdrawalScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.download,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Withdraw",
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.appHeight(context),
                ),
                FutureBuilder(
                    future: getTransactionHistory(),
                    builder: (context, snapshot) {
                      // Checking if future is resolved
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If we got an error
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              '${snapshot.error} occurred',
                              style: TextStyle(
                                  fontSize: 18, color: kPrimaryGoldColor),
                            ),
                          );

                          // if we got our data
                        } else if (snapshot.hasData) {
                          // Extracting data from snapshot object
                          final data = snapshot.data;
                          if (data!.isNotEmpty) {
                            return ListView.builder(
                              itemCount: data!.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return TransactionItem(
                                  id: data[index].id.toString(),
                                  inOut: data[index].inout.toString(),
                                  title: data[index].title.toString(),
                                  createdAt: data[index].createdAt.toString(),
                                  amount: data[index].amount.toString(),
                                  orderId: data[index].orderId.toString(),
                                );
                              },
                            );
                          } else {
                            return Align(
                                alignment: Alignment.center,
                                child: Center(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'You have not made any transactions yet',
                                    ),
                                  ),
                                ));
                          }
                        }
                      }

                      return CircularProgressIndicator(
                        color: kPrimaryGoldColor,
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
