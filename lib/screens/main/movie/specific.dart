import "package:avec_moi_with_us/models/movie/movie_specific.dart";
import "package:avec_moi_with_us/services/movie/movie.dart";
import "package:avec_moi_with_us/utils/exception.dart";
import "package:avec_moi_with_us/widgets/title.dart";
import "package:avec_moi_with_us/widgets/toast_notification.dart";
import "package:flutter/material.dart";

class SpecificMoviePage extends StatefulWidget {
  final String movieId;
  const SpecificMoviePage({super.key,required this.movieId});
  @override
  State<SpecificMoviePage> createState() => _SpecificMoviePageState();
}

class _SpecificMoviePageState extends State<SpecificMoviePage> {
  late ResponseSpecificMovie r;
  bool loading=true;
  bool like=false;
  MovieService m=MovieService();

  Future<void> likeMovie() async {
    try{
      if (like){
        await m.addLikeMovie(widget.movieId);
      } else{
        await m.deleteLikeMovie(widget.movieId);
      }
    } on AuthException{
      toastError(context, "權限錯誤", "請重新登入");
      Navigator.pop(context);
    } catch (e){
      toastError(context, "未知錯誤", "出現未知錯誤 請稍後再嘗試");
    }
  }

  @override
  void initState() {
    super.initState();
    getInformation();
  }
  Future<void> getInformation() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      r=await m.getSpecificMovie(widget.movieId);
      try{
        await m.getIsLikeMovie(widget.movieId);
        setState(() {
          like=true;
        });
      } catch(e){
        setState(() {
          like=false;
        });
      }
      setState(() {
        loading=false;
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleBarSubPage(title: "Specific Movie"),
                loading?
                Flexible(
                  flex:16,
                  child: Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: Color(0xFFFD6868),
                    ),
                  ),
                ): Flexible(
                  flex:14,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                r.resource,
                                width: 150,
                                height: 200,
                                fit: BoxFit.contain,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return const SizedBox(
                                      height: 200,
                                      width: 150,
                                      child: Center(
                                        widthFactor: 1,
                                        heightFactor: 1,
                                        child: CircularProgressIndicator(
                                        ),
                                      ),
                                    );
                                  }
                                },
                                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                  return const SizedBox(
                                      width: 150,
                                      height: 200,
                                      child: Icon(Icons.error,size: 50,)
                                  );
                                },
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("片名 : ${r.title}", style: Theme.of(context).textTheme.bodyLarge,softWrap: true,),
                                  Text("原片名 : ${r.originalTitle}", style: Theme.of(context).textTheme.bodyLarge,softWrap: true,),
                                  Text("發行年分 : ${r.releaseYear}", style: Theme.of(context).textTheme.bodyLarge,softWrap: true,),
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("分類",style: Theme.of(context).textTheme.headlineMedium,),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: r.categories.map((e){
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          color: const Color(0xFFFFE27C)
                                      ),
                                      margin: const EdgeInsets.only(right: 15.0),
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                      child: Text(e,style: Theme.of(context).textTheme.bodyMedium)
                                    );
                                  }).toList(),
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("其他譯名",style: Theme.of(context).textTheme.headlineMedium,),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: r.titles.map((e){
                                  return Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          color: Color(0xFFFFE27C)
                                      ),
                                      margin: EdgeInsets.only(right: 15.0),
                                      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                      child: Text(e,style: Theme.of(context).textTheme.bodyMedium)
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("評分",style: Theme.of(context).textTheme.headlineMedium,),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: r.rankScores.map((e){
                                  return Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                          color: const Color(0xFFFFE27C)
                                      ),
                                      margin: EdgeInsets.only(right: 15.0),
                                      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                      child: Text("${e.organization} : ${e.score} 分",style: Theme.of(context).textTheme.bodyMedium),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("簡介",style: Theme.of(context).textTheme.headlineMedium,),
                            ),
                            Text(r.introduction==""?"未收錄":r.introduction,style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("導演",style: Theme.of(context).textTheme.headlineMedium,),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: r.directors.map((e){
                                  return Container(
                                      margin: EdgeInsets.only(right: 15.0),
                                      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                      child: Column(
                                        children: [
                                          Image.network(
                                            e.resource,
                                            width: 100,
                                            height: 150,
                                            fit: BoxFit.contain,
                                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return const SizedBox(
                                                  width: 100,
                                                  height: 150,
                                                  child: Center(
                                                    widthFactor: 1,
                                                    heightFactor: 1,
                                                    child: CircularProgressIndicator(
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                              return const SizedBox(
                                                  width: 100,
                                                  height: 150,
                                                  child: Icon(Icons.error,size: 50,)
                                              );
                                            },
                                          ),
                                          Text(e.name,style: Theme.of(context).textTheme.bodyMedium),
                                        ],
                                      ),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("演員",style: Theme.of(context).textTheme.headlineMedium,),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: r.actors.map((e){
                                  return Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          e.resource,
                                          width: 100,
                                          height: 150,
                                          fit: BoxFit.contain,
                                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return const SizedBox(
                                                width: 100,
                                                height: 150,
                                                child: Center(
                                                  widthFactor: 1,
                                                  heightFactor: 1,
                                                  child: CircularProgressIndicator(
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                            return const SizedBox(
                                                width: 100,
                                                height: 150,
                                                child: Icon(Icons.error,size: 50,)
                                            );
                                          },
                                        ),
                                        Text(e.name,style: Theme.of(context).textTheme.bodyMedium),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                loading?
                Container():Flexible(
                    flex:2,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              like=!like;
                            });
                            likeMovie();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(
                                0xFFFD6868)),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              like?const Icon(Icons.favorite_outlined,size: 50,):const Icon(Icons.favorite_outline,size: 50,),
                              const Text("收藏"),
                              like?const Icon(Icons.favorite_outlined,size: 50,):const Icon(Icons.favorite_outline,size: 50,),
                            ],
                          ),
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}