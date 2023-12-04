class RequestSignup{
  final String mail;
  final String password;
  final String name;
  final String gender;

  RequestSignup(this.mail,this.password,this.name,this.gender);

  Map<String,String> formatJson(){
    return {
      "mail": mail,
      "password":password,
      "name":name,
      "gender":gender
    };
  }
}