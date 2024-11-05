import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/helpers/dimensions.dart';
import 'package:gold_line/utility/helpers/routing.dart';

class SelectTypeCard extends StatelessWidget {
  final String? image;
  final String? titleText;
  final String? subText;
  final VoidCallback? onTap;


  const SelectTypeCard({Key? key, this.image, this.subText,this.titleText, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,

      child: Container(
        padding: EdgeInsets.symmetric( vertical: 20.appHeight(context) ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kPrimaryGoldColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(image!),

            Column(
              children: [
                Text(titleText!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: Colors.white), softWrap: true,
                textAlign: TextAlign.center,),
                SizedBox(height: 8.appHeight(context),),
                Text(subText!, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white),textAlign: TextAlign.center,),

              ],

            )
          ],
        ),
      ),
    );
  }
}
