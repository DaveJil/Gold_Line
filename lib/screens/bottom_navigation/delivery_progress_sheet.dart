// import 'package:flutter/material.dart';
// import 'package:gold_line/utility/helpers/constants.dart';
// import 'package:gold_line/utility/helpers/dimensions.dart';
// import 'package:gold_line/utility/providers/map_provider.dart';
// import 'package:provider/provider.dart';
//
// import '../../utility/helpers/custom_text.dart';
//
// class DeliverySentBottomSheet extends StatefulWidget {
//   const DeliverySentBottomSheet({Key? key}) : super(key: key);
//
//   @override
//   _DeliverySentBottomSheetState createState() =>
//       _DeliverySentBottomSheetState();
// }
//
// class _DeliverySentBottomSheetState extends State<DeliverySentBottomSheet> {
//   TextEditingController searchAddress = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//       initialChildSize: 0.25,
//       minChildSize: 0.25,
//       maxChildSize: 0.4,
//       builder: (BuildContext context, myScrollController) {
//         return SafeArea(
//           child: SingleChildScrollView(
//             controller: myScrollController,
//             padding: const EdgeInsets.all(5),
//             child: Container(
//               height: MediaQuery.of(context).size.height,
//               padding: const EdgeInsets.all(12),
//               margin: const EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5.0),
//                 color: kPrimaryGoldColor,
//                 boxShadow: const [
//                   BoxShadow(
//                       color: Colors.grey,
//                       offset: Offset(1.0, 5.0),
//                       blurRadius: 10,
//                       spreadRadius: 3)
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Container(
//                   height: 40.0,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16.0),
//                     color: Colors.white,
//                     boxShadow: const [
//                       BoxShadow(
//                           color: Colors.grey,
//                           offset: Offset(1.0, 5.0),
//                           blurRadius: 10,
//                           spreadRadius: 3)
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Image.asset("assets/tick.png"),
//                       SizedBox(height: 10.appHeight(context)),
//                       const Text("Delivery Created \n Successfully"),
//                       SizedBox(
//                         height: 10.appHeight(context),
//                       ),
//                       const Text("Order No# 000001234"),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class DriverFoundWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     MapProvider appState = Provider.of<MapProvider>(context);
//
//     return DraggableScrollableSheet(
//         initialChildSize: 0.2,
//         minChildSize: 0.05,
//         maxChildSize: 0.8,
//         builder: (BuildContext context, myscrollController) {
//           return Container(
//             decoration: BoxDecoration(color: kVistaWhite,
// //                        borderRadius: BorderRadius.only(
// //                            topLeft: Radius.circular(20),
// //                            topRight: Radius.circular(20)),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.grey.withOpacity(.8),
//                       offset: Offset(3, 2),
//                       blurRadius: 7)
//                 ]),
//             child: ListView(
//               controller: myscrollController,
//               children: [
//                 SizedBox(
//                   height: 12,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                         child: appState.driverArrived == false
//                             ? CustomText(
//                                 text:
//                                     'Your ride arrives in ${appState.routeModel!.timeNeeded.text}',
//                                 size: 12,
//                                 weight: FontWeight.w300,
//                               )
//                             : CustomText(
//                                 text: 'Your ride has arrived',
//                                 size: 12,
//                                 color: Colors.greenAccent,
//                                 weight: FontWeight.w500,
//                               )),
//                   ],
//                 ),
//                 Divider(),
//                 ListTile(
//                   leading: Container(
//                     child: appState.driverModel?.phone == null
//                         ? CircleAvatar(
//                             radius: 30,
//                             child: Icon(
//                               Icons.person_outline,
//                               size: 25,
//                             ),
//                           )
//                         : CircleAvatar(
//                             radius: 30,
//                             backgroundImage:
//                                 NetworkImage(appState.driverModel!.photo!),
//                           ),
//                   ),
//                   title: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       RichText(
//                           text: TextSpan(children: [
//                         TextSpan(
//                             text: appState.driverModel!.name! + "\n",
//                             style: TextStyle(
//                                 fontSize: 17, fontWeight: FontWeight.bold)),
//                         TextSpan(
//                             text: appState.driverModel.car,
//                             style: TextStyle(
//                                 fontSize: 14, fontWeight: FontWeight.w300)),
//                       ], style: TextStyle(color: Colors.black))),
//                     ],
//                   ),
//                   subtitle: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.grey.withOpacity(0.5),
//                       ),
//                       onPressed: null,
//                       child: CustomText(
//                         text: appState.driverModel.plate,
//                         color: white,
//                       )),
//                   trailing: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.green.withOpacity(0.3),
//                           borderRadius: BorderRadius.circular(20)),
//                       child: IconButton(
//                         onPressed: () {
//                           // _service.call(appState.driverModel.phone);
//                         },
//                         icon: Icon(Icons.call),
//                       )),
//                 ),
//                 Divider(),
//                 Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: CustomText(
//                     text: "Ride details",
//                     size: 18,
//                     weight: FontWeight.bold,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Container(
//                       height: 100,
//                       width: 10,
//                       child: Column(
//                         children: [
//                           Icon(
//                             Icons.location_on,
//                             color: Colors.grey,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 9),
//                             child: Container(
//                               height: 45,
//                               width: 2,
//                               color: primary,
//                             ),
//                           ),
//                           Icon(Icons.flag),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: 30,
//                     ),
//                     RichText(
//                         text: TextSpan(children: [
//                       TextSpan(
//                           text: "\nPick up location \n",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 16)),
//                       TextSpan(
//                           text: "25th avenue, flutter street \n\n\n",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w300, fontSize: 16)),
//                       TextSpan(
//                           text: "Destination \n",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 16)),
//                       TextSpan(
//                           text: "25th avenue, flutter street \n",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w300, fontSize: 16)),
//                     ], style: TextStyle(color: Colors.black))),
//                   ],
//                 ),
//                 Divider(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: CustomText(
//                         text: "Ride price",
//                         size: 18,
//                         weight: FontWeight.bold,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: CustomText(
//                         text: "\$${appState.ridePrice}",
//                         size: 18,
//                         weight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                     ),
//                     child: CustomText(
//                       text: "Cancel Ride",
//                       color: Colors.white,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           );
//         });
//   }
// }
