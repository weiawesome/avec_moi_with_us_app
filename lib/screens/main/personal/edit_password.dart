import "package:flutter/cupertino.dart";
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

  @override
  Widget build(BuildContext context) {
    void submitForm() {
      if (_formKeyOldPassword.currentState!.validate() && _formKeyNewPassword.currentState!.validate() && _formKeyConfirmPassword.currentState!.validate()) {
        print("GAGA");
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
                          child: Text("Edit Password",style: Theme.of(context).textTheme.titleMedium,),
                        ),
                      ),
                    ],

                  ),
                ),
                Flexible(
                  flex:10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('更改密碼 :',style: Theme.of(context).textTheme.displayMedium,),
                        Flexible(
                          flex:1,
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
                        Flexible(
                          flex: 1,
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
                        Flexible(
                          flex: 1,
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
                                contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: Colors.transparent),
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
                        Flexible(
                          flex: 2,
                          child: Container()
                        )

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