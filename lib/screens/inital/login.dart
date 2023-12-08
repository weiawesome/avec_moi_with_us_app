import "package:avec_moi_with_us/models/user/authentication/auth.dart";
import "package:avec_moi_with_us/models/user/authentication/login.dart";
import "package:avec_moi_with_us/services/user/authentication.dart";
import "package:avec_moi_with_us/utils/exception.dart";
import "package:avec_moi_with_us/utils/routes.dart";
import "package:avec_moi_with_us/widgets/loading.dart";
import "package:avec_moi_with_us/widgets/toast_notification.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:stroke_text/stroke_text.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _mailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool loading=false;

  @override
  void initState() {
    super.initState();
    _emailController.clear();
    _passwordController.clear();
    loading=false;
  }
  Future<void> signInWithGoogle() async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);

    User? u = authResult.user;
    setState(() {
      loading=true;
    });
    AuthenticationService s=AuthenticationService();
    try{
      await s.auth(RequestAuth(u!.uid));
      _emailController.clear();
      _passwordController.clear();
      Navigator.pushReplacementNamed(context, Routes.search);
    }on AuthException {
      toastError(context,"驗證錯誤","帳號或密碼錯誤 請重新輸入");
    } catch (e){
      toastError(context,"未知錯誤", "請稍後再嘗試");
    }
    setState(() {
      loading=false;
    });
  }
  Future<void> loginGithub() async {
    GithubAuthProvider githubProvider = GithubAuthProvider();
    UserCredential r=await FirebaseAuth.instance.signInWithProvider(githubProvider);
    User? u=r.user;
    setState(() {
      loading=true;
    });
    AuthenticationService s=AuthenticationService();
    try{
      await s.auth(RequestAuth(u!.uid));
      _emailController.clear();
      _passwordController.clear();
      Navigator.pushReplacementNamed(context, Routes.search);
    }on AuthException {
      toastError(context,"驗證錯誤","帳號或密碼錯誤 請重新輸入");
    } catch (e){
      toastError(context,"未知錯誤", "請稍後再嘗試");
    }
    setState(() {
      loading=false;
    });
  }

  Future<void> login() async {
    if (_mailKey.currentState!.validate()==false) {
      FocusScope.of(context).requestFocus(_emailFocus);
    } else if (_passwordKey.currentState!.validate()==false){
      FocusScope.of(context).requestFocus(_passwordFocus);
    } else{
      FocusScope.of(context).unfocus();
      AuthenticationService s=AuthenticationService();
      setState(() {
        loading=true;
      });
      try{
        await Future.delayed(const Duration(seconds: 1));
        await s.login(RequestLogin(_emailController.text, _passwordController.text));
        _emailController.clear();
        _passwordController.clear();
        Navigator.pushReplacementNamed(context, Routes.search);
      } on AuthException {
        toastError(context,"驗證錯誤","帳號或密碼錯誤 請重新輸入");
      } catch (e){
        toastError(context,"未知錯誤", "請稍後再嘗試");
      }
      setState(() {
        loading=false;
      });
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
                  Expanded(
                    flex: 3,
                    child: Semantics(
                      label: "歡迎進入應用程序的標題",
                      child: const Center(
                        child: StrokeText(
                          text: "Welcome !\nWith Us !",
                          textStyle: TextStyle(fontFamily: "McLaren",color: Color(0xFF55E9D7), fontSize: 60, fontWeight: FontWeight.w400, height: 0,),
                          strokeColor: Color.fromRGBO(255, 137, 137, 1),
                          strokeWidth: 5,
                        ),
                      ),
                    ),
                  ),
                  loading?
                  const Expanded(flex:6,child: Loading()):Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
                            child: Semantics(
                              label: "輸入信箱(帳戶)的輸入框",
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
                            child: Semantics(
                              label: "輸入密碼的輸入框",
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
                          ),
                        ],
                      )
                  ),
                  loading?
                  Container():Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Semantics(
                          label: "登入應用程序的按鈕",
                          child: ElevatedButton(
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
                        ),
                        Semantics(
                          label: "前往註冊畫面的按鈕",
                          child: ElevatedButton(
                            onPressed: () {
                              // signInWithGoogle();
                              _emailController.clear();
                              _passwordController.clear();
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
                        ),
                      ],
                    ),
                  ),
                  defaultTargetPlatform==TargetPlatform.android && loading?
                  Container():
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Semantics(label:"提示使用第三方登入的文字",child: Text("----- 第三方登入 -----",style:Theme.of(context).textTheme.headlineSmall,)),
                    ),
                  ),
                  defaultTargetPlatform==TargetPlatform.android && loading?
                  Container():
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Semantics(
                          label: "使用 Google帳戶 進行登入的按鈕",
                          child: ElevatedButton(
                            onPressed: (){
                            signInWithGoogle();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/icons/google.png',
                                height: 40.0,
                                width: 40.0,
                                fit: BoxFit.contain,
                              ),
                            )
                          ),
                        ),
                        Semantics(
                          label: "使用 GitHub帳戶 進行登入的按鈕",
                          child: ElevatedButton(
                            onPressed: (){loginGithub();},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/icons/github.png',
                                height: 40.0,
                                width: 40.0,
                                fit: BoxFit.contain,
                              ),
                            )
                          ),
                        ),
                      ],
                    ),
                  )
                ]
            ),
          ),
        )
    );
  }
}