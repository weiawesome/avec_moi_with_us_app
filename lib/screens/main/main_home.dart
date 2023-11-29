import 'package:avec_moi_with_us/blocs/utils/bloc_navigator.dart';
import 'package:avec_moi_with_us/widgets/custom_navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainHomePage extends StatefulWidget{
  const MainHomePage({Key?key}):super(key: key);
  @override
  State<MainHomePage> createState()=> _MainHomePage();
}
class _MainHomePage extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).canvasColor,
      body: BlocBuilder<PageBloc, PageState>(
          builder: (context, state) {
            return SafeArea(
                child: GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    child:  pageWidgets[state]??Container(),
                  ),
                ));
          }
      ),
      bottomNavigationBar:const CustomNavigate(),
    );
  }
}