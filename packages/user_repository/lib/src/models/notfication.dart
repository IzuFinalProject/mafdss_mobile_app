

class Notification {
  final String message;
  final String title;
  final String created_at;
  Notification(
      {required this.message,
      required this.title,
      required this.created_at,
      });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      message: json['message'],
      title:json['title'],
      created_at:json['created_at'],
    );
  }
  Map<String, dynamic> toDatabaseJson() => {
        "title": this.title,
        "message": this.message,
        "created_at": this.created_at,
      };
}
