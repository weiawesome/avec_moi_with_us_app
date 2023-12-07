import "package:avec_moi_with_us/blocs/provider/movie_provider.dart";
import "package:avec_moi_with_us/blocs/provider/movie_scroller_provider.dart";
import "package:avec_moi_with_us/blocs/provider/random_provider.dart";
import "package:avec_moi_with_us/blocs/provider/recommend_movie_provider.dart";
import "package:avec_moi_with_us/blocs/provider/search_movie_provider.dart";
import "package:avec_moi_with_us/models/movie/movie.dart";
import "package:avec_moi_with_us/services/movie/movie.dart";
import "package:avec_moi_with_us/utils/exception.dart";
import "package:avec_moi_with_us/utils/routes.dart";
import "package:avec_moi_with_us/widgets/image_button.dart";
import "package:avec_moi_with_us/widgets/title.dart";
import "package:avec_moi_with_us/widgets/toast_notification.dart";
import "package:flutter/material.dart";
import "package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart";
import "package:provider/provider.dart";


class IndexPage extends StatefulWidget {
  const IndexPage({super.key});
  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final TextEditingController _searchController = TextEditingController();
  MovieService m=MovieService();
  bool searchState=false;

  late ScrollController _scrollController;
  final _horizontalScrollController = ScrollController();
  @override
  void dispose() {
    super.dispose();
    _horizontalScrollController.dispose();
  }
  @override
  void initState() {
    super.initState();
    _scrollController= context.read<MovieScrollProvider>().scrollController;

    searchState=false;
    _searchController.text="";
    _refresh();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent*0.8) {
        if (searchState){
          if (context.read<SearchMovieProvider>().currentPage==context.read<SearchMovieProvider>().queryPage){
            context.read<SearchMovieProvider>().queryPage+=1;
            int page=context.read<SearchMovieProvider>().queryPage;
            context.read<SearchMovieProvider>().insertMovie(await m.searchMovie(_searchController.text, page));
          }
        } else{
          int randomSeed = context.read<RandomProvider>().randomSeed;
          if (context.read<MovieProvider>().currentPage==context.read<MovieProvider>().queryPage){
            context.read<MovieProvider>().queryPage+=1;
            int page=context.read<MovieProvider>().queryPage;
            context.read<MovieProvider>().insertMovie(await m.getMovie(page,randomSeed));
          }
        }
      }
    });

  }

  Future<void> _refresh() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_searchController.text==""){
        searchState=false;
      } else{
        searchState=true;
      }

      if (searchState){
        await search();
      } else{
        context.read<MovieProvider>().emptyMovie();
        context.read<RecommendMovieProvider>().emptyMovie();
        int randomSeed=0;
        if (context.read<RandomProvider>().randomState) {
          context.read<RandomProvider>().generateRandomSeed();
          randomSeed = context.read<RandomProvider>().randomSeed;
        }
        try{
          context.read<MovieProvider>().insertMovie(await m.getMovie(1,randomSeed));
        } on AuthException{
          toastError(context, "權限錯誤", "請重新登入");
          Navigator.popAndPushNamed(context, Routes.login);
        } catch (e){
          toastError(context, "未知錯誤", "出現未知錯誤 請稍後再嘗試");
        }
        try{
          context.read<RecommendMovieProvider>().insertMovie(await m.getRecommendMovie());
        } on AuthException{
          toastError(context, "權限錯誤", "請重新登入");
          Navigator.popAndPushNamed(context, Routes.login);
        } catch (e){
          toastError(context, "未知錯誤", "出現未知錯誤 請稍後再嘗試");
        }
      }
    });
  }

  Future<void> search() async {
    context.read<SearchMovieProvider>().emptyMovie();
    if (_searchController.text.isEmpty){
      return;
    }
    try{
      context.read<SearchMovieProvider>().insertMovie(await m.searchMovie(_searchController.text,1));
    } catch (e){
      toastError(context, "未知錯誤", "出現未知錯誤 請稍後再嘗試");
    }
  }


  @override
  Widget build(BuildContext context) {
    final randomProvider = Provider.of<RandomProvider>(context);
    final movieProvider = Provider.of<MovieProvider>(context);
    final searchMovieProvider = Provider.of<SearchMovieProvider>(context);
    final recommendMovieProvider = Provider.of<RecommendMovieProvider>(context);
    return Column(
      children: [
        const TitleBar(title: "Avec Moi With Us"),
        Flexible(
          flex:2,
          child: Center(
            child: TextField(
              controller: _searchController,
              style:  Theme.of(context).textTheme.labelSmall,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: Theme.of(context).textTheme.labelSmall,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      searchState=false;
                    });
                    _refresh();
                  },
                ),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              ),
              onChanged: (value) {
                if (_searchController.text.isNotEmpty){
                  setState(() {
                    searchState=true;
                  });
                } else{
                  setState(() {
                    searchState=false;
                  });
                }
                search();
              },
            ),
          ),
        ),
        searchState?
        Flexible(
          flex: 13,
          child: LiquidPullToRefresh(
            animSpeedFactor:1.5,
            color: Theme.of(context).canvasColor,
            backgroundColor: const Color(0xFFFFE27C),
            onRefresh: _refresh,
            showChildOpacityTransition: true,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              itemCount: (searchMovieProvider.movieList.length+1),
              itemBuilder: (context, index) {
                if (index==0){
                  return Container(
                      alignment: Alignment.centerLeft,
                      child: Text("搜尋內容 : ${_searchController.text}",style: Theme.of(context).textTheme.titleSmall,)
                  );
                }
                else {
                  return SingleImageButton(movieId: searchMovieProvider.movieList[index-1].movieId,imageUrl:searchMovieProvider.movieList[index-1].resource,year: searchMovieProvider.movieList[index-1].releaseYear,title: searchMovieProvider.movieList[index-1].title,score: searchMovieProvider.movieList[index-1].score,);
                }
              },
            ),
          ),
        ):
        Flexible(
          flex:13,
          child: LiquidPullToRefresh(
            animSpeedFactor:1.5,
            color: Theme.of(context).canvasColor,
            backgroundColor: const Color(0xFFFFE27C),
            onRefresh: _refresh,
            showChildOpacityTransition: true,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              itemCount: (movieProvider.movieList.length+1)~/2 + 3,
              itemBuilder: (context, index) {
                if (index==0){
                  return Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text("專屬推薦",style: Theme.of(context).textTheme.titleSmall,)
                  );
                }
                else if (index == 1) {
                  return recommendMovieProvider.movieList.isEmpty?
                  const Text("在為您尋找推薦的電影..."):SizedBox(
                    height: 250,
                    child: ListView.builder(
                      controller: _horizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: recommendMovieProvider.movieList.length,
                      itemBuilder: (context, index) {
                        return ImageButton(
                          movieId: recommendMovieProvider.movieList[index].movieId,
                          imageUrl: recommendMovieProvider.movieList[index].resource,
                          year: recommendMovieProvider.movieList[index].releaseYear,
                          title: recommendMovieProvider.movieList[index].title,
                          score: recommendMovieProvider.movieList[index].score
                          ,);
                      },
                    ),
                  );
                }
                else if (index==2){
                  return Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: Text("電影/影集",style: Theme.of(context).textTheme.titleSmall,)),
                          Flexible(child: Container()),
                          Flexible(
                            child: Row(
                              children: [
                                Checkbox(
                                    value: !randomProvider.randomState,
                                    onChanged:  (val) async {
                                      randomProvider.toggleState();
                                      movieProvider.emptyMovie();
                                      ResponseMovie result=await m.getMovie(1,randomProvider.randomSeed);
                                      movieProvider.insertMovie(result);
                                    }),
                                Text("評分排序",style: Theme.of(context).textTheme.titleSmall,),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Row(
                              children: [
                                Checkbox(
                                    value: randomProvider.randomState,
                                    onChanged:  (val) async {
                                      randomProvider.toggleState();
                                      movieProvider.emptyMovie();
                                      ResponseMovie result=await m.getMovie(1,randomProvider.randomSeed);
                                      movieProvider.insertMovie(result);
                                    }),
                                Text("隨機排序",style: Theme.of(context).textTheme.titleSmall,),
                              ],
                            ),
                          )
                        ],
                      )
                  );
                }
                else {
                  Movie firstMovie=movieProvider.movieList[(index-3)*2];
                  Movie secondMovie=Movie(movieId: "",title: "",releaseYear:"",resource:"",score:0);
                  if (movieProvider.movieList.length>(index-3)*2+1){
                    secondMovie=movieProvider.movieList[(index-3)*2+1];
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DualImageButton(movieId: firstMovie.movieId,imageUrl: firstMovie.resource,year: firstMovie.releaseYear,title: firstMovie.title,score: firstMovie.score,),
                      secondMovie.movieId.isEmpty?
                      Container(width: 150,height: 200,margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.5),): DualImageButton(movieId: secondMovie.movieId,imageUrl: secondMovie.resource,year: secondMovie.releaseYear,title: secondMovie.title,score: secondMovie.score,),
                    ],
                  );
                }
              },
            ),
          ),
        )

      ],
    );
  }
}