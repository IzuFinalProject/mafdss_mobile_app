import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:school_app/authentication/bloc/authentication_bloc.dart';
import 'package:school_app/profile/view/button_widget.dart';
import 'package:school_app/profile/widget/profile_widget.dart';
import 'package:user_repository/user_repository.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ProfilePage());
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = context.select(
                  (AuthenticationBloc bloc) => bloc.state.user,
                );

    return Scaffold(
       appBar : AppBar(leading: const BackButton(), title: const Text('Profile'), actions: [
        IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.moon))]),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.profileImage,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.first_name + " "+user.last_name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Upgrade To PRO',
        onClicked: () {},
      );

  Widget buildAbout(User user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "A user is a person who utilizes a computer or network service. A user often has a user account and is identified to the system by a username. Other terms for username include login name, screenname, account name, nickname and handle, which is derived from the identical citizens band radio term.",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}