import 'package:flutter/cupertino.dart';

import '../../../models/delivery_model/delivery.dart';
import 'delivery_item.dart';

class DeliveryListview extends StatelessWidget {
  DeliveryModel? deliveryModel;
  final List<DeliveryModel> deliveryList;
  DeliveryListview({
    Key? key,
    required this.deliveryList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        // final delivery = deliveryList[index];
        return DeliveryItem(
          Date: deliveryModel!.pickupTime!,
          Title: deliveryModel!.receiverName!,
          deliveryStatus: deliveryModel!.status,
          price: deliveryModel!.price!,
        );
      },
      itemCount: deliveryList.length,
    );
  }
}
