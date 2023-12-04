import "package:avec_moi_with_us/blocs/provider/favorite_movie_provider.dart";
import "package:avec_moi_with_us/models/movie/movie.dart";
import "package:avec_moi_with_us/services/movie/movie.dart";
import "package:avec_moi_with_us/widgets/image_button.dart";
import "package:avec_moi_with_us/widgets/title.dart";
import "package:flutter/material.dart";
import "package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart";
import "package:provider/provider.dart";
import "package:stroke_text/stroke_text.dart";

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  MovieService m=MovieService();

  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _refresh();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent*0.9) {
        int page=context.read<FavoriteMovieProvider>().currentPage+1;
        context.read<FavoriteMovieProvider>().insertMovie(await m.getLikeMovie(page));
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
              child: Text("收藏的電影/影集",style: Theme.of(context).textTheme.titleSmall,)
          ),
        ),
        Flexible(
          flex:14,
          child: LiquidPullToRefresh(
            animSpeedFactor:1.5,
            color: Theme.of(context).canvasColor,
            backgroundColor: Color(0xFFFFE27C),
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
                    ImageButton(movieId: firstMovie.movieId,imageUrl: firstMovie.resource,year: firstMovie.releaseYear,title: firstMovie.title,score: firstMovie.score,),
                    secondMovie.movieId.isEmpty?
                    Container(width: 150,height: 200,margin:const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.5),): ImageButton(movieId: secondMovie.movieId,imageUrl: secondMovie.resource,year: secondMovie.releaseYear,title: secondMovie.title,score: secondMovie.score,),
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}