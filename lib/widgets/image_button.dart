import 'package:avec_moi_with_us/utils/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class ImageButton extends StatelessWidget {
  final String movieId;
  final String imageUrl;
  final String year;
  final String title;
  final double score;

  const ImageButton({Key?key,required this.movieId,required this.imageUrl,required this.year,required this.title,required this.score}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "前往該個電影或影集詳細資訊頁面的按鈕",
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.specificMovie, arguments: movieId);
        },
        child: Container(
          width: 150,
          height: 250,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Semantics(
                label: "此電影或影集的圖像",
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 150,
                  height: 200,
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) => Semantics(
                    label: "載入圖片時的等待畫面",
                    child: const SizedBox(
                      width: 150,
                      height: 200,
                      child: Center(
                        widthFactor: 1,heightFactor: 1,
                          child: CircularProgressIndicator(color: Color(0xFFFD6868),)),
                    ),
                  ),
                  errorWidget: (context, url, error) => Semantics(
                    label: "圖片載入失敗時的替代畫面",
                    child: const SizedBox(
                      width: 150,
                      height: 200,
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(child: Semantics(label: "該部電影或影集的發行年分",child: Text(year, style: Theme.of(context).textTheme.bodySmall,overflow: TextOverflow.ellipsis,))),
                  Flexible(
                    child: Semantics(
                      label: "該部電影或影集的標題",
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Flexible(child: Semantics(label:"該部電影或影集的評分",child: Text("$score 分", style: Theme.of(context).textTheme.bodySmall,overflow: TextOverflow.ellipsis,))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DualImageButton extends StatelessWidget {
  final String movieId;
  final String imageUrl;
  final String year;
  final String title;
  final double score;

  const DualImageButton({Key?key,required this.movieId,required this.imageUrl,required this.year,required this.title,required this.score}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex:1,
      child: Semantics(
        label: "前往該電影或影集的詳細資訊頁面的按鈕",
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.specificMovie, arguments: movieId);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Semantics(
                  label: "該部電影或影集的圖片",
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.fitWidth,
                    placeholder: (context, url) => const SizedBox(
                      width: 150,
                      height: 200,
                      child: Center(
                        widthFactor: 1,
                          heightFactor: 1,
                          child: CircularProgressIndicator(color: Color(0xFFFD6868),
                          )),
                    ),
                    errorWidget: (context, url, error) => const SizedBox(
                      width: 150,
                      height: 200,
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(child: Semantics(label:"該部電影或影集的發行年分",child: Text(year, style: Theme.of(context).textTheme.bodySmall,overflow: TextOverflow.ellipsis,))),
                    Flexible(
                      flex:2,
                      child: Semantics(
                        label: "該部電影或影集的標題名稱",
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Flexible(child: Semantics(label:"該電影或影集的評分",child: Text("$score 分", style: Theme.of(context).textTheme.bodySmall,overflow: TextOverflow.ellipsis,))),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SingleImageButton extends StatelessWidget {
  final String movieId;
  final String imageUrl;
  final String year;
  final String title;
  final double score;

  const SingleImageButton({Key?key,required this.movieId,required this.imageUrl,required this.year,required this.title,required this.score}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "前往該電影或影集的詳細資訊頁面的按鈕",
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.specificMovie, arguments: movieId);
        },
        child: Container(
          height: 200,
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                label: "該部電影或影集的圖片",
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 150,
                  height: 200,
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) => Semantics(
                    label: "正在等待載入該圖片的載入畫面",
                    child: const SizedBox(
                      width: 150,
                      height: 200,
                      child: Center(
                        widthFactor: 1,
                          heightFactor: 1,
                          child: CircularProgressIndicator(color: Color(0xFFFD6868),)),
                    ),
                  ),
                  errorWidget: (context, url, error) => Semantics(
                    label: "未成功獲得該電影或影集圖片的取代標籤",
                    child: const SizedBox(
                      width: 150,
                      height: 200,
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              // Wrap the Column with Flexible or Expanded
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(child: Semantics(label:"電影或影集的發行年份",child: Text("發行年份 : $year", style: Theme.of(context).textTheme.bodyMedium,overflow: TextOverflow.ellipsis,))),
                      Flexible(
                        child: Semantics(
                          label: "電影或影集的名稱",
                          child: Text(
                            "名稱 : $title",
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Flexible(child: Semantics(label:"電影或影集的評分",child: Text("評分 : $score 分", style: Theme.of(context).textTheme.bodyMedium,overflow: TextOverflow.ellipsis,))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}