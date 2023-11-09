import 'package:flutter/material.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:provider/provider.dart';

import '../../../../utility/helpers/constants.dart';
import '../../../../utility/providers/get_list_provider.dart';
import 'delivery_card.dart';

class AcceptedDeliveries extends StatefulWidget {
  const AcceptedDeliveries({Key? key}) : super(key: key);

  @override
  State<AcceptedDeliveries> createState() => _AcceptedDeliveriesState();
}

class _AcceptedDeliveriesState extends State<AcceptedDeliveries> {
  late Future deliveries;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final deliveryListProvider =
          Provider.of<GetListProvider>(context, listen: false);
      deliveries = deliveryListProvider.checkAcceptedDelivery(context);
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
    ScrollController scrollController = ScrollController();
    final deliveryListProvider =
        Provider.of<GetListProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text(
                "Accepted Deliveries",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
              SizedBox(
                height: 10.appHeight(context),
              ),
              SingleChildScrollView(
                child: FutureBuilder(
                    future: deliveryListProvider
                        .checkAcceptedVansStateDelivery(context),
                    builder: (context, snapshot) {
                      // Checking if future is resolved
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If we got an error
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              '${snapshot.error} occurred',
                              style: const TextStyle(
                                  fontSize: 18, color: kPrimaryGoldColor),
                            ),
                          );

                          // if we got our data
                        } else if (snapshot.hasData) {
                          // Extracting data from snapshot object
                          final data = snapshot.data;
                          if (data!.isNotEmpty) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              controller: scrollController,
                              itemCount: data!.length,
                              shrinkWrap: true,
                              itemBuilder: (
                                BuildContext context,
                                int index,
                              ) {
                                return VansDeliveryCard(
                                  id: data[index].id!,
                                  description: data[index].description,
                                  type: data[index].type,
                                  title: data[index].id!.toString(),
                                  paymentStatus: data[index].paymentStatus,
                                  dropOffLocation: data[index].dropOffAddress!,
                                  price: data[index].price.toString(),
                                  status: data[index].status,
                                  pickUpLocation: data[index].pickupAddress!,
                                  date: data[index].pickupTime!,
                                  paymentMethod: data[index].paymentMethod!,
                                  riderFirstName: data[index].riderFirstName,
                                  riderLastName: data[index].riderLastName,
                                  riderPhoneNumber: data[index].riderPhone,
                                  riderPlateNumber:
                                      data[index].riderPlateNumber,
                                  paymentBy: data[index].paymentBy,
                                  senderName: data[index].senderName,
                                  senderPhone: data[index].senderPhone,
                                  receiverName: data[index].receiverName,
                                  receiverPhone: data[index].receiverPhone,
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
                                      'You have no Deliveries Yet',
                                    ),
                                  ),
                                ));
                          }
                        }
                      }

                      return const CircularProgressIndicator(
                        color: kPrimaryGoldColor,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
