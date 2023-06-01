import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:provider/provider.dart';

import '../../../utility/helpers/constants.dart';
import '../../../utility/providers/get_list_provider.dart';
import '../../../utility/services/calls_and_sms.dart';

class DeliveryDetailsScreen extends StatefulWidget {
  final String? title;
  final String? pickUpLocation;
  final String? dropOffLocation;
  final String? description;
  final String? date;
  final String? price;
  final String? riderFirstName;
  final String? riderLastName;

  final String? riderPhoneNumber;
  final String? riderPlateNumber;
  final String? paymentMethod;
  final String? status;
  final String? paymentBy;
  final String? paymentStatus;
  final String? pickUpLatitude,
      pickUpLongitude,
      dropOffLatitude,
      dropOffLongitude;
  final String? receiverName;
  final String? receiverPhone;
  final String? senderName;
  final String? senderPhone;

  const DeliveryDetailsScreen(
      {Key? key,
        this.title,
        this.description,
        this.dropOffLocation,
        this.price,
        this.riderFirstName,
        this.riderLastName,
        this.riderPhoneNumber,
        this.riderPlateNumber,
        this.date,
        this.senderPhone,
        this.senderName,
        this.receiverPhone,
        this.receiverName,
        this.paymentMethod,
        this.paymentStatus,
        this.status,
        this.paymentBy,
        this.dropOffLatitude,
        this.dropOffLongitude,
        this.pickUpLatitude,
        this.pickUpLongitude,
        this.pickUpLocation})
      : super(key: key);

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final deliveryListProvider =
    Provider.of<GetListProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery Details"),
        backgroundColor: kPrimaryGoldColor,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Delivery Time", style: TextStyle(fontWeight: FontWeight.w100),),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(widget.date ?? "Today"),
                    SizedBox(
                      height: 20.h,
                    ),

                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: const BorderSide(width: 0.1, color: Colors.black), // Specify border width and color
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
                        child: Column(
                          children: [
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Track Order", style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(
                                  "Delivery #${widget.title}",
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Divider( color: Colors.black,),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("Sender Details", style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.sp
                              ),),
                            ),
                            SizedBox(height: 10.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: CircleAvatar(
                                      child: Icon(Icons.person, color: kPrimaryGoldColor, size: 14.r,),
                                      backgroundColor: kPrimaryGoldColor.withOpacity(0.1),
                                      radius: 16.r,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 15,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Sender Name: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Text("${widget.senderName}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.appHeight(context),
                                      ),
                                      Row(
                                        children: [
                                          Text("Sender Phone: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                          Text("${widget.senderPhone}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text("Pickup Location: ${widget.pickUpLocation}",
                                        softWrap: true,),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Center(
                                      child: CircleAvatar(
                                        child: IconButton(
                                            onPressed: () {
                                              CallsAndMessagesService().call(widget.senderPhone!);
                                            },
                                            icon: Icon(Icons.call, color: Colors.black, size: 9.r,)),
                                        backgroundColor: Colors.grey,
                                        radius: 12.r,
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 20.h,),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("Receiver Details", style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.sp
                              ),),
                            ),
                            SizedBox(height: 10.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: CircleAvatar(
                                      child: Icon(Icons.edit_document, color: kPrimaryGoldColor, size: 14.r,),

                                      backgroundColor: kPrimaryGoldColor.withOpacity(0.1),
                                      radius: 16.r,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 15,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Receiver Name: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Text("${widget.receiverName}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.appHeight(context),
                                      ),
                                      Row(
                                        children: [
                                          Text("Receiver Phone: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                          Text("${widget.receiverPhone}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text("Drop Off Location: ${widget.dropOffLocation}",
                                        softWrap: true,),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Center(
                                      child: CircleAvatar(
                                        child: IconButton(
                                            onPressed: () {
                                              CallsAndMessagesService().call(widget.receiverPhone!);
                                            },
                                            icon: Icon(Icons.call, color: Colors.black, size: 9.r,)),
                                        backgroundColor: Colors.grey,
                                        radius: 12.r,
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            )


                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20.appHeight(context),
                    ),

                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: const BorderSide(width: 0.1, color: Colors.black), // Specify border width and color
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
                        child: Column(
                          children: [
                            SizedBox(height: 10.h),

                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("Rider Details", style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.sp
                              ),),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Divider( color: Colors.black,),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: CircleAvatar(
                                      child: Icon(Icons.motorcycle, color: kPrimaryGoldColor, size: 14.r,),
                                      backgroundColor: kPrimaryGoldColor.withOpacity(0.1),
                                      radius: 16.r,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 15,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Rider's Name: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Text("${widget.riderFirstName!} ${widget.riderLastName!}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.appHeight(context),
                                      ),
                                      Row(
                                        children: [
                                          Text("Rider's Phone: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                          Text("${widget.riderPhoneNumber}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          Text("Bike's Plate Number: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                          Text("${widget.riderPlateNumber}")
                                        ],
                                      ), ],
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20.appHeight(context),
                    ),

                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: const BorderSide(width: 0.1, color: Colors.black), // Specify border width and color
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
                        child: Column(
                          children: [
                            SizedBox(height: 10.h),

                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("Payment Details", style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.sp
                              ),),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Divider( color: Colors.black,),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: CircleAvatar(
                                      child: Icon(Icons.payments, color: kPrimaryGoldColor, size: 14.r,),
                                      backgroundColor: kPrimaryGoldColor.withOpacity(0.1),
                                      radius: 16.r,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 15,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Amount: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Text("${widget.price}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.appHeight(context),
                                      ),
                                      Row(
                                        children: [
                                          Text("Payment Method: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                          Text("${widget.paymentMethod}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          Text("Payment By: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                          Text("${widget.paymentBy}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          Text("Payment Status: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                          Text("${widget.paymentStatus}")
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
