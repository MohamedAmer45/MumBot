class SingleInquiry {
  int id;
  final String price;
  final int durationInMinutes;
  final String startTime;
  final String endTime;
  final int parentId;
  final int specialistId;

  SingleInquiry({
    this.id,
    this.price,
    this.durationInMinutes,
    this.startTime,
    this.endTime,
    this.parentId,
    this.specialistId,
  });

  factory SingleInquiry.fromJson(Map<String, dynamic> json) {
    return SingleInquiry(
      id: json['id'],
      price: json['inquiry_price'],
      durationInMinutes: json['inquiry_duration_in_minutes'],
      startTime: json['inquiry_start_time'],
      endTime: json['inquiry_end_time'],
      parentId: json['parent_id_id'],
      specialistId: json['specialist_id_id'],
    );
  }
  dynamic toJson() => {
        'id': id,
        'inquiry_price': price,
        'inquiry_duration_in_minutes': durationInMinutes,
        'inquiry_start_time': startTime,
        'inquiry_end_time': endTime,
        'parent_id_id': parentId,
        'specialist_id_id': specialistId,
      };
}
