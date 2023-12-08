import "package:avec_moi_with_us/blocs/provider/favorite_movie_provider.dart";
import "package:avec_moi_with_us/blocs/provider/favorite_movie_scroller_provider.dart";
import "package:avec_moi_with_us/models/movie/movie.dart";
import "package:avec_moi_with_us/services/movie/movie.dart";
import "package:avec_moi_with_us/widgets/image_button.dart";
import "package:avec_moi_with_us/widgets/title.dart";
import "package:flutter/material.dart";
import "package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart";
import "package:provider/provider.dart";

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  MovieService m=MovieService();

  late ScrollController _scrollController;
  @override
  void dispose() {
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _scrollController= context.read<FavoriteMovieScrollProvider>().scrollController;
    _refresh();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent*0.8) {
        if (context.read<FavoriteMovieProvider>().currentPage==context.read<FavoriteMovieProvider>().queryPage){
          context.read<FavoriteMovieProvider>().queryPage+=1;
          int page=context.read<FavoriteMovieProvider>().queryPage;
          context.read<FavoriteMovieProvider>().insertMovie(await m.getRecentlyHotMovie(page));
        }
      }
    });
  }

  Future<void> _refresh() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<FavoriteMovieProvider>().emptyMovie();
      context.read<FavoriteMovieProvider>().insertMovie(await m.getLikeMovie(1));
    });
  }
  @override
  Widget build(BuildContext context) {
    final favoriteMovieProvider = Provider.of<FavoriteMovieProvider>(context);
    return Column(
      children: [
        const TitleBar(title: "Favorite"),
        Flexible(
          flex: 1,
          child: Container(
              alignment: Alignment.centerLeft,
              child: Semantics(label:"此處列出所有收藏電影或影集的提示標籤",child: Text("收藏的電影/影集",style: Theme.of(context).textTheme.titleSmall,))
          ),
        ),
        Flexible(
          flex:14,
          child: Semantics(
            label: "此處為滑動視窗，列出使用者所有收藏電影或影集，滑到底部可以自動載入更多，同時往上滑動可以刷新頁面",
            child: LiquidPullToRefresh(
              animSpeedFactor:1.5,
              color: Theme.of(context).canvasColor,
              backgroundColor: const Color(0xFFFFE27C),
              onRefresh: _refresh,
              showChildOpacityTransition: true,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                itemCount: (favoriteMovieProvider.movieList.length+1)~/2,
                itemBuilder: (context, index) {
                  Movie firstMovie=favoriteMovieProvider.movieList[(index)*2];
                  Movie secondMovie=Movie(movieId: "",title: "",releaseYear:"",resource:"",score:0);
                  if (favoriteMovieProvider.movieList.length>(index)*2+1){
                    secondMovie=favoriteMovieProvider.movieList[(index)*2+1];
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DualImageButton(movieId: firstMovie.movieId,imageUrl: firstMovie.resource,year: firstMovie.releaseYear,title: firstMovie.title,score: firstMovie.score,),
                      secondMovie.movieId.isEmpty?
                      Flexible(flex: 1,child: Container(),): DualImageButton(movieId: secondMovie.movieId,imageUrl: secondMovie.resource,year: secondMovie.releaseYear,title: secondMovie.title,score: secondMovie.score,),
                    ],
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}