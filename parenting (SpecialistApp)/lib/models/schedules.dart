class Schedule {
  int id;
  final String freeDay;
  final String startTime;
  final int endTime;
  final String specialistId;

  Schedule(
      {this.id, this.freeDay, this.startTime, this.endTime, this.specialistId});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      freeDay: json['free_day'],
      startTime: json['free_day_start_time'],
      endTime: json['free_day_end_time'],
      specialistId: json['schedule_specialist_id'],
    );
  }
  dynamic toJson() => {
        'id': id,
        'free_day': freeDay,
        'free_day_start_time': startTime,
        'free_day_end_time': endTime,
        'schedule_specialist_id': specialistId,
      };
}
