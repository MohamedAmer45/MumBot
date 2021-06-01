class User {
  int id;
  final String password;
  final String name;
  final String phone;
  final String email;
  final int role;

  User({this.id, this.name, this.email, this.password, this.phone, this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['user_name'],
      email: json['user_email'],
      password: json['user_password'],
      phone: json['user_phone'],
      role: json['user_role'],
    );
  }
  dynamic toJson() => {
        'id': id,
        'user_name': name,
        'user_email': email,
        'user_password': password,
        'user_phone': phone,
        'user_role': role,
      };
}
