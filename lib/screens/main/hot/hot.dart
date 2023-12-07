import "package:avec_moi_with_us/blocs/provider/hot_movie_provider.dart";
import "package:avec_moi_with_us/blocs/provider/hot_movie_scroller_provider.dart";
import "package:avec_moi_with_us/services/movie/movie.dart";
import "package:avec_moi_with_us/widgets/image_button.dart";
import "package:avec_moi_with_us/widgets/title.dart";
import "package:flutter/material.dart";
import "package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart";
import "package:provider/provider.dart";


class HotPage extends StatefulWidget {
  const HotPage({super.key});
  @override
  State<HotPage> createState() => _HotPageState();
}

class _HotPageState extends State<HotPage> {
  MovieService m=MovieService();

  late ScrollController _scrollController;
  @override
  void dispose() {
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _scrollController= context.read<HotMovieScrollProvider>().scrollController;
    _refresh();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent*0.8) {
        if (context.read<HotMovieProvider>().currentPage==context.read<HotMovieProvider>().queryPage){
          context.read<HotMovieProvider>().queryPage+=1;
          int page=context.read<HotMovieProvider>().queryPage;
          context.read<HotMovieProvider>().insertMovie(await m.getRecentlyHotMovie(page));
        }
      }
    });
  }

  Future<void> _refresh() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<HotMovieProvider>().emptyMovie();
      context.read<HotMovieProvider>().insertMovie(await m.getRecentlyHotMovie(1));
    });
  }
  @override
  Widget build(BuildContext context) {
    final hotMovieProvider = Provider.of<HotMovieProvider>(context);
    return Column(
      children: [
        const TitleBar(title: "Recently Hot"),
        Flexible(
          flex: 1,
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text("近期熱門",style: Theme.of(context).textTheme.titleSmall,)
          ),
        ),
        Flexible(
          flex:14,
          child: LiquidPullToRefresh(
            animSpeedFactor:1.5,
            color: Theme.of(context).canvasColor,
            backgroundColor: const Color(0xFFFFE27C),
            onRefresh: _refresh,
            showChildOpacityTransition: true,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              itemCount: hotMovieProvider.movieList.length,
              itemBuilder: (context, index) {
                return SingleImageButton(movieId: hotMovieProvider.movieList[index].movieId,imageUrl: hotMovieProvider.movieList[index].resource,year: hotMovieProvider.movieList[index].releaseYear,title: hotMovieProvider.movieList[index].title,score: hotMovieProvider.movieList[index].score,);
              },
            ),
          ),
        )
      ],
    );
  }
}