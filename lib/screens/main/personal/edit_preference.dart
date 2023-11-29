import "dart:ffi";

import "package:avec_moi_with_us/models/user/information/preference.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class EditPreferencePage extends StatefulWidget {
  const EditPreferencePage({super.key});
  @override
  State<EditPreferencePage> createState() => _EditPreferencePageState();
}

class _EditPreferencePageState extends State<EditPreferencePage> {
  Set<int> selectedItems = <int>{};
  final data = genreIndexPair.keys.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex:2,
                  child: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      },
                          icon: Icon(Icons.arrow_back_ios_rounded)
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                          margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text("Edit Preference",style: Theme.of(context).textTheme.titleMedium,),
                        ),
                      ),
                    ],

                  ),
                ),
                Flexible(
                  flex:14,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemBuilder: (context, index) {
                      bool isSelected = selectedItems.contains(index);
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedItems.remove(index);
                            } else {
                              selectedItems.add(index);
                            }
                          });
                        },
                        child: Card(
                          color: isSelected ? Color(0xFFFFE27C) : null,
                          child: Center(
                            child: Text(genreIndexPair[data[index]]!),
                          ),
                        ),
                      );
                    },
                    // 資料的數量
                    itemCount: data.length,
                  ),
                ),
                Flexible(
                  flex:2,
                  child: ElevatedButton(
                      onPressed: (){},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xA8FF0000)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                        ),
                      ),
                      child: Text("EDIT",style: TextStyle(color: Colors.white),)
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}