class RequestEditPassword{
  final String currentPassword;
  final String editPassword;

  RequestEditPassword(this.currentPassword,this.editPassword);

  Map<String,String> formatJson(){
    return {
      "current_password":currentPassword,
      "edit_password":editPassword
    };
  }

}