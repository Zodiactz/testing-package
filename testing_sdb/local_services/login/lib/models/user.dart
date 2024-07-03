class UserModel{
  final String username;
  final String email;
  final String password;

  UserModel({required this.username,required this.email, required this.password});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      username: json['username'],
      email: json['email'],
      password: json['password']
    );
  }
}