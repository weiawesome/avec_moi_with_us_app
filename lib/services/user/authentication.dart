import 'dart:convert';
import 'package:avec_moi_with_us/models/user/authentication/login.dart';
import 'package:avec_moi_with_us/models/user/authentication/signup.dart';
import 'package:http/http.dart' as http;
import 'package:avec_moi_with_us/utils/exception.dart';
import 'package:avec_moi_with_us/services/utils/jwt_storage.dart';
import 'package:avec_moi_with_us/services/api_routes.dart';


class AuthenticationService {
  JwtService jwtService;
  http.Client httpClient;

  AuthenticationService({JwtService? jwtService, http.Client? httpClient,}): jwtService = jwtService ?? JwtService(), httpClient = httpClient ?? http.Client();

  Future<ResponseLogin> login(RequestLogin data) async {
    final response = await httpClient.post(
      Uri.parse(ApiRoutes.loginUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept':'application/json',
      },
      body: jsonEncode(data.formatJson()),
    );

    if (response.statusCode == 200) {
      Map<String,dynamic> result=jsonDecode(response.body);
      ResponseLogin r=ResponseLogin.fromJson(result);
      jwtService.saveJwt(r.token);
      return r;
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }
    else if (response.statusCode == 401){
      throw AuthException("Unauthorized with information. User have not registered or with incorrect password.");
    }
    else if (response.statusCode == 500){
      throw ServerException("System error.");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }
  Future<void> logout() async {
    String? jwt=await jwtService.getJwt();
    if(jwt==null){
      throw AuthException("JWT invalid");
    }
    final response = await httpClient.delete(
      Uri.parse(ApiRoutes.logoutUrl),
      headers: {'Authorization': 'Bearer $jwt'},
    );
    if (response.statusCode == 204) {
      return ;
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

  Future<void> signup(RequestSignup data) async {
    final response = await httpClient.post(
      Uri.parse(ApiRoutes.signupUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept':'application/json',
      },
      body: jsonEncode(data.formatJson()),
    );
    if (response.statusCode == 200) {
      return ;
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }
    else if (response.statusCode == 401){
      throw AuthException("Unauthorized with information. User have registered.");
    }
    else if (response.statusCode == 500){
      throw ServerException("System error.");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }
}

