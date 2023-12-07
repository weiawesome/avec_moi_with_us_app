import 'package:avec_moi_with_us/services/utils/jwt_storage.dart';
import 'package:avec_moi_with_us/utils/routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  JwtService j=JwtService();

  @override
  void initState() {
    super.initState();
    getJwt();
  }

  Future<void> getJwt() async {
    var s=await j.getJwt();
    if (s==null || s.isEmpty){
      Navigator.popAndPushNamed(context, Routes.login);
    } else{
      Navigator.popAndPushNamed(context, Routes.search);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF967FB3),
      child: const Center(
          widthFactor: 1,
          heightFactor: 1,
          child: CircularProgressIndicator()),
    );
  }
}
