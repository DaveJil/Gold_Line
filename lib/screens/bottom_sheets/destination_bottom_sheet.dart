import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DestinationBottomSheet extends StatefulWidget {
  const DestinationBottomSheet({Key? key}) : super(key: key);

  @override
  _DestinationBottomSheetState createState() => _DestinationBottomSheetState();
}

class _DestinationBottomSheetState extends State<DestinationBottomSheet> {
  TextEditingController searchAddress = TextEditingController();
   @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      minChildSize: 0.25,
      maxChildSize: 0.4,
      builder: (BuildContext context, myScrollController){
        return SafeArea(
          child: SingleChildScrollView(
            controller: myScrollController,
            padding: const EdgeInsets.all(5),
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(1.0, 5.0),
                      blurRadius: 10,
                      spreadRadius: 3)
                ],
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      height: 40.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white,
                        boxShadow:const [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 5.0),
                              blurRadius: 10,
                              spreadRadius: 3)
                        ],
                      ),


                      child: TextFormField(
                        textInputAction: TextInputAction.search,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            hintText: "Enter Destination ",
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: searchAndNavigate,
                              iconSize: 20.0,
                            )
                        ),
                        onChanged: (val) {
                          setState(() {
                            searchAddress = val as TextEditingController;
                          }
                          );
                        },
                        onFieldSubmitted: (term) {
                          searchAndNavigate();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget addressCard(Function onPressed, String title, String description) {
     return InkWell(
       child: Card(
         child: Row(
           children: [
             SvgPicture.asset(''),
             Column(
               children: [
                 Text(title),
                 Text(description)
               ],
             )
           ],
         ),
       ),
       onTap: onPressed(),
     );
  }
}



void searchAndNavigate() {

}



