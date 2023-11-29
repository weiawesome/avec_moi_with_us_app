import "package:avec_moi_with_us/utils/routes.dart";
import "package:flutter/material.dart";
import "package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart";

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});
  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  TextEditingController _searchController = TextEditingController();
  final _scrollController = ScrollController();
  Future<void> _refresh() async {
    return await Future.delayed(const Duration(seconds: 2));
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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

            child: Text("Avec Moi With Us",style: Theme.of(context).textTheme.titleMedium,),
          ),
        ),
        Flexible(
          flex:1,
          child: Container(
            child: TextField(
              controller: _searchController,
              style:  Theme.of(context).textTheme.labelSmall,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: Theme.of(context).textTheme.labelSmall,
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                  },
                ),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              ),
              onChanged: (value) {
                print('Search keyword: $value');
              },
            ),
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
                if (index==0){
                  return Container(
                      alignment: Alignment.centerLeft,
                      child: Text("專屬推薦",style: Theme.of(context).textTheme.titleSmall,)
                  );
                } else if (index==2){
                  return Container(
                      alignment: Alignment.centerLeft,
                      child: Text("電影/影集",style: Theme.of(context).textTheme.titleSmall,)
                  );
                }else if (index == 1) {
                  return SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, Routes.specific_movie);
                          },
                          child: Container(
                            width: 150,
                            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("2017", style: Theme.of(context).textTheme.bodySmall),
                                    Text("咒術迴戰", style: Theme.of(context).textTheme.bodySmall),
                                    Text("7.5分", style: Theme.of(context).textTheme.bodySmall),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height:250,
                        child: Container(
                          width: 150,
                          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("2017", style: Theme.of(context).textTheme.bodySmall),
                                  Text("咒術迴戰", style: Theme.of(context).textTheme.bodySmall),
                                  Text("7.5分", style: Theme.of(context).textTheme.bodySmall),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height:250,
                        child: Container(
                          width: 150,
                          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("2017", style: Theme.of(context).textTheme.bodySmall),
                                  Text("咒術迴戰", style: Theme.of(context).textTheme.bodySmall),
                                  Text("7.5分", style: Theme.of(context).textTheme.bodySmall),
                                ],
                              )
                            ],
                          ),
                  ),
                      ),
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