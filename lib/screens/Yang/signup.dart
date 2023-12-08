import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Center(
              child: Column(
                children: [
                  Text(
                    'Create your',
                    style: TextStyle(
                      fontSize: 50.0,
                      color: Color(0xFF56EAD8),
                      fontFamily: 'Kavoon',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'account',
                    style: TextStyle(
                      color: Color(0xFF56EAD8),
                      fontSize: 50.0,
                      fontFamily: 'Kavoon',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
            const SizedBox(height: 20.0), // 新增一个 SizedBox 来调整两个输入框之间的间距
            SizedBox(
              height: 50,
              width: 304,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'email or phone number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  filled: true,
                  fillColor: Color(0x5A5200FF),
                ),
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 20.0), // 调整间距
            SizedBox(
              height: 50,
              width: 304,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  filled: true,
                  fillColor: Color(0x5A5200FF),
                ),
                style: const TextStyle(fontSize: 16.0),
                obscureText: true, // to hide the password
              ),
            ),
            const SizedBox(height: 20.0), // 调整间距
            SizedBox(
              height: 40,
              width: 211,
              child: ElevatedButton(
                onPressed: () {
                  // Handle logic after registration button is clicked
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Color(0xF0FF0000)),
                  ),
                  minimumSize: const Size(211, 60),
                ),
                child: const Text(
                  'confirm',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
