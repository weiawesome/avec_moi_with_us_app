import 'dart:convert';
import 'package:avec_moi_with_us/models/movie/movie.dart';
import 'package:avec_moi_with_us/models/movie/movie_specific.dart';
import 'package:http/http.dart' as http;
import 'package:avec_moi_with_us/utils/exception.dart';
import 'package:avec_moi_with_us/services/utils/jwt_storage.dart';
import 'package:avec_moi_with_us/services/api_routes.dart';


class MovieService {
  JwtService jwtService;
  http.Client httpClient;

  MovieService({JwtService? jwtService, http.Client? httpClient,}): jwtService = jwtService ?? JwtService(), httpClient = httpClient ?? http.Client();
  Future<ResponseMovie> getMovie(int page,int randomSeed) async {
    final response = await httpClient.get(
      Uri.parse("${ApiRoutes.movieUrl}?page=$page&random_seed=$randomSeed"),
    );
    if (response.statusCode == 200) {
      Map<String,dynamic> result=jsonDecode(response.body);
      return ResponseMovie.fromJson(result);
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }
    else if (response.statusCode == 500){
      throw ServerException("System error.");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }

  Future<ResponseMovie> getRecommendMovie() async {
    String? jwt=await jwtService.getJwt();
    final response = await httpClient.get(
      Uri.parse(ApiRoutes.recommendUrl),
      headers: {'Authorization': 'Bearer $jwt'},
    );
    if (response.statusCode == 200) {
      Map<String,dynamic> result=jsonDecode(response.body);
      return ResponseMovie.fromJson(result);
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }
    else if (response.statusCode == 401){
      await jwtService.deleteJwt();
      throw AuthException("Invalid Jwt token.");
    }
    else if (response.statusCode == 422){
      await jwtService.deleteJwt();
      throw AuthException("Invalid Jwt token.");
    }
    else if (response.statusCode == 500){
      throw ServerException("System error.");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }

  Future<ResponseMovie> getRecentlyHotMovie(int page) async {
    final response = await httpClient.get(
      Uri.parse("${ApiRoutes.recentlyHotUrl}?page=$page"),
    );

    if (response.statusCode == 200) {
      Map<String,dynamic> result=jsonDecode(response.body);
      return ResponseMovie.fromJson(result);
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }
    else if(response.statusCode == 404){
      return ResponseMovie(totalPages: -1, currentPage: page, movieList: []);
    }
    else if (response.statusCode == 500){
      throw ServerException("System error.");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }
  Future<ResponseMovie> getRecentlyViewMovie(int page) async {
    String? jwt=await jwtService.getJwt();
    final response = await httpClient.get(
      Uri.parse("${ApiRoutes.recentlyViewUrl}?page=$page"),
      headers: {'Authorization': 'Bearer $jwt'},
    );
    if (response.statusCode == 200) {
      Map<String,dynamic> result=jsonDecode(response.body);
      return ResponseMovie.fromJson(result);
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }
    else if (response.statusCode == 401){
      await jwtService.deleteJwt();
      throw AuthException("Invalid Jwt token.");
    }
    else if (response.statusCode == 422){
      await jwtService.deleteJwt();
      throw AuthException("Invalid Jwt token.");
    }
    else if (response.statusCode == 500){
      throw ServerException("System error.");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }
  Future<ResponseMovie> getLikeMovie(int page) async {
    String? jwt=await jwtService.getJwt();
    final response = await httpClient.get(
      Uri.parse("${ApiRoutes.likeUrl}?page=$page"),
      headers: {'Authorization': 'Bearer $jwt'},
    );
    if (response.statusCode == 200) {
      Map<String,dynamic> result=jsonDecode(response.body);
      return ResponseMovie.fromJson(result);
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }
    else if (response.statusCode == 401){
      await jwtService.deleteJwt();
      throw AuthException("Invalid Jwt token.");
    }
    else if (response.statusCode == 422){
      await jwtService.deleteJwt();
      throw AuthException("Invalid Jwt token.");
    }
    else if (response.statusCode == 500){
      throw ServerException("System error.");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }
  Future<void> getIsLikeMovie(String movieId) async {
    String? jwt=await jwtService.getJwt();
    final response = await httpClient.get(
      Uri.parse("${ApiRoutes.likeUrl}/$movieId"),
      headers: {'Authorization': 'Bearer $jwt'},
    );
    if (response.statusCode == 200) {
      return;
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    } else if(response.statusCode == 404){
      throw ExistException("Not like the movie.");
    }
    else if (response.statusCode == 401){
      await jwtService.deleteJwt();
      throw AuthException("Invalid Jwt token.");
    }
    else if (response.statusCode == 422){
      await jwtService.deleteJwt();
      throw AuthException("Invalid Jwt token.");
    }
    else if (response.statusCode == 500){
      throw ServerException("System error.");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }
  Future<void> addLikeMovie(String movieId) async {
    String? jwt=await jwtService.getJwt();
    final response = await httpClient.post(
      Uri.parse("${ApiRoutes.likeUrl}/$movieId"),
      headers: {'Authorization': 'Bearer $jwt'},
    );
    if (response.statusCode == 200) {
      return;
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    } else if(response.statusCode == 404){
      throw ExistException("Not exist such movie.");
    }
    else if (response.statusCode == 401){
      await jwtService.deleteJwt();
      throw AuthException("Invalid Jwt token.");
    }
    else if (response.statusCode == 422){
      await jwtService.deleteJwt();
      throw AuthException("Invalid Jwt token.");
    }
    else if (response.statusCode == 500){
      throw ServerException("System error.");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }
  Future<void> deleteLikeMovie(String movieId) async {
    String? jwt=await jwtService.getJwt();
    final response = await httpClient.delete(
      Uri.parse("${ApiRoutes.likeUrl}/$movieId"),
      headers: {'Authorization': 'Bearer $jwt'},
    );
    if (response.statusCode == 204) {
      return;
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    } else if(response.statusCode == 404){
      throw ExistException("Movie not exist.");
    }
    else if (response.statusCode == 401){
      await jwtService.deleteJwt();
      throw AuthException("Invalid Jwt token.");
    }
    else if (response.statusCode == 422){
      await jwtService.deleteJwt();
      throw AuthException("Invalid Jwt token.");
    }
    else if (response.statusCode == 500){
      throw ServerException("System error.");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }

  Future<ResponseMovie> searchMovie(String content,int page) async {
    final response = await httpClient.get(
      Uri.parse("${ApiRoutes.searchUrl}?content=$content&page=$page"),
    );
    if (response.statusCode == 200) {
      Map<String,dynamic> result=jsonDecode(response.body);
      return ResponseMovie.fromJson(result);
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }
    else if (response.statusCode == 500){
      throw ServerException("System error.");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }
  Future<ResponseSpecificMovie> getSpecificMovie(String movieId) async {
    String? jwt=await jwtService.getJwt();
    final response = await httpClient.get(
      Uri.parse("${ApiRoutes.movieUrl}/$movieId"),
      headers: {'Authorization': 'Bearer $jwt'},
    );
    if (response.statusCode == 200) {
      Map<String,dynamic> result=jsonDecode(response.body);
      return ResponseSpecificMovie.fromJson(result);
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }
    else if (response.statusCode == 401){
      await jwtService.deleteJwt();
      throw AuthException("Invalid Jwt token.");
    }
    else if(response.statusCode == 404){
      throw ExistException("Movie not exist.");
    }
    else if (response.statusCode == 422){
      await jwtService.deleteJwt();
      throw AuthException("Invalid Jwt token.");
    }
    else if (response.statusCode == 500){
      throw ServerException("System error.");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }
}
