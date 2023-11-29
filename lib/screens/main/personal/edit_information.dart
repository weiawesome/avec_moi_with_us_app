import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class EditInformationPage extends StatefulWidget {
  const EditInformationPage({super.key});
  @override
  State<EditInformationPage> createState() => _EditInformationPageState();
}

class _EditInformationPageState extends State<EditInformationPage> {
  int groupValue=0;
  late TextEditingController _controller;

  late final String originalName;
  late final String originalGender;

  Map<int,String> genderIndex={
    0:"male",1:"female",2:"other"
  };
  Widget formatGenderUI(int index){
    final String gender=genderIndex[index]!;
    return Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),child: Text(gender,style: Theme.of(context).textTheme.displaySmall));
  }
  @override
  void initState() {
    super.initState();
    _controller= TextEditingController();
    _controller.text="name";

    originalName="name";
    originalGender="male";
    groupValue=0;
}

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
                          child: Text("Edit Information",style: Theme.of(context).textTheme.titleMedium,),
                        ),
                      ),
                    ],

                  ),
                ),
                Flexible(
                  flex:10,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(flex: 1,child: Container(),),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text('姓名 :', style: Theme.of(context).textTheme.displayMedium,)
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    style: Theme.of(context).textTheme.displaySmall,
                                    controller: _controller,
                                    textAlignVertical: TextAlignVertical.center,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      hintText: "Name",
                                      hintMaxLines: 1,
                                      labelStyle: Theme.of(context).textTheme.displayMedium,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(color: Colors.transparent),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(color: Colors.transparent), // 設置顏色為透明
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFFFFE27C),
                                      hintStyle: Theme.of(context).textTheme.displaySmall,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 1,child: Container(),),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text('性別 :', style: Theme.of(context).textTheme.displayMedium,)
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ListView(
                                    physics: const NeverScrollableScrollPhysics(),
                                    children: [
                                      CupertinoSlidingSegmentedControl(
                                        backgroundColor: Colors.white,
                                        thumbColor: Color(0xFFFFE27C),
                                          groupValue: groupValue,
                                          children:{
                                            0: formatGenderUI(0),
                                            1: formatGenderUI(1),
                                            2: formatGenderUI(2)
                                          },
                                          onValueChanged: (value){
                                            setState(() {
                                              groupValue=value!;
                                            });
                                          }
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 1,child: Container(),),

                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex:2,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 30.0),
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