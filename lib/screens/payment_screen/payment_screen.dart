import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utility/helpers/constants.dart';
import '../../utility/helpers/custom_button.dart';

TextEditingController fullNameController = TextEditingController();
TextEditingController cardNumberController = TextEditingController();
TextEditingController expiryDateController = TextEditingController();
TextEditingController cvvController = TextEditingController();

class PaymentScreen extends StatefulWidget {
  static const String iD = '/paymentScreen';
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool optionIsCash = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryGoldColor,
      appBar: AppBar(
        backgroundColor: kPrimaryGoldColor,
        elevation: 0,
        leadingWidth: size.width / 9,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 20,
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Payments",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width / 14, vertical: size.height / 80),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          "Payment Methods",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height / 80),
                    SizedBox(
                      width: size.width,
                      height: size.height / 19,
                      child: InkWell(
                        onTap: (() {
                          setState(() {
                            optionIsCash = true;
                          });
                          print("optionIsCash is now $optionIsCash");
                        }),
                        child: ListTile(
                          contentPadding: const EdgeInsets.only(left: 5),
                          minVerticalPadding: 5,
                          leading: const Icon(FontAwesomeIcons.moneyBill1,
                              color: Colors.white),
                          minLeadingWidth: 5,
                          title: const Text(
                            "Cash",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          trailing: Icon(Icons.circle,
                              color:
                                  optionIsCash ? Colors.blue : Colors.white38),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height / 19,
                      child: InkWell(
                        onTap: (() {
                          setState(() {
                            optionIsCash = false;
                          });
                          print("optionIsCash is now $optionIsCash");
                        }),
                        child: ListTile(
                          contentPadding: const EdgeInsets.only(left: 5),
                          minVerticalPadding: 5,
                          leading: const Icon(FontAwesomeIcons.creditCard,
                              color: Colors.white),
                          minLeadingWidth: 5,
                          title: const Text(
                            "Add Debit/Credit Card",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_circle_right,
                              color:
                                  optionIsCash ? Colors.white38 : Colors.blue),
                        ),
                      ),
                    ),
                    //
                    SizedBox(
                      child: optionIsCash
                          ? SizedBox(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: size.height / 4,
                                  ),
                                  const Text(
                                    "Sorry,\ncash payment is temporarily unavailable,\nkindly use your card.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : AddCardDetails(size),
                    )
                  ],
                ),
              ),
            ),
          ),
          CustomButton(
            onPressed: () {
              const snackBar = SnackBar(
                content: Text('Card Saved Successfully'),
              );
              //Save card details
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Card Saved Successfully")));
            },
            text: "Done",
            fontSize: 20,
            width: size.width / 2.5,
            height: size.height * 0.06,
            elevation: 8,
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget AddCardDetails(size) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: size.height / 30),
          // SvgPicture.asset("assets/images/atm_card.svg"),
          SizedBox(height: size.height / 60),
          TextField(
            controller: fullNameController,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
            decoration: const InputDecoration(
                labelText: "Full Name",
                hintText: "Enter your full name as it appears on the card",
                filled: false,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                contentPadding: EdgeInsets.all(5)),
          ),
          SizedBox(height: size.height / 40),
          TextField(
            controller: cardNumberController,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
            decoration: InputDecoration(
              labelText: "Card Number",
              hintText: "Enter your card number",
              filled: false,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white54),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.white54,
                ),
                onPressed: () {
                  //Open Camera
                },
              ),
            ),
          ),
          SizedBox(height: size.height / 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * 0.50,
                child: TextField(
                  controller: expiryDateController,
                  keyboardType: TextInputType.datetime,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Expiry Date",
                    hintText: "11/2024",
                    filled: false,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.28,
                child: TextField(
                  controller: cvvController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  decoration: const InputDecoration(
                    labelText: "CVV",
                    hintText: "892",
                    filled: false,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
