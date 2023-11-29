import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();

  String _selectedGender = '不透露';

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
            'SIGN-UP',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildTextField(
              controller: _usernameController,
              labelText: '用戶名',
            ),
            buildTextField(
              controller: _nameController,
              labelText: '姓名',
            ),
            buildTextField(
              controller: _birthdayController,
              labelText: '生日',
              hintText: 'YYYY-MM-DD',
            ),
            buildGenderDropdown(),
            buildTextField(
              controller: _emailController,
              labelText: 'Email',
            ),
            buildTextField(
              controller: _passwordController,
              labelText: '密碼',
              isPassword: true,
            ),
            buildTextField(
              controller: _confirmPasswordController,
              labelText: '確認密碼',
              isPassword: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 在這裡處理註冊邏輯
                // 您可以獲取輸入的值並執行相應的操作
              },
              child: Text('註冊'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
    String? hintText,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: '$labelText',
        hintText: hintText,
      ),
    );
  }

  Widget buildGenderDropdown() {
    return DropdownButtonFormField(
      value: _selectedGender,
      onChanged: (value) {
        setState(() {
          _selectedGender = value.toString();
        });
      },
      items: ['不透露', '男', '女']
          .map((gender) => DropdownMenuItem(
        value: gender,
        child: Text(gender),
      ))
          .toList(),
      decoration: InputDecoration(
        labelText: '性別',
      ),
    );
  }
}
