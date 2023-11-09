import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gold_line/utility/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../utility/helpers/constants.dart';
import '../../utility/helpers/custom_button.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  bool uploadedStatus = false;
  String bankName = "Bank Name";

  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getBankList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      //-----------------------------------------------------------------
      // body: authProvider.status == Status.Authenticating
      //     ? Loading()
      //     : SingleChildScrollView(
      //-------------------------------------------------------------
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                size.width / 16, size.height / 20, size.width / 16, 0.0),
            height: size.height * 0.9,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 40,
                        color: kPrimaryGoldColor,
                      ),
                      const Text(
                        "Goldline",
                        style: TextStyle(
                          color: kPrimaryGoldColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(width: 30)
                    ],
                  ),
                  SizedBox(height: size.height / 35),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1.2,
                          color: kPrimaryGoldColor,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Payment Details",
                        style: TextStyle(
                            color: kPrimaryGoldColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 17),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Divider(
                          thickness: 1.2,
                          color: kPrimaryGoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height / 40),
                  SizedBox(
                    height: size.height / 20,
                    child: TextFormField(
                      // controller: authProvider.bankAccountName,
                      controller: userProvider.bankNameController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: GoldlineInputDeco.copyWith(
                        labelText: 'Bank Name',
                        hintText: 'Enter your bank name',
                        prefixIcon: Icon(
                          FontAwesomeIcons.buildingColumns,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height / 40),
                  SizedBox(
                    height: size.height / 20,
                    child: TextFormField(
                      // controller: authProvider.bankAccountName,
                      controller: userProvider.accountNameController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: GoldlineInputDeco.copyWith(
                        labelText: 'Bank Account Name',
                        hintText: 'Enter your bank account name',
                        prefixIcon: Icon(
                          CupertinoIcons.person_circle,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height / 40),
                  SizedBox(
                    height: size.height / 20,
                    child: TextFormField(
                      // controller: authProvider.bankAccountNumber,
                      controller: userProvider.accountNumberController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: GoldlineInputDeco.copyWith(
                        labelText: 'Bank Account Number',
                        hintText: 'Enter your bank account number',
                        prefixIcon: Icon(
                          CupertinoIcons.person_circle,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height / 35),
                ],
              ),
            ),
          ),
          CustomButton(
            onPressed: () {
              userProvider.addBankDetails(context);
            },
            text: "Update Bank Details",
            width: size.width / 2.5,
            height: size.height / 18,
          )
        ],
      ),
    );
  }

  List bankList = [];
  String bankUrl = "https://api.flutterwave.com/v3/banks/NG";

  Future getBankList() async {
    var response = await http.get(
      Uri.parse(bankUrl),
      // headers: {
      //   'Authorization': 'Bearer FLWSECK_TEST-SANDBOXDEMOKEY-X',
      // },
      headers: {
        HttpHeaders.authorizationHeader: "Bearer FLWSECK_TEST-SANDBOXDEMOKEY-X",
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    var data = json.decode(response.body);
    setState(() {
      bankList = data["name"];
    });
    return data;
  }

// Future getbanks() async {
//   final endlist = FlutterwaveAPIUtils.getBanks(
//       http.Client(), 'Bearer FLWSECK_TEST-SANDBOXDEMOKEY-X');
//   print(endlist);
//   return endlist;
// }
//
// Widget bankDropDownList() {
//   AuthenticationProvider provider = context.read<AuthenticationProvider>();
//   return DropdownSearch<dynamic>(
//       popupProps: const PopupProps.menu(
//         showSelectedItems: true,
//       ),
//       dropdownButtonProps: const DropdownButtonProps(
//         icon: Icon(Icons.keyboard_arrow_down, size: 30),
//         isVisible: true,
//         alignment: Alignment.centerRight,
//       ),
//       dropdownDecoratorProps: DropDownDecoratorProps(
//           dropdownSearchDecoration:
//               GoldlineInputDeco.copyWith(labelText: "Bank Name")),
//       onChanged: (value) {
//         setState(() {
//           bankName = value.toString();
//           provider.bankNameController.text = bankName;
//         });
//       },
//       selectedItem: bankName,
//       items: bankList.toList());
// }
}
