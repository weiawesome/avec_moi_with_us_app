import 'dart:math';
import 'package:flutter/material.dart';


class RandomProvider extends ChangeNotifier {
  late bool randomState;
  late int randomSeed;

  RandomProvider() {
    randomState=false;
    randomSeed=0;
    notifyListeners();
  }
  void generateRandomSeed(){
    Random random = Random();
    randomSeed = random.nextInt(50) + 1;
  }

  int getRandomSeed() {
    return randomSeed;
  }

  void toggleState() {
    if (randomState==true){
      randomState=false;
      randomSeed=0;
    } else{
      randomState=true;
      generateRandomSeed();
    }
    notifyListeners();
  }
}
