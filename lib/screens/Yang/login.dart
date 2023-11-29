import 'package:flutter/material.dart';
import 'signup.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF443656),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 60.0,
                      fontFamily: 'McLaren',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Color(0xFFFF8989), // 描邊的顏色
                      shadows: [
                        Shadow(
                          blurRadius: 2,
                          color: Color(0xFF56EAD8),
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'With Us!',
                    style: TextStyle(
                      fontSize: 60.0,
                      fontFamily: 'McLaren',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Color(0xFFFF8989), // 描邊的顏色
                      shadows: [
                        Shadow(
                          blurRadius: 3, // 陰影
                          color: Color(0xFF56EAD8),
                          offset: Offset(0, 0), // 陰影的偏移量
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 70.0),
                  Container(
                    height: 76,
                    width: 304,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'account',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow),
                        ),
                        filled: true,
                        fillColor: Colors.yellow,
                      ),
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    height: 76,
                    width: 304,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'password',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow),
                        ),
                        filled: true,
                        fillColor: Colors.yellow,
                      ),
                      style: TextStyle(fontSize: 16.0),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Logic for login
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(251, 61),
                    ),
                    child: Text(
                      'LOG IN',
                      style:TextStyle(
                        fontSize:24.0,
                        color:Colors.white,
                      ),
                    ),
                  ),//sign up 按鈕
                  SizedBox(height: 12.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(251, 61),
                    ),
                    child: Text(
                      'SIGN UP',
                      style:TextStyle(
                        fontSize:24.0,
                        color:Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
