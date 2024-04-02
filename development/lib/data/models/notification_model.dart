class NotificationModel {
  String notificationId;
  String recipientId;
  String senderId;
  String jobId;
  String type;
  String message;
  DateTime timestamp;
  bool read;

  NotificationModel({
    required this.notificationId,
    required this.recipientId,
    required this.senderId,
    required this.jobId,
    required this.type,
    required this.message,
    required this.timestamp,
    required this.read,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['notificationId'],
      recipientId: json['recipientId'],
      senderId: json['senderId'],
      jobId: json['jobId'],
      type: json['type'],
      message: json['message'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
      read: json['read'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationId': notificationId,
      'recipientId': recipientId,
      'senderId': senderId,
      'jobId': jobId,
      'type': type,
      'message': message,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'read': read,
    };
  }

  NotificationModel copyWith({
    String? notificationId,
    String? recipientId,
    String? senderId,
    String? jobId,
    String? type,
    String? message,
    DateTime? timestamp,
    bool? read,
  }) {
    return NotificationModel(
      notificationId: notificationId ?? this.notificationId,
      recipientId: recipientId ?? this.recipientId,
      senderId: senderId ?? this.senderId,
      jobId: jobId ?? this.jobId,
      type: type ?? this.type,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      read: read ?? this.read,
    );
  }
}
