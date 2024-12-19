/// Data of notification.
class NotificationData {
  /// Title of notification.
  final String title;

  /// Body of notification.
  final String body;

  /// Payload of notification.
  final Map<String, dynamic> payload;

  /// Create new instance of [NotificationData].
  NotificationData({
    required this.title,
    required this.body,
    required this.payload,
  });

  /// Create [NotificationData] from JSON.
  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        title: json['title'],
        body: json['body'],
        payload: Map<String, dynamic>.from(json['payload'] ?? []),
      );

  /// Create [NotificationData] from JSON.
  factory NotificationData.fromInitialMessage(Map<String, dynamic> json) {
    if (json.containsKey("intercom_push_type")) {
      final aps = Map<String, dynamic>.from(json['aps'] ?? []);
      return NotificationData(
        title: aps['alert'],
        body: aps['alert'],
        payload: json,
      );
    } else {
      final alert = Map<String, dynamic>.from(json['alert'] ?? []);
      return NotificationData(
        title: alert['title'],
        body: alert['body'],
        payload: json,
      );
    }
  }
}
