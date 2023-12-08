import "package:avec_moi_with_us/models/user/information/password.dart";
import "package:avec_moi_with_us/services/user/information.dart";
import "package:avec_moi_with_us/utils/exception.dart";
import "package:avec_moi_with_us/widgets/title.dart";
import "package:avec_moi_with_us/widgets/toast_notification.dart";
import "package:flutter/material.dart";

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({super.key});
  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  final _formKeyOldPassword = GlobalKey<FormState>();
  final _formKeyNewPassword = GlobalKey<FormState>();
  final _formKeyConfirmPassword = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final FocusNode oldPasswordNode=FocusNode();
  final FocusNode newPasswordNode=FocusNode();
  final FocusNode confirmPasswordNode=FocusNode();

  @override
  void dispose() {
    oldPasswordNode.dispose();
    oldPasswordController.dispose();
    newPasswordNode.dispose();
    newPasswordController.dispose();
    confirmPasswordNode.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  InformationService i=InformationService();
  Future<void> edit() async {
    try{
      await i.editPassword(RequestEditPassword(oldPasswordController.text, newPasswordController.text));
      toastInfo(context, "成功更新", "成功修改個人密碼");
      Navigator.pop(context);
    } on AuthException{
      toastError(context, "權限錯誤", "請重新登入");
    } catch (e){
      toastError(context, "更新錯誤", "出現未知錯誤 請稍後再嘗試");
    }

  }

  @override
  Widget build(BuildContext context) {
    void submitForm() {
      if (_formKeyOldPassword.currentState!.validate() && _formKeyNewPassword.currentState!.validate() && _formKeyConfirmPassword.currentState!.validate()) {
        edit();
      }
    }

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
                const TitleBarSubPage(title: "Edit Password"),
                Flexible(
                  flex:13,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Semantics(label:"修改密碼的提示標籤",child: Text('更改密碼 :',style: Theme.of(context).textTheme.displayMedium,)),
                        Flexible(
                          flex:1,
                          child: Semantics(
                            label: "輸入原始密碼的輸入框",
                            child: Form(
                              key: _formKeyOldPassword,
                              child: TextFormField(
                                style: Theme.of(context).textTheme.displaySmall,
                                controller: oldPasswordController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: "原始密碼",
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
                                obscureText: true,
                                focusNode: oldPasswordNode,
                                onFieldSubmitted: (value){
                                  if (_formKeyOldPassword.currentState!.validate()){
                                    FocusScope.of(context).requestFocus(newPasswordNode);
                                  }
                                  else{
                                    FocusScope.of(context).requestFocus(oldPasswordNode);
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Empty Error';
                                  }
                                  else if(value.contains(' ')){
                                    return 'Space Error';
                                  }
                                  else if(value.length<8){
                                    return 'At least 8 chars Error';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Semantics(
                            label: "輸入新密碼的輸入框",
                            child: Form(
                              key: _formKeyNewPassword,
                              child: TextFormField(
                                style: Theme.of(context).textTheme.displaySmall,
                                controller: newPasswordController,
                                maxLines: 1,
                                focusNode: newPasswordNode,
                                decoration: InputDecoration(
                                  hintText: "新密碼",
                                  hintMaxLines: 1,
                                  labelStyle: Theme.of(context).textTheme.displaySmall,
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
                                  fillColor: Colors.lightBlueAccent,
                                  hintStyle: Theme.of(context).textTheme.displaySmall,
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Empty Error';
                                  }
                                  else if(value==oldPasswordController.text.toString()){
                                    return 'Same with current Error';
                                  }
                                  else if(value.contains(' ')){
                                    return 'Have space Error';
                                  }
                                  else if(value.length<8){
                                    return 'At least 8 chars Error';
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (value){
                                  if (_formKeyOldPassword.currentState!.validate() && _formKeyNewPassword.currentState!.validate()){
                                    FocusScope.of(context).requestFocus(confirmPasswordNode);
                                  }
                                  else{
                                    FocusScope.of(context).requestFocus(newPasswordNode);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Semantics(
                            label: "確認新密碼的輸入框",
                            child: Form(
                              key: _formKeyConfirmPassword,
                              child: TextFormField(
                                style: Theme.of(context).textTheme.displaySmall,
                                controller: confirmPasswordController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: "確認新密碼",
                                  hintMaxLines: 1,
                                  labelStyle: Theme.of(context).textTheme.displaySmall,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(color: Colors.transparent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(color: Colors.transparent),
                                  ),
                                  filled: true,
                                  fillColor: Colors.lightBlueAccent,
                                  hintStyle: Theme.of(context).textTheme.displaySmall,
                                ),
                                obscureText: true,
                                focusNode: confirmPasswordNode,
                                onFieldSubmitted: (value){
                                  if (_formKeyOldPassword.currentState!.validate() && _formKeyNewPassword.currentState!.validate() && _formKeyConfirmPassword.currentState!.validate()){
                                    submitForm();
                                  }
                                  else{
                                    FocusScope.of(context).requestFocus(confirmPasswordNode);
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Empty Error';
                                  }
                                  else if (value != newPasswordController.text.toString()) {
                                    return 'Match Error';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container()
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex:2,
                  child: Container(
                    alignment: Alignment.center,
                    child: Semantics(
                      label: "送出修改密碼的按鈕",
                      child: ElevatedButton(
                          onPressed: (){submitForm();},
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