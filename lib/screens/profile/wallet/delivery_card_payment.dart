import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gold_line/screens/profile/wallet/wallet.dart';
import 'package:gold_line/utility/helpers/routing.dart';
import 'package:gold_line/utility/providers/getTransactionHistory.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DeliveryCardPayment extends StatefulWidget {
  final String url, amount;
  const DeliveryCardPayment({Key? key, required this.url, required this.amount}) : super(key: key);

  @override
  State<DeliveryCardPayment> createState() => _DeliveryCardPaymentState();
}

class _DeliveryCardPaymentState extends State<DeliveryCardPayment> {
  final Completer<WebViewController> controllerCompleter = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        final WebViewController controller = await controllerCompleter.future;
        if (await controller.canGoBack()) {
          verifyDeliveryPayment(widget.amount, context);
          controller.goBack();
          return false; // Prevent closing the WebView page
        }
        verifyDeliveryPayment(widget.amount, context);

        return true; //
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Paystack Checkout'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              verifyDeliveryPayment(widget.amount, context);

            },
          ),
        ),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          userAgent: 'Flutter;Webview',
          navigationDelegate: (navigation) async {
            if(navigation.url == 'https://standard.paystack.co/close'){
              deposit(widget.amount, context);
              Navigator.of(context).pop(); //close webview
              changeScreen(context, const WalletScreen());
            }
            if(navigation.url == "https://hello.pstk.xyz/callback"){
              Navigator.of(context).pop(); //close webview
            }
            return NavigationDecision.navigate;
          },

          onPageFinished: (String url) {
            if (url.contains('/transaction/verify/')) {
              print("complete");
              Navigator.pop(context);
              changeScreen(context, WalletScreen());
              // Handle payment completion
            }
          },
        ),
      ),
    );
  }
}
