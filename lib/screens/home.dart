import "package:avec_moi_with_us/utils/routes.dart";
import "package:flutter/material.dart";
import "package:stroke_text/stroke_text.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _mailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  void login(){
    if (_mailKey.currentState!.validate()==false) {
      FocusScope.of(context).requestFocus(_emailFocus);
    } else if (_passwordKey.currentState!.validate()==false){
      FocusScope.of(context).requestFocus(_passwordFocus);
    } else{
      FocusScope.of(context).unfocus();
      print("log in");
      Navigator.pushNamed(context, Routes.login);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Expanded(
                  flex: 3,
                  child: Center(
                    child: StrokeText(
                    text: "Welcome !\nWith Us !",
                    textStyle: TextStyle(fontFamily: "McLaren",color: Color(0xFF55E9D7), fontSize: 60, fontWeight: FontWeight.w400, height: 0,),
                    strokeColor: Color.fromRGBO(255, 137, 137, 1),
                    strokeWidth: 5,
                ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
                        child: Form(
                          key: _mailKey,
                          child: TextFormField(
                              focusNode: _emailFocus,
                              style: Theme.of(context).textTheme.labelMedium,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: Theme.of(context).textTheme.labelMedium,
                                hintText: "Enter your email",
                                prefixIcon: const Icon(Icons.email),
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                filled: true,
                                fillColor: const Color(0xFFFFE27C),
                                hintStyle: Theme.of(context).textTheme.labelMedium,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your email";
                                } else if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                  return "Invalid email address";
                                }
                                return null;
                              },
                              onEditingComplete: () {
                                if (_mailKey.currentState!.validate()==true) {
                                  FocusScope.of(context).requestFocus(_passwordFocus);
                                }
                              }
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
                        child: Form(
                          key: _passwordKey,
                          child: TextFormField(
                            focusNode: _passwordFocus,
                            style: Theme.of(context).textTheme.labelMedium,
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () {
                              login();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your password";
                              } else if (value.length < 8) {
                                return "Password too short";
                              } else if (value.length > 30){
                                return "Password too long";
                              }else if (value.contains(" ")) {
                                return "Password cannot contain spaces";
                              } else if (!RegExp(r"^[a-zA-Z!@#$%^&*()_+-=]+").hasMatch(value)) {
                                return "Password can't contain illegal characters";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: Theme.of(context).textTheme.labelMedium,
                              hintText: "Enter your password",
                              prefixIcon: const Icon(Icons.lock),
                              filled: true,
                              fillColor: const Color(0xFFFFE27C),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: login,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF2F88FF)), // 设置背景颜色
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                          ),
                        ),
                        child: Text("LOGIN",style: Theme.of(context).textTheme.labelLarge,),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.signup);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFFB169)), // 设置背景颜色
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                          ),
                        ),
                        child: Text("SIGN UP",style: Theme.of(context).textTheme.labelLarge,),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                )
              ]
            ),
          ),
        )
    );
  }
}