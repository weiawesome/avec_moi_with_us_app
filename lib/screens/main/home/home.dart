import "package:avec_moi_with_us/blocs/provider/movie_provider.dart";
import "package:avec_moi_with_us/blocs/provider/random_provider.dart";
import "package:avec_moi_with_us/blocs/provider/search_movie_provider.dart";
import "package:avec_moi_with_us/models/movie/movie.dart";
import "package:avec_moi_with_us/services/movie/movie.dart";
import "package:avec_moi_with_us/widgets/image_button.dart";
import "package:avec_moi_with_us/widgets/title.dart";
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

  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _refresh();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent*0.9) {
        if (searchState){
          int page=context.read<SearchMovieProvider>().currentPage+1;
          context.read<SearchMovieProvider>().insertMovie(await m.searchMovie(_searchController.text, page));
        } else{
          int randomSeed = context.read<RandomProvider>().randomSeed;
          int page=context.read<MovieProvider>().currentPage+1;
          context.read<MovieProvider>().insertMovie(await m.getMovie(page,randomSeed));
        }

      }
    });
  }

  Future<void> _refresh() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<MovieProvider>().emptyMovie();
      int randomSeed=0;
      if (context.read<RandomProvider>().randomState) {
        context.read<RandomProvider>().generateRandomSeed();
        randomSeed = context.read<RandomProvider>().randomSeed;
      }
      context.read<MovieProvider>().insertMovie(await m.getMovie(1,randomSeed));
    });
  }

  Future<void> search() async {
    context.read<SearchMovieProvider>().emptyMovie();
    context.read<SearchMovieProvider>().insertMovie(await m.searchMovie(_searchController.text,1));
  }


  @override
  Widget build(BuildContext context) {
    final randomProvider = Provider.of<RandomProvider>(context);
    final movieProvider = Provider.of<MovieProvider>(context);
    final searchMovieProvider = Provider.of<SearchMovieProvider>(context);
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
                      child: Text("專屬推薦",style: Theme.of(context).textTheme.titleSmall,)
                  );
                }
                else if (index == 1) {
                  return SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return const ImageButton(movieId: "1",imageUrl: 'https://image.tmdb.org/t/p/original/7Wa0N9bmUznYQzzNAdTAN0OgQ1w.jpg',year: "2017",title: "咒術回戰",score: 1.2,);
                      },
                    ),
                  );
                }
                else if (index==2){
                  return Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("電影/影集",style: Theme.of(context).textTheme.titleSmall,),
                          Row(
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
                      ImageButton(movieId: firstMovie.movieId,imageUrl: firstMovie.resource,year: firstMovie.releaseYear,title: firstMovie.title,score: firstMovie.score,),
                      secondMovie.movieId.isEmpty?
                      Container(width: 150,height: 200,margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.5),): ImageButton(movieId: secondMovie.movieId,imageUrl: secondMovie.resource,year: secondMovie.releaseYear,title: secondMovie.title,score: secondMovie.score,),
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