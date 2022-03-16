import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/notfication/bloc/notification_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'notification_list.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => NotificationPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NotificationBloc(userRepository: UserRepository()),
        child: Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
              title: const Text('Notifications'),
            ),
            body: BlocBuilder<NotificationBloc, NotificationState>(
                buildWhen: (prev, curr) => curr.status.isSuccess,
                builder: (ctx, state) {
                  return NotificationList();
                })));
  }
}
