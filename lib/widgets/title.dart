import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  final String title;
  const TitleBar({Key?key,required this.title}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Semantics(
        label: "形容此頁面的主要功能文字",
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20.0),
          ),

          child: Text(title,style: Theme.of(context).textTheme.titleMedium,),
        ),
      ),
    );
  }
}

class TitleBarSubPage extends StatelessWidget {
  final String title;
  const TitleBarSubPage({Key?key,required this.title}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex:2,
      child: Row(
        children: [
          Semantics(
            label: "返回前一頁面的按鈕",
            child: IconButton(
                onPressed: (){Navigator.pop(context);},
                icon: const Icon(Icons.arrow_back_ios_rounded)
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Semantics(label:"形容此頁面主要功能的文字",child: Text(title,style: Theme.of(context).textTheme.titleMedium,)),
            ),
          ),
        ],

      ),
    );
  }
}