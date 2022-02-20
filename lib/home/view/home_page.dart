import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/authentication/bloc/authentication_bloc.dart';
import 'package:school_app/profile/profile.dart';
import 'package:school_app/services/notification_service.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const BackButton(),
          title: const Text('Home'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.moon)),
            PopupMenuButton(itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 'logout',
                  child: Text('Logout'),
                ),
                const PopupMenuItem(
                  value: 'profile',
                  child: Text('Profile'),
                )
              ];
            }, onSelected: (String value) {
              switch (value) {
                case 'logout':
                  NotificationService()
                      .showNotification("logout", "Thanks For Using Our App");
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                  break;
                case 'profile':
                  Navigator.push(context, ProfilePage.route());
                  break;
                default:
              }
            }),
          ]),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(
              builder: (context) {
                final username = context.select(
                  (AuthenticationBloc bloc) => bloc.state.user.username,
                );
                return Text('Id: $username');
              },
            )
          ],
        ),
      ),
    );
  }
}
