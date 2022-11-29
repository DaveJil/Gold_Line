import 'package:flutter/material.dart';

import 'dimensions.dart';

class AddressDialogBox {
  BuildContext context;
  TextEditingController textEditingController;
  AddressDialogBox({
    required this.context,
    required this.textEditingController,
  });

//     // size

  Future dialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        // title: Text('Hello'),
        content: Container(
          height: getHeight(280, context),
          width: getWidth(365, context),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(getWidth(5, context)),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 36,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(
                  height: getHeight(10, context),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 8,
                  child: TextField(
                    controller: textEditingController,
                    autofocus: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.5),
                              width: 0.2,
                            )),
                        hintText: 'Add Home Address,',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.lightBlue,
                            width: 0.1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.lightBlue,
                            width: 0.2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 0.2,
                          ),
                        ),
                        suffixIcon: Icon(Icons.search),
                        prefixIcon: Icon(Icons.location_on)),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                SizedBox(
                  width: getWidth(70, context),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.white,
                      elevation: 8,
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        color: Color(0xff14108E),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
