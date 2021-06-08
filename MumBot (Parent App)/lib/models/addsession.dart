class AddSession {
  int id;
  int parentId;
  int videoSlot;

  AddSession({this.id, this.parentId, this.videoSlot});

  factory AddSession.fromJson(Map<String, dynamic> json) {
    return AddSession(
      parentId: json['parent_id'],
      videoSlot: json['video_slot'],
    );
  }
  dynamic toJson() => {
        'parent_id': parentId,
        'video_slot': videoSlot,
      };
}
