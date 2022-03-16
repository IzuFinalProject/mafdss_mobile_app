
part of 'notification_bloc.dart';

enum NotificationStatus { initial, success, error, loading }

extension NotificationStatusX on NotificationStatus {
  bool get isInitial => this == NotificationStatus.initial;
  bool get isSuccess => this == NotificationStatus.success;
  bool get isError => this == NotificationStatus.error;
  bool get isLoading => this == NotificationStatus.loading;
}

class NotificationState extends Equatable {
  const NotificationState( {
    this.status = NotificationStatus.initial,
    List<Notification>? notifications
  })  : notifications = notifications ?? const [];

  final List<Notification> notifications;
  final NotificationStatus status;

  @override
  List<Object?> get props => [status, notifications];

  NotificationState copyWith({
    List<Notification>? notifications,
    NotificationStatus? status
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      status: status ?? this.status
    );
  }
}