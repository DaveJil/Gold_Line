import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utility/helpers/constants.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("Support"),
        backgroundColor: kPrimaryGoldColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 50.h),
              const Center(
                child: Text("Need Help? Got A complaint?"),
              ),
              SizedBox(height: 5.h,),
              Center(
                child: Text("Contact Us Now at",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp
                ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Center(
                child: Image.asset('assets/support.png')
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text("Send a message to any of the following channels",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                        fontSize: 16.sp
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 19.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: kPrimaryGoldColor,
                    child: Icon(
                      Icons.mail, color: Colors.black,
                      size: 12,
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Email", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),),
                      const Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const Text(
                          """mail.goldline@gmail.com
info@areaconnect.com.ng
support@areaconnect.com.ng""")
                    ],
                  )
                ],
              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: kPrimaryGoldColor,
                    child: Icon(
                      Icons.edit, color: Colors.black,
                      size: 12,
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("WhatsApps, Facebook, Instagram", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),),
                      const Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const Text(
                          """WhatsApp: +234 814 389 5608
WhatsApp: +234 704 949 3166
Facebook: https://facebook.com/Goldlinepage
Instagram: @areaconnect.ng""")
                    ],
                  )
                ],
              )




            ],

          ),
        ),
      ),
    );
  }
}
