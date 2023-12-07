import 'package:flutter/material.dart';

class HotMovieScrollProvider extends ChangeNotifier {
  final ScrollController _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;

  void scrollToTop() {
    if (_scrollController.hasClients){
      if (_scrollController.offset>0.0){
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else{
        _scrollController.animateTo(
          -500.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
      notifyListeners();
    }
  }
}
