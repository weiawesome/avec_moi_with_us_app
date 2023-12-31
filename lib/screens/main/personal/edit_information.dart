import "package:avec_moi_with_us/models/user/information/information.dart";
import "package:avec_moi_with_us/services/user/information.dart";
import "package:avec_moi_with_us/utils/exception.dart";
import "package:avec_moi_with_us/widgets/title.dart";
import "package:avec_moi_with_us/widgets/toast_notification.dart";
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
  late String mail;

  Map<int,String> genderIndex={
    0:"male",1:"female",2:"other"
  };
  Map<String,int> indexGender={
    "male":0,"female":1,"other":2
  };
  Widget formatGenderUI(int index){
    final String gender=genderIndex[index]!;
    return Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),child: Text(gender,style: Theme.of(context).textTheme.displaySmall));
  }
  InformationService i=InformationService();
  @override
  void initState() {
    super.initState();
    _controller= TextEditingController();
    mail="";
    _refresh();
  }

  Future<void> _refresh() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try{
        ResponseInformation r=await i.getInformation();
        originalName=r.name;
        originalGender=r.gender;
        _controller.text=r.name;
        mail=r.mail;
        setState(() {
          groupValue=indexGender[r.gender]!;
        });
      } on AuthException{
        toastError(context, "權限錯誤", "請重新登入");
        Navigator.pop(context);
      } catch (e){
        toastError(context, "未知錯誤", "出現未知錯誤 請稍後再嘗試");
        Navigator.pop(context);
      }

    });
  }

  Future<void> edit() async {
    try{
      await i.editInformation(RequestEditInformation(_controller.text, genderIndex[groupValue]!));
      toastInfo(context, "成功更新", "成功修改個人資訊");
      Navigator.pop(context);
    } on AuthException{
      toastError(context, "權限錯誤", "請重新登入");
    } catch (e){
      toastError(context, "更新錯誤", "出現未知錯誤 請稍後再嘗試");
    }

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
                const TitleBarSubPage(title: "Edit Information"),
                Flexible(
                  flex:13,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                                    child: Semantics(label:"顯示名字的提示標籤",child: Text('姓名 :', style: Theme.of(context).textTheme.displayMedium,))
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Semantics(
                                    label: "更改姓名的輸入框",
                                    child: TextFormField(
                                      style: Theme.of(context).textTheme.displaySmall,
                                      controller: _controller,
                                      textAlignVertical: TextAlignVertical.center,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        hintText: "你的名字",
                                        hintMaxLines: 1,
                                        labelStyle: Theme.of(context).textTheme.displayMedium,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(color: Colors.transparent),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(color: Colors.transparent), // 設置顏色為透明
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFFFE27C),
                                        hintStyle: Theme.of(context).textTheme.displaySmall,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                                    child: Semantics(label:"顯示信箱的提示標籤",child: Text('信箱 :', style: Theme.of(context).textTheme.displayMedium,))
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Semantics(label:"顯示個人信箱訊息",child: Text(mail, style: Theme.of(context).textTheme.displaySmall,)),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                                    child: Semantics(label:"顯示性別的提示標籤",child: Text('性別 :', style: Theme.of(context).textTheme.displayMedium,))
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ListView(
                                    physics: const NeverScrollableScrollPhysics(),
                                    children: [
                                      Semantics(
                                        label:"點擊以修改個人性別的資訊",
                                        child: CupertinoSlidingSegmentedControl(
                                          backgroundColor: Colors.white,
                                          thumbColor: const Color(0xFFFFE27C),
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
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex:2,
                  child: Container(
                    alignment: Alignment.center,
                    child: Semantics(
                      label: "送出修改資訊的按鈕",
                      child: ElevatedButton(
                          onPressed: (){
                            edit();
                          },
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
                          child: const Text("EDIT",style: TextStyle(color: Colors.white),)
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