import 'dart:convert';
import 'package:avec_moi_with_us/models/user/information/information.dart';
import 'package:avec_moi_with_us/models/user/information/password.dart';
import 'package:avec_moi_with_us/models/user/information/preference.dart';
import 'package:http/http.dart' as http;
import 'package:avec_moi_with_us/utils/exception.dart';
import 'package:avec_moi_with_us/services/utils/jwt_storage.dart';
import 'package:avec_moi_with_us/services/api_routes.dart';


class InformationService {
  JwtService jwtService;
  http.Client httpClient;

  InformationService({JwtService? jwtService, http.Client? httpClient,}): jwtService = jwtService ?? JwtService(), httpClient = httpClient ?? http.Client();

  Future<ResponseInformation> getInformation() async {
    String? jwt=await jwtService.getJwt();
    if(jwt==null){
      throw AuthException("JWT invalid");
    }
    final response = await httpClient.get(
      Uri.parse(ApiRoutes.userInformationUrl),
      headers: {'Authorization': 'Bearer $jwt'},
    );
    if (response.statusCode == 200) {
      Map<String,dynamic> result=jsonDecode(response.body);
      return ResponseInformation.fromJson(result);
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }
    else if (response.statusCode == 401){
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

  Future<void> editInformation(RequestEditInformation data) async {
    String? jwt=await jwtService.getJwt();
    if(jwt==null){
      throw AuthException("JWT invalid");
    }
    print("HAHAH");
    final response = await httpClient.put(
      Uri.parse(ApiRoutes.editInformationUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept':'application/json',
        'Authorization': 'Bearer $jwt'
      },
      body: jsonEncode(data.formatJson()),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return;
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }
    else if (response.statusCode == 401){
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

  Future<void> editPassword(RequestEditPassword data) async {
    String? jwt=await jwtService.getJwt();
    if(jwt==null){
      throw AuthException("JWT invalid");
    }
    final response = await httpClient.put(
      Uri.parse(ApiRoutes.editPasswordUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept':'application/json',
        'Authorization': 'Bearer $jwt'
      },
      body: jsonEncode(data.formatJson()),
    );

    if (response.statusCode == 200) {
      return;
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }
    else if (response.statusCode == 401){
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

  Future<ResponsePreference> getPreference() async {
    String? jwt=await jwtService.getJwt();
    if(jwt==null){
      throw AuthException("JWT invalid");
    }
    final response = await httpClient.get(
      Uri.parse(ApiRoutes.preferenceUrl),
      headers: {'Authorization': 'Bearer $jwt'},
    );


    if (response.statusCode == 200) {
      Map<String,dynamic> result=jsonDecode(response.body);
      return ResponsePreference.fromJson(result);
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }
    else if (response.statusCode == 401){
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

  Future<ResponsePreference> editPreference(RequestPreference data) async {
    String? jwt=await jwtService.getJwt();
    if(jwt==null){
      throw AuthException("JWT invalid");
    }
    final response = await httpClient.post(
      Uri.parse(ApiRoutes.preferenceUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept':'application/json',
        'Authorization': 'Bearer $jwt'
      },
      body: jsonEncode(data.formatJson()),
    );

    if (response.statusCode == 200) {
      Map<String,dynamic> result=jsonDecode(response.body);
      return ResponsePreference.fromJson(result);
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }
    else if (response.statusCode == 401){
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
