import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:school_app/notfication/bloc/notification_bloc.dart';
import 'package:user_repository/src/models/notfication.dart'
    as notificationModel;

class NotificationList extends StatefulWidget {
  NotificationList({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => NotificationList());
  }

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(
        listener: (context, state) => {},
        builder: (context, state) {
          return state.status.isSuccess
              ? ListNotfication(state.notifications)
              : state.status.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox();
        });
  }

  ListNotfication(List<notificationModel.Notification> notifications) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(color: Colors.black45, blurRadius: 2.0)
                ]),
            child: Column(
              children:  [
                Text(
                    notifications[index].title),
                SizedBox(height: 16.0),
                Image(image: AssetImage('assets/images/cctv.jpg')),
                SizedBox(height: 16.0),
                Text(
                    (
                    notifications[index].message),
                    style: TextStyle(color: Colors.black38)),
                SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(Jiffy(notifications[index].created_at).format("MMMM do yyyy, h:mm:ss a")),
                )
              ],
            ),
          );
        });
  }
}
