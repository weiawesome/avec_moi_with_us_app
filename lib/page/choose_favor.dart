import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HobbyPage(),
    );
  }
}

class HobbyPage extends StatefulWidget {
  @override
  _HobbyPageState createState() => _HobbyPageState();
}

class _HobbyPageState extends State<HobbyPage> {
  List<String> selectedHobbies = [];

  final List<String> hobbies = [
    "剧情", "喜剧", "动作", "爱情", "科幻", "动画", "悬疑", "惊悚", "恐怖", "纪录片", "短片",
    "情色", "音乐", "歌舞", "家庭", "儿童", "传记", "历史", "战争", "犯罪", "西部", "奇幻", "冒险",
    "灾难", "武侠", "古装", "运动"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // 在這裡處理返回鍵的操作
            print('Back button clicked');
          },
        ),
        title: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.purple[100], // 淡紫色背景
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'CHOOSE YOUR FAVOR',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple[800], // 深紫色文字
              fontFamily: 'cursive', // 使用藝術字體
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: hobbies.length,
        itemBuilder: (context, index) {
          final hobby = hobbies[index];
          return CheckboxListTile(
            title: Text(hobby),
            value: selectedHobbies.contains(hobby),
            onChanged: (value) {
              setState(() {
                if (value != null && value) {
                  selectedHobbies.add(hobby);
                } else {
                  selectedHobbies.remove(hobby);
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle selected hobbies
          print(selectedHobbies);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
