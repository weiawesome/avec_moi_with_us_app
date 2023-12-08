import "package:avec_moi_with_us/models/user/information/information.dart";
import "package:avec_moi_with_us/services/user/authentication.dart";
import "package:avec_moi_with_us/services/user/information.dart";
import "package:avec_moi_with_us/utils/exception.dart";
import "package:avec_moi_with_us/utils/routes.dart";
import "package:avec_moi_with_us/widgets/title.dart";
import "package:avec_moi_with_us/widgets/toast_notification.dart";
import "package:flutter/material.dart";

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});
  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  AuthenticationService a=AuthenticationService();
  Future<void> logout() async {
    try{
      await a.logout();
    }finally{
      toastInfo(context, "成功更新", "成功登出");
      Navigator.popAndPushNamed(context, Routes.login);
    }
  }
  InformationService i=InformationService();
  String name="",gender="";

  @override
  void initState() {
    super.initState();
    getInformation();
  }
  Future<void> getInformation() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        ResponseInformation information = await i.getInformation();
        setState(() {
          name=information.name;
          gender=information.gender;
        });
      } on AuthException{
        toastError(context, "權限錯誤", "請重新登入");
        Navigator.popAndPushNamed(context, Routes.login);
      } catch (e){
        toastError(context, "未知錯誤", "出現未知錯誤 請稍後再嘗試");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleBar(title: "Personal Information"),
        Flexible(
          flex:15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 5,
                child: Semantics(
                  label: "個人名稱",
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        gender=="male"?
                        const Icon(Icons.face,size: 90,color: Colors.blueAccent,):
                        gender=="female"?
                        const Icon(Icons.face_3,size: 90,color: Colors.pink,):
                        const Icon(Icons.person_outline_rounded,size: 90,color: Colors.black,),
                        Text(name,style: Theme.of(context).textTheme.headlineLarge,)
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 8,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        label: "前往更改個人資訊頁面的按鈕",
                        child: TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, Routes.editInformation);
                            },
                            child: const Text("編輯個人資訊")
                        ),
                      ),
                      const Divider(),
                      Semantics(
                        label: "前往更改密碼頁面的按鈕",
                        child: TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, Routes.editPassword);
                            },
                            child: const Text("更改密碼")
                        ),
                      ),
                      const Divider(),
                      Semantics(
                        label: "前往更改個人偏好項目頁面的按鈕",
                        child: TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, Routes.editPreference);
                            },
                            child: const Text("更改偏好項目")
                        ),
                      ),
                      const Divider(),
                      Semantics(
                        label: "前往查看個人瀏覽歷史紀錄頁面的按鈕",
                        child: TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, Routes.history);
                            },
                            child:  const Text("歷史紀錄")
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex:2,
                child: Semantics(
                  label: "登出此應用程序的按鈕",
                  child: ElevatedButton(
                      onPressed: (){logout();},
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
                      child: const Text("LOG OUT",style: TextStyle(color: Colors.white),)
                  ),
                ),
              ),
            ],
          )
        ),

      ],
    );
  }
}