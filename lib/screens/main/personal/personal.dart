import "package:avec_moi_with_us/services/user/authentication.dart";
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const TitleBar(title: "Personal Information"),
        Flexible(
          flex: 5,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.face,size: 90,color: Colors.black,),
                Text("個人資訊",style: Theme.of(context).textTheme.displayMedium,)
              ],
            ),
          ),
        ),

        Flexible(
          flex: 8,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, Routes.edit_information);
                  },
                  child: const Text("編輯個人資訊")
                ),
                const Divider(),
                TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, Routes.edit_password);
                    },
                    child: const Text("更改密碼")
                ),
                const Divider(),
                TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, Routes.edit_preference);
                    },
                    child: Text("更改偏好項目")
                ),
                const Divider(),
                TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, Routes.history);
                    },
                    child:  const Text("歷史紀錄")
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex:2,
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
      ],
    );
  }
}