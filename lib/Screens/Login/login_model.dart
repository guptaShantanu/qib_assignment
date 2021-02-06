class LoginModel{
  String phone;
  String password;

  LoginModel({this.phone="",this.password=""});

  bool varifyPhone(){
    return this.phone.length==10?true:false;
  }
}