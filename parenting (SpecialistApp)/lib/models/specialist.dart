class Specialist {
  int id;
  final String brief;
  final bool activeStatus;
  final String password;
  final String name;
  final String phone;
  final String email;
  final int role;

  Specialist(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.role,
      this.brief,
      this.activeStatus});

  factory Specialist.fromJson(Map<String, dynamic> json) {
    return Specialist(
      id: json['id'],
      name: json['user_name'],
      email: json['user_email'],
      password: json['user_password'],
      phone: json['user_phone'],
      role: json['user_role'],
      brief: json['specialist_brief'],
      activeStatus: json['specialist_active_status'],
    );
  }
  dynamic toJson() => {
        'id': id,
        'user_name': name,
        'user_email': email,
        'user_password': password,
        'user_phone': phone,
        'user_role': role,
        'specialist_brief': brief,
        'specialist_active_status': activeStatus,
      };
}
