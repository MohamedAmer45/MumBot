class sessionmodel {
  String id;
  final int specialistId;
  final String freeDay;
  final String slotDate;
  final int slotStartTimeInteger;
  final String slotStartTime;
  final String slotEndTime;
  final int booked;

  sessionmodel({
    this.id,
    this.specialistId,
    this.freeDay,
    this.slotDate,
    this.slotStartTimeInteger,
    this.slotStartTime,
    this.slotEndTime,
    this.booked,
  });

  factory sessionmodel.fromJson(Map<String, dynamic> json) {
    return sessionmodel(
      id: json['id'],
      specialistId: json['schedule_specialist'],
      freeDay: json['free_day'],
      slotDate: json['slot_date'],
      slotStartTimeInteger: json['slot_start_time_integer'],
      slotStartTime: json['slot_start_time'],
      slotEndTime: json['slot_end_time'],
      booked: json['booked'],
    );
  }
  dynamic toJson() => {
        'schedule_specialist': specialistId,
        'free_day': freeDay,
        'slot_date': slotDate,
        'slot_start_time_integer': slotStartTimeInteger,
        'slot_start_time': slotStartTime,
        'slot_end_time': slotEndTime,
        'booked': booked,
      };
}
