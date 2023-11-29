import "package:avec_moi_with_us/models/user/information/preference.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class SpecificMoviePage extends StatefulWidget {
  const SpecificMoviePage({super.key});
  @override
  State<SpecificMoviePage> createState() => _SpecificMoviePageState();
}

class _SpecificMoviePageState extends State<SpecificMoviePage> {
  Set<int> selectedItems = <int>{12,35};
  Set<String> titleItems=<String>{"Магічна битва",
    "Jujutsu Kaisen",
    "Jujutsu Kaisen",
    "Jujutsu Kaisen",
    "Jujutsu Kaisen",
    "جوجيتسو كايسن",
    "Jujutsu Kaisen",
    "Jujutsu Kaisen",
    "ג'וג'וטסו קאיזן",
    "Chú Thuật Hồi Chiến",
    "Jujutsu Kaisen",
    "Jujutsu Kaisen",
    "جوجوتسو کایسن",
    "جوجيتسو كايسن",
    "Jujutsu Kaisen",
    "주술회전",
    "Jujutsu Kaisen",
    "Jujutsu Kaisen",
    "Магическая битва",
    "Jujutsu Kaisen",
    "咒术回战",
    "Jujutsu Kaisen",
    "咒術迴戰",
    "Jujutsu Kaisen",
    "Jujutsu Kaisen",
    "Jujutsu Kaisen",
    "咒術迴戰",
    "Jujutsu Kaisen",
    "Jujutsu Kaisen",
    "Jujutsu Kaisen",
    "มหาเวทย์ผนึกมาร"};
  List<String> directorItems=["HAHA","HAHA","HAHA","HAHA","HAHA"];
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
                Flexible(
                  flex:2,
                  child: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      },
                          icon: Icon(Icons.arrow_back_ios_rounded)
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                          margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text("Specific Movie",style: Theme.of(context).textTheme.titleMedium,),
                        ),
                      ),
                    ],

                  ),
                ),
                Flexible(
                  flex:14,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                'https://image.tmdb.org/t/p/original/7Wa0N9bmUznYQzzNAdTAN0OgQ1w.jpg',
                                width: 150,
                                height: 200,
                                fit: BoxFit.contain,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Container(
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
                                  return Icon(Icons.error);
                                },
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("片名 : 咒術迴戰", style: Theme.of(context).textTheme.bodyLarge),
                                  Text("原片名 : 咒術迴戰", style: Theme.of(context).textTheme.bodyLarge),
                                  Text("發行年分 : 2017", style: Theme.of(context).textTheme.bodyLarge),
                                  Text("評分 : 7.5分", style: Theme.of(context).textTheme.bodyLarge),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
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
                                  children: selectedItems.map((e){
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            color: Color(0xFFFFE27C)
                                        ),
                                        margin: EdgeInsets.only(right: 15.0),
                                        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                        child: Text(genreIndexPair[e].toString(),style: Theme.of(context).textTheme.bodyMedium)
                                      );
                                    }).toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
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
                                  children: titleItems.map((e){
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
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("簡介",style: Theme.of(context).textTheme.headlineMedium,),
                              ),
                              Text("少年戰鬥著 —「為了尋求正確的死亡」辛酸、後悔、恥辱人類產生的負面情感，化為詛咒，潛入日常生活詛咒是蔓延於世界的禍源，最糟糕的情況下，會讓人類踏入死亡並且，詛咒只能以詛咒祓除擁有驚人身體能力的少年·虎杖悠仁原本過著普通的高中生活有一天，為了拯救被「詛咒」襲擊的同伴，他吃下了特級咒物「兩面宿儺之指」，讓詛咒寄宿於自己的靈魂之中與詛咒「兩面宿儺」共有肉體的虎杖，在最強咒術師五條悟的指引下，進入對詛咒專門機關「東京都立咒術高等專門學校」……。為了祓除詛咒而成為詛咒的少年，無法回頭的壯闊故事開始了。",style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
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
                                  children: directorItems.map((e){
                                    return Container(
                                        margin: EdgeInsets.only(right: 15.0),
                                        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                        child: Column(
                                          children: [
                                            Image.network(
                                              "https://image.tmdb.org/t/p/original/40n61jOMzHpDSnzLBQOSEEWlxEw.jpg",
                                              width: 100,
                                              height: 150,
                                              fit: BoxFit.contain,
                                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                } else {
                                                  return Center(
                                                    widthFactor: 1,
                                                    heightFactor: 1,
                                                    child: CircularProgressIndicator(),
                                                  );
                                                }
                                              },
                                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                return Icon(Icons.error);
                                              },
                                            ),
                                            Text(e,style: Theme.of(context).textTheme.bodyMedium),
                                          ],
                                        ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
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
                                  children: directorItems.map((e){
                                    return Container(
                                      margin: EdgeInsets.only(right: 15.0),
                                      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                      child: Column(
                                        children: [
                                          Image.network(
                                            "https://image.tmdb.org/t/p/original/40n61jOMzHpDSnzLBQOSEEWlxEw.jpg",
                                            width: 100,
                                            height: 150,
                                            fit: BoxFit.contain,
                                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return Center(
                                                  widthFactor: 1,
                                                  heightFactor: 1,
                                                  child: CircularProgressIndicator(),
                                                );
                                              }
                                            },
                                            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                              return Icon(Icons.error);
                                            },
                                          ),
                                          Text(e,style: Theme.of(context).textTheme.bodyMedium),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                    flex:2,
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: (){},
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
                              Icon(Icons.favorite_outline,size: 50,),
                              Text("收藏"),
                              Icon(Icons.favorite_outline,size: 50,),
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