import "package:avec_moi_with_us/models/movie/movie_specific.dart";
import "package:avec_moi_with_us/services/movie/movie.dart";
import "package:avec_moi_with_us/utils/exception.dart";
import "package:avec_moi_with_us/widgets/celebrity.dart";
import "package:avec_moi_with_us/widgets/title.dart";
import "package:avec_moi_with_us/widgets/toast_notification.dart";
import "package:cached_network_image/cached_network_image.dart";
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
                const TitleBarSubPage(title: "Specific Movie"),
                loading?
                Flexible(
                  flex:16,
                  child: Semantics(
                    label: "正在載入時的畫面",
                    child: Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        color: Color(0xFFFD6868),
                      ),
                    ),
                  ),
                ): Flexible(
                  flex:14,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Semantics(
                                label:"此部電影或影集的圖片",
                                child: CachedNetworkImage(
                                  imageUrl:r.resource,
                                  width: 200,
                                  height: 250,
                                  fit: BoxFit.contain,
                                  placeholder: (context, url)=> const SizedBox(height: 250, width: 200, child: Center(widthFactor: 1, heightFactor: 1, child: CircularProgressIndicator(),),),
                                  errorWidget: (context, url, error)=> const SizedBox(height: 250, width: 200, child: Icon(Icons.error,size: 50,))
                                ),
                              ),
                              Semantics(
                                label: "此部電影的基礎資訊",
                                child: SizedBox(
                                  height: 250,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Semantics(label:"此部電影或影集的片名",child: Text("片名 : ${r.title}", style: Theme.of(context).textTheme.bodyLarge,)),
                                      Semantics(label:"此部電影或影集的原始片名",child: Text("原片名 : ${r.originalTitle}", style: Theme.of(context).textTheme.bodyLarge,)),
                                      Semantics(label:"此部電影或影集的發行年分",child: Text("發行年分 : ${r.releaseYear}", style: Theme.of(context).textTheme.bodyLarge,)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Semantics(label:"顯示此部電影或影集分類的提示標籤",child: Text("分類",style: Theme.of(context).textTheme.headlineMedium,)),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: r.categories.map((e){
                                    return Semantics(
                                      label: "此部電影的分類項目",
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            color: const Color(0xFFFFE27C)
                                        ),
                                        margin: const EdgeInsets.only(right: 15.0),
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                        child: Text(e,style: Theme.of(context).textTheme.bodyMedium)
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
                              child: Semantics(label:"此部電影或影集翻譯名稱的提示標籤",child: Text("其他譯名",style: Theme.of(context).textTheme.headlineMedium,)),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: r.titles.map((e){
                                  return Semantics(
                                    label: "此部電影或影集翻譯名稱項目",
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            color: const Color(0xFFFFE27C)
                                        ),
                                        margin: const EdgeInsets.only(right: 15.0),
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                        child: Text(e,style: Theme.of(context).textTheme.bodyMedium)
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
                              child: Semantics(label:"此部電影或影集評分的提示標籤",child: Text("評分",style: Theme.of(context).textTheme.headlineMedium,)),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: r.rankScores.map((e){
                                  return Semantics(
                                    label: "此部電影或影集的評分項目",
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            color: const Color(0xFFFFE27C)
                                        ),
                                        margin: const EdgeInsets.only(right: 15.0),
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                        child: Text("${e.organization} : ${e.score} 分",style: Theme.of(context).textTheme.bodyMedium),
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
                              child: Semantics(label:"此部電影或影集的簡介提示標籤",child: Text("簡介",style: Theme.of(context).textTheme.headlineMedium,)),
                            ),
                            Semantics(label:"此部電影或影集的簡介",child: Text(r.introduction==""?"未收錄":r.introduction,style: Theme.of(context).textTheme.bodyMedium)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Semantics(label:"此部電影或影集的導演提示標籤",child: Text("導演",style: Theme.of(context).textTheme.headlineMedium,)),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: r.directors.map((e){
                                  return Semantics(label:"此部電影或影集的導演項目",child: CelebrityWidget(imageUrl: e.resource, name: e.name));
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
                              child: Semantics(label:"此部電影或影集的演員提示標籤",child: Text("演員",style: Theme.of(context).textTheme.headlineMedium,)),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: r.actors.map((e){
                                  return Semantics(label:"此部電影或影集的演員項目",child: CelebrityWidget(imageUrl: e.resource, name: e.name));
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
                      child: Semantics(
                        label: "收藏或是取消收藏的按鈕",
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