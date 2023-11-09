import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';

import '../../../utility/helpers/constants.dart';

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
                                      backgroundColor: kPrimaryGoldColor.withOpacity(0.1),
                                      radius: 16.r,
                                      child: Icon(Icons.edit_document, color: kPrimaryGoldColor, size: 14.r,),
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
                                          const Text("Sender Name: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Text("${widget.senderName}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.appHeight(context),
                                      ),
                                      Row(
                                        children: [
                                          const Text("Sender Phone: ", style: TextStyle(fontWeight: FontWeight.bold)),
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
                                        backgroundColor: Colors.grey,
                                        radius: 12.r,
                                        child: Icon(Icons.call, color: Colors.black, size: 9.r,),
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
                                      backgroundColor: kPrimaryGoldColor.withOpacity(0.1),
                                      radius: 16.r,
                                      child: Icon(Icons.person, color: kPrimaryGoldColor, size: 14.r,),
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
                                          const Text("Receiver Name: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Text("${widget.receiverName}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.appHeight(context),
                                      ),
                                      Row(
                                        children: [
                                          const Text("Receiver Phone: ", style: TextStyle(fontWeight: FontWeight.bold)),
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
                                        backgroundColor: Colors.grey,
                                        radius: 12.r,
                                        child: Icon(Icons.call, color: Colors.black, size: 9.r,),
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
                                      backgroundColor: kPrimaryGoldColor.withOpacity(0.1),
                                      radius: 16.r,
                                      child: Icon(Icons.motorcycle, color: kPrimaryGoldColor, size: 14.r,),
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
                                          const AutoSizeText("Rider's Name: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Text("${widget.riderFirstName!} ${widget.riderLastName!}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.appHeight(context),
                                      ),
                                      Row(
                                        children: [
                                          const Text("Rider's Phone: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                          Text("${widget.riderPhoneNumber}",
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style:  TextStyle(
                                              fontSize: getHeight(16, context),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          const Text("Bike's Plate Number: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                          Text("${widget.riderPlateNumber}", softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style:  TextStyle(
                                              fontSize: getHeight(16, context),
                                            ),
                                          ),
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
                                      backgroundColor: kPrimaryGoldColor.withOpacity(0.1),
                                      radius: 16.r,
                                      child: Icon(Icons.payments, color: kPrimaryGoldColor, size: 14.r,),
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
                                          const Text("Amount: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Text("${widget.price}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.appHeight(context),
                                      ),
                                      Row(
                                        children: [
                                          const Text("Payment Method: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                          Text("${widget.paymentMethod}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          const Text("Payment By: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                          Text("${widget.paymentBy}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          const Text("Payment Status: ", style: TextStyle(fontWeight: FontWeight.bold)),
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
