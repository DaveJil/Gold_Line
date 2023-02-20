import 'package:flutter/material.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:provider/provider.dart';

import '../../../utility/helpers/constants.dart';
import '../../../utility/providers/get_list_provider.dart';
import 'delivery_card.dart';

class CompletedDeliveries extends StatefulWidget {
  const CompletedDeliveries({Key? key}) : super(key: key);

  @override
  State<CompletedDeliveries> createState() => _CompletedDeliveriesState();
}

class _CompletedDeliveriesState extends State<CompletedDeliveries> {
  late Future deliveries;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final deliveryListProvider =
          Provider.of<GetListProvider>(context, listen: false);
      deliveries = deliveryListProvider.checkPendingDelivery();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final deliveryListProvider =
        Provider.of<GetListProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                "Completed Deliveries",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              SizedBox(
                height: 10.appHeight(context),
              ),
              FutureBuilder(
                  future: deliveryListProvider.checkPendingDelivery(),
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
                              return CompletedDeliveryCard(
                                  description: data[index].description,
                                  id: data[index].id,
                                  title: data[index].id!.toString(),
                                  dropOffLocation: data[index].dropOffAddress!,
                                  price: data[index].price.toString(),
                                  status: data[index].status,
                                  pickUpLocation: data[index].pickupAddress!);
                            },
                          );
                        } else {
                          return Align(
                              alignment: Alignment.center,
                              child: Center(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'You have no Deliveries Yet',
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
    );
  }
}
