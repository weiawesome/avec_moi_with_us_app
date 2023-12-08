import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CelebrityWidget extends StatelessWidget {
  final String imageUrl;
  final String name;

  const CelebrityWidget({Key?key,required this.imageUrl,required this.name}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 200,
      margin: const EdgeInsets.only(right: 15.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Semantics(
            label: "該名人物的圖像",
            child: CachedNetworkImage(
              imageUrl:imageUrl,
              width: 100,
              height: 150,
              fit: BoxFit.contain,
              placeholder: (context, url){
                return const SizedBox(
                  width: 100,
                  height: 150,
                  child: Center(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              errorWidget: (context, url, error){
                return const SizedBox(
                    width: 100,
                    height: 150,
                    child: Icon(Icons.error,size: 50,)
                );
              },
            ),
          ),
          Flexible(child: Semantics(label:"該名人物的名稱",child: Text(name,style: Theme.of(context).textTheme.bodyMedium,overflow: TextOverflow.ellipsis,))),
        ],
      ),
    );
  }
}