import "package:avec_moi_with_us/blocs/provider/history_movie_provider.dart";
import "package:avec_moi_with_us/services/movie/movie.dart";
import "package:avec_moi_with_us/widgets/image_button.dart";
import "package:avec_moi_with_us/widgets/title.dart";
import "package:flutter/material.dart";
import "package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart";
import "package:provider/provider.dart";

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  MovieService m=MovieService();

  final _scrollController = ScrollController();
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
  @override
  void initState() {
    super.initState();
    _refresh();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent*0.8) {
        if (context.read<HistoryMovieProvider>().currentPage==context.read<HistoryMovieProvider>().queryPage){
          context.read<HistoryMovieProvider>().queryPage+=1;
          int page=context.read<HistoryMovieProvider>().queryPage;
          context.read<HistoryMovieProvider>().insertMovie(await m.getRecentlyHotMovie(page));
        }
      }
    });
  }

  Future<void> _refresh() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<HistoryMovieProvider>().emptyMovie();
      context.read<HistoryMovieProvider>().insertMovie(await m.getRecentlyViewMovie(1));
    });
  }
  @override
  Widget build(BuildContext context) {
    final historyMovieProvider = Provider.of<HistoryMovieProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: Column(
            children: [
              const TitleBarSubPage(title: "History"),
              Flexible(
                flex: 1,
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text("觀看紀錄",style: Theme.of(context).textTheme.titleSmall,)
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
                    itemCount: historyMovieProvider.movieList.length,
                    itemBuilder: (context, index) {
                      return SingleImageButton(movieId: historyMovieProvider.movieList[index].movieId,imageUrl: historyMovieProvider.movieList[index].resource,year: historyMovieProvider.movieList[index].releaseYear,title: historyMovieProvider.movieList[index].title,score: historyMovieProvider.movieList[index].score,);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}