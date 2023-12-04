class ResponseInformation{
  final String name;
  final String mail;
  final String gender;

  ResponseInformation(this.name,this.mail,this.gender);

  ResponseInformation.fromJson(Map<String, dynamic> json) :
    name=json["name"],
    mail=json["mail"],
    gender=json["gender"];
}

class RequestEditInformation{
  final String name;
  final String gender;

  RequestEditInformation(this.name,this.gender);

  Map<String,String> formatJson(){
    return {
      "name":name,
      "gender":gender
    };
  }

}