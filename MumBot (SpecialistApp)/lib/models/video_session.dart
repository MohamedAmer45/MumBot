class VideoSession {
  int id;
  final String price;
  final int durationInMinutes;
  final String date;
  final String startTime;
  final String endTime;
  final int parentId;
  final int specialistId;

  VideoSession({
    this.id,
    this.price,
    this.durationInMinutes,
    this.date,
    this.startTime,
    this.endTime,
    this.parentId,
    this.specialistId,
  });

  factory VideoSession.fromJson(Map<String, dynamic> json) {
    return VideoSession(
      id: json['id'],
      price: json['video_price'],
      durationInMinutes: json['video_duration_in_minutes'],
      date: json['video_date'],
      startTime: json['video_start_time'],
      endTime: json['video_end_time'],
      parentId: json['parent_id_id'],
      specialistId: json['specialist_id_id'],
    );
  }
  dynamic toJson() => {
        'id': id,
        'video_price': price,
        'video_duration_in_minutes': durationInMinutes,
        'video_date': date,
        'video_start_time': startTime,
        'video_end_time': endTime,
        'parent_id_id': parentId,
        'specialist_id_id': specialistId,
      };
}
