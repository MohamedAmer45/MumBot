import 'package:mumbot_v2/models/user.dart';

class Specialist extends User {
  final String brief;
  final bool activeStatus;

  Specialist({this.brief, this.activeStatus});

  factory Specialist.fromJson(Map<String, dynamic> json) {
    return Specialist(
      brief: json['specialist_brief'],
      activeStatus: json['specialist_active_status'],
    );
  }
  dynamic toJson() => {
        'specialist_brief': brief,
        'specialist_active_status': activeStatus,
      };
}
