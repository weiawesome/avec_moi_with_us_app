import 'package:avec_moi_with_us/screens/main/favorite/favorite.dart';
import 'package:avec_moi_with_us/screens/main/home/home.dart';
import 'package:avec_moi_with_us/screens/main/hot/hot.dart';
import 'package:avec_moi_with_us/screens/main/personal/personal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


enum PageState { home,hot,favorite,personal }

final pageWidgets = {
  PageState.home: const IndexPage(),
  PageState.hot: const HotPage(),
  PageState.favorite:const FavoritePage(),
  PageState.personal:const PersonalPage(),
};
final pageIndex = {
  PageState.home: 0,
  PageState.hot: 1,
  PageState.favorite:2,
  PageState.personal:3,
};
final pageEvents=[PageEventHome(),PageEventHot(),PageEventFavorite(),PageEventPersonal()];

abstract class PageEvent {}

class PageEventHome extends PageEvent {}

class PageEventHot extends PageEvent {}

class PageEventFavorite extends PageEvent {}

class PageEventPersonal extends PageEvent {}

class PageEventUnknown extends PageEvent {}

class PageBloc extends Bloc<PageEvent,PageState> {
  PageBloc() : super(PageState.home){
    on<PageEvent>((event, emit) {
      if (event is PageEventHome){
        emit(PageState.home);
      } else if(event is PageEventHot){
        emit(PageState.hot);
      }else if(event is PageEventFavorite){
        emit(PageState.favorite);
      }else if(event is PageEventPersonal){
        emit(PageState.personal);
      }else{
        throw Exception("Error event in navigator");
      }
    });
  }

}
