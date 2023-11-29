import "package:avec_moi_with_us/utils/routes.dart";
import "package:flutter/material.dart";

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});
  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
            child: Text("Personal Information",style: Theme.of(context).textTheme.titleMedium,),
          ),
        ),
        Flexible(
          flex: 5,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.face,size: 90,color: Colors.black,),
                Text("個人資訊")
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
                  child: Text("編輯個人資訊")
                ),
                Divider(),
                TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, Routes.edit_password);
                    },
                    child: Text("更改密碼")
                ),
                Divider(),
                TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, Routes.edit_preference);
                    },
                    child: Text("更改偏好項目")
                ),
                Divider(),
                TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, Routes.history);
                    },
                    child: Text("歷史紀錄")
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex:2,
          child: ElevatedButton(
              onPressed: (){},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xA8FF0000)), // 设置背景颜色
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                ),
              ),
              child: Text("LOG OUT",style: TextStyle(color: Colors.white),)
          ),
        ),
      ],
    );
  }
}