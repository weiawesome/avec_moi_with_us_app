import "package:flutter/material.dart";
import "package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart";
import "package:stroke_text/stroke_text.dart";

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _scrollController = ScrollController();
  Future<void> _refresh() async {
    return await Future.delayed(const Duration(seconds: 2));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: Column(
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
                        child: Text("History",style: Theme.of(context).textTheme.titleMedium,),
                      ),
                    ),
                  ],

                ),
              ),
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
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top:10.0),
                            child: Container(
                              // margin: EdgeInsets.symmetric(),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.network(
                                    'https://image.tmdb.org/t/p/original/7Wa0N9bmUznYQzzNAdTAN0OgQ1w.jpg',
                                    width:200,
                                    fit: BoxFit.contain,
                                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                          widthFactor: 1,
                                          heightFactor: 1,
                                          child: CircularProgressIndicator(
                                          ),
                                        );
                                      }
                                    },
                                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                      return Icon(Icons.error);
                                    },
                                  ),
                                  Container(
                                    padding:EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("片名 : 咒術迴戰", style: Theme.of(context).textTheme.bodySmall),
                                        Text("發行年分 : 2017", style: Theme.of(context).textTheme.bodySmall),
                                        Text("評分 : 7.5分", style: Theme.of(context).textTheme.bodySmall),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
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