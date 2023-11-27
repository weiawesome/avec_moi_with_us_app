import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PopularMoviesPage(),
    );
  }
}

class PopularMoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // 在這裡處理返回鍵的操作
            print('Back button clicked');
          },
        ),
        title: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.purple[100], // 淡紫色背景
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '🔥HOT',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple[800], // 深紫色文字
              fontFamily: 'cursive', // 使用藝術字體
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildMovieCard(
            '阿甘正传',
            'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2372307693.webp',
            'https://movie.douban.com/subject/1292720/',
          ),
          SizedBox(height: 16.0),
          _buildMovieCard(
            '肖申克的救赎',
            'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p480747492.webp',
            'https://movie.douban.com/subject/1292052/',
          ),
          // Add more movie cards as needed
        ],
      ),
    );
  }

  Widget _buildMovieCard(String title, String imageUrl, String hyperlink) {
    return Card(
      child: GestureDetector(
        onTap: () {
          // 處理超連結點擊 (打開其他網站)
          // 這裡只是一個示例，你可能想使用`url_launcher`插件打開外部網站
          print('Clicked on $title. Opening link: $hyperlink');
        },
        child: Row(
          children: [
            // Movie Image
            Container(
              width: 100.0,
              height: 150.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('$imageUrl'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Movie Title (Hyperlink)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  textAlign: TextAlign.center,
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
