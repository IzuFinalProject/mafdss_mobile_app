
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({
    required this.userRepository,
  }) : super(const NotificationState()) {
    on<GetNotifications>(_mapGetNotificationsEventToState);
    add(GetNotifications());
  }
  final UserRepository userRepository;

  void _mapGetNotificationsEventToState(
      GetNotifications event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(status: NotificationStatus.loading));
    try {
        final notifications =  await userRepository.getNotfications();
      emit(
        state.copyWith(
          status: NotificationStatus.success,
          notifications: notifications,
        ),
      );
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(status: NotificationStatus.error));
    }
  }

}