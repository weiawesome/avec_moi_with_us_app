import 'package:avec_moi_with_us/blocs/provider/favorite_movie_scroller_provider.dart';
import 'package:avec_moi_with_us/blocs/provider/hot_movie_scroller_provider.dart';
import 'package:avec_moi_with_us/blocs/provider/movie_scroller_provider.dart';
import 'package:avec_moi_with_us/blocs/utils/bloc_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomNavigate extends StatefulWidget {
  const CustomNavigate({super.key});

  @override
  State<CustomNavigate> createState() => _CustomNavigate();
}

class _CustomNavigate extends State<CustomNavigate> {
  @override
  Widget build(BuildContext context) {
    const double iconSize=35;
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined,size: iconSize,),
          activeIcon: Icon(Icons.home_rounded,size: iconSize,),
          label: '主頁',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_fire_department_outlined,size: iconSize),
          activeIcon: Icon(Icons.local_fire_department_rounded,size: iconSize),
          label: '近期熱門',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_outline,size: iconSize),
          activeIcon: Icon(Icons.bookmark,size: iconSize),
          label: '你的收藏',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined,size: iconSize),
          activeIcon: Icon(Icons.account_circle_rounded,size: iconSize),
          label: '個人設定',
        ),
      ],
      backgroundColor: Theme.of(context).canvasColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Theme.of(context).brightness== Brightness.dark?const Color.fromRGBO(217,217,217,1):Colors.black,
      unselectedItemColor: const Color.fromRGBO(118,118,118,0.6),
      onTap: (index) {
        context.read<PageBloc>().add(pageEvents[index]);
        if (index==0){
          context.read<MovieScrollProvider>().scrollToTop();
        } else if (index==1){
          context.read<HotMovieScrollProvider>().scrollToTop();
        } else if (index==2){
          context.read<FavoriteMovieScrollProvider>().scrollToTop();
        }
      },
      currentIndex: pageIndex[context.watch<PageBloc>().state]??0,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    );
  }
}
