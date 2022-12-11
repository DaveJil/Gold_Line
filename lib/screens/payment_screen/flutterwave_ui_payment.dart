import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utility/api.dart';
import '../../utility/helpers/constants.dart';
import '../../utility/helpers/custom_button.dart';
import '../../utility/helpers/routing.dart';
import '../map/map_widget.dart';
import 'cash_payment screen.dart';

TextEditingController fullNameController = TextEditingController();
TextEditingController cardNumberController = TextEditingController();
TextEditingController expiryDateController = TextEditingController();
TextEditingController cvvController = TextEditingController();

class FlutterwavePaymentScreen extends StatefulWidget {
  static const String iD = '/paymentScreen';
  String price;
  String email;
  String phone;
  String ref_id;
  FlutterwavePaymentScreen(
      {Key? key,
      required this.price,
      required this.email,
      required this.phone,
      required this.ref_id})
      : super(key: key);

  @override
  _FlutterwavePaymentScreenState createState() =>
      _FlutterwavePaymentScreenState();
}

class _FlutterwavePaymentScreenState extends State<FlutterwavePaymentScreen> {
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
                            "Pay With Card",
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
                  ],
                ),
              ),
            ),
          ),
          CustomButton(
            onPressed: () {
              optionIsCash ? payWithCash() : makeCardPayment();
            },
            text: "Pay",
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

  void makeCardPayment() async {
    final Customer customer =
        Customer(name: "", phoneNumber: widget.phone, email: widget.email);
    final flutterwave = Flutterwave(
        context: context,
        publicKey: "",
        currency: "NGN",
        amount: widget.price,
        txRef: widget.ref_id,
        customer: customer,
        paymentOptions: 'card',
        customization: Customization(),
        redirectUrl: '',
        isTestMode: true);

    final ChargeResponse response = await flutterwave.charge();
    if (response == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Transaction Failed Try Again"),
        backgroundColor: Colors.redAccent,
      ));
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String trip_id = prefs.getString("trip_id")!;
      if (response.status == "success") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Transaction Successful"),
          backgroundColor: Colors.green,
        ));
        await CallApi().postData(null, "user/trip/verify-payment/$trip_id");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MapWidget()),
            (Route<dynamic> route) => false);
      }
    }
  }

  void payWithCash() {
    changeScreen(context, const CashPaymentScreen());
  }
}
