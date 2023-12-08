class RequestAuth{
  final String idToken;

  RequestAuth(this.idToken);

  Map<String,String> formatJson(){
    return {
      "id_token": idToken,
    };
  }
}