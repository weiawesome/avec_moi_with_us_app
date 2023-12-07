import "package:avec_moi_with_us/models/user/authentication/signup.dart";
import "package:avec_moi_with_us/services/user/authentication.dart";
import "package:avec_moi_with_us/utils/exception.dart";
import "package:avec_moi_with_us/widgets/loading.dart";
import "package:avec_moi_with_us/widgets/toast_notification.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _mailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _confirmPasswordKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  bool loading=false;

  Future<void> signup() async {
    if (_nameKey.currentState!.validate()==false) {
      FocusScope.of(context).requestFocus(_nameFocus);
    }else if (_mailKey.currentState!.validate()==false) {
      FocusScope.of(context).requestFocus(_emailFocus);
    } else if (_passwordKey.currentState!.validate()==false){
      FocusScope.of(context).requestFocus(_passwordFocus);
    } else if (_confirmPasswordKey.currentState!.validate()==false){
      FocusScope.of(context).requestFocus(_confirmPasswordFocus);
    } else{
      FocusScope.of(context).unfocus();
      AuthenticationService s=AuthenticationService();
      setState(() {
        loading=true;
      });
      try{
        await Future.delayed(const Duration(seconds: 1));
        await s.signup(RequestSignup(
            _emailController.text,
            _passwordController.text,
            _nameController.text,
            genderIndex[groupValue]!)
        );
        _emailController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
        groupValue=0;
        Navigator.pop(context);
        toastInfo(context, "註冊成功", "已完成註冊 輸入帳密以完成登入");
      } on AuthException {
        toastError(context, '驗證錯誤',"該組帳戶已註冊");
      } catch (e){
        toastError(context, '未知錯誤', '請稍後再嘗試');
      }
      setState(() {
        loading=false;
      });
    }

  }

  int groupValue=0;

  late final String originalName;
  late final String originalGender;

  Map<int,String> genderIndex={
    0:"male",1:"female",2:"other"
  };
  Widget formatGenderUI(int index){
    final String gender=genderIndex[index]!;
    return Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),child: Text(gender,style: Theme.of(context).textTheme.displaySmall));
  }
  @override
  void initState() {
    super.initState();
    originalName="name";
    originalGender="male";
    groupValue=0;
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
                      child: Text(
                        "CREATE YOUR\nACCOUNT",
                        style: TextStyle(fontFamily: "Kavoon",color: Color(0xFF55E9D7), fontSize: 40, fontWeight: FontWeight.w400, height: 0,),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  loading?
                  const Expanded(flex:12,child: Loading()):Expanded(
                      flex: 10,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 90,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
                                child: Form(
                                  key: _nameKey,
                                  child: TextFormField(
                                      focusNode: _nameFocus,
                                      style: Theme.of(context).textTheme.labelMedium,
                                      controller: _nameController,
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        labelText: "Name",
                                        labelStyle: Theme.of(context).textTheme.labelMedium,
                                        hintText: "Enter your name",
                                        prefixIcon: const Icon(Icons.person),
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFFFE27C),
                                        hintStyle: Theme.of(context).textTheme.labelMedium,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter your name";
                                        } else if (value.contains(" ")) {
                                          return "Name can't contain space";
                                        }
                                        return null;
                                      },
                                      onEditingComplete: () {
                                        if (_nameKey.currentState!.validate()==true) {
                                          FocusScope.of(context).requestFocus(_emailFocus);
                                        }
                                      }
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 90,
                              child: Padding(
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
                            ),
                            SizedBox(
                              height: 90,
                              child: Padding(
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
                                      if (_passwordKey.currentState!.validate()==true) {
                                        FocusScope.of(context).requestFocus(_confirmPasswordFocus);
                                      }
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
                            SizedBox(
                              height: 90,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
                                child: Form(
                                  key: _confirmPasswordKey,
                                  child: TextFormField(
                                    focusNode: _confirmPasswordFocus,
                                    style: Theme.of(context).textTheme.labelMedium,
                                    controller: _confirmPasswordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    textInputAction: TextInputAction.done,
                                    onEditingComplete: () {
                                      signup();
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
                                      } else if (value!=_passwordController.text){
                                        print(value);
                                        print(_passwordController.text);
                                        return "Password not match";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Confirm Password",
                                      labelStyle: Theme.of(context).textTheme.labelMedium,
                                      hintText: "Enter your password again",
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
                            SizedBox(
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25, right: 25),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 5, right: 5),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white,),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Icon(Icons.wc,size: 30,),
                                              Text("Gender", style: Theme.of(context).textTheme.labelMedium,)
                                            ],
                                          )
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: ListView(
                                          physics: const NeverScrollableScrollPhysics(),
                                          children: [
                                            CupertinoSlidingSegmentedControl(
                                                backgroundColor: Colors.white,
                                                thumbColor: const Color(0xFFFFE27C),
                                                groupValue: groupValue,
                                                children:{
                                                  0: formatGenderUI(0),
                                                  1: formatGenderUI(1),
                                                  2: formatGenderUI(2)
                                                },
                                                onValueChanged: (value){
                                                  setState(() {
                                                    groupValue=value!;
                                                  });
                                                }
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  loading?Container():Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            signup();
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
                ]
            ),
          ),
        )
    );
  }
}