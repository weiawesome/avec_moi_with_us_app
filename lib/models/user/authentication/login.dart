class RequestLogin{
  final String mail;
  final String password;

  RequestLogin(this.mail,this.password);

  Map<String,String> formatJson(){
    return {
      "mail": mail,
      "password":password
    };
  }

}

class ResponseLogin{
  final String token;

  ResponseLogin(this.token);

  ResponseLogin.fromJson(Map<String, dynamic> json) :
      token=json["token"];
}