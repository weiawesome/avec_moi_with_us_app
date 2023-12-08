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
          Image.network(
            imageUrl,
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
          Flexible(child: Text(name,style: Theme.of(context).textTheme.bodyMedium,overflow: TextOverflow.ellipsis,)),
        ],
      ),
    );
  }
}