import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/notfication/views/notfication_page.dart';
import 'package:school_app/profile/bloc/profile_bloc.dart';
import 'package:school_app/profile/view/edit_profile_page.dart';
import 'package:user_repository/user_repository.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ProfilePage());
  }

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext cx) {
    return Scaffold(
      appBar: AppBar(
          leading: const BackButton(),
          title: const Text('Profile'),
          actions: []),
      body: BlocProvider(
          create: (context) => ProfileBloc(UserRepository())..add((GetUser())),
          child: ListView(
            children: <Widget>[
              BlocConsumer<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoaded) {
                    return buildUserData(state.profile, context);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
                listener: (context, state) {
                  if (state is ProfileError) {
                    final msg = state.error;
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(content: Text(msg)),
                      );
                  }
                },
              )
            ],
          )),
    );
  }

  Column buildUserData(Profile profile, BuildContext cx) {
    return Column(
      children: <Widget>[
        Container(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 200.0,
                      child: Image.network(
                              profile.fileList[0].url,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;

                                return const Center(child: CircularProgressIndicator());
                                // You can use LinearProgressIndicator or CircularProgressIndicator instead
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  const Text('Some errors loading Image (:'),
                            ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          height: 130.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                profile.username,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 28.0),
              ),
              const SizedBox(
                width: 5.0,
              ),
              const Icon(
                Icons.check_circle,
                color: Colors.blueAccent,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Container(
            child: Text(
          profile.email,
          style: TextStyle(fontSize: 18.0),
        )),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.collections, color: Colors.blueAccent),
                  ),
                  const Text(
                    'Photos',
                    style: TextStyle(color: Colors.blueAccent),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(NotificationPage.route());
                    },
                    icon: Icon(Icons.notifications, color: Colors.black),
                  ),
                  const Text(
                    'Notifications',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.more_vert, color: Colors.black),
                    onPressed: () {
                      _showMoreOption(cx);
                    },
                  ),
                  const Text(
                    'More',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 10.0,
                child: const Divider(
                  color: Colors.grey,
                ),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Photos',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Container(
                child: Column(
                    children: profile.fileList.length > 0
                        ? List.generate(
                            profile.fileList.length,
                            (i) => Image.network(profile.fileList[i].url,
                                fit: BoxFit.fill, height: 256, width: 256))
                        : [Text("No Photo Yet")]),
              ),
            ],
          ),
        )
      ],
    );
  }

  _showMoreOption(cx) {
    showModalBottomSheet(
      context: cx,
      builder: (BuildContext bcx) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: const <Widget>[
                  Icon(
                    Icons.feedback,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Give feedback or report this profile',
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, EditProfilePage.route());
                    },
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: const <Widget>[
                  Icon(
                    Icons.link,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Copy link to profile',
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: const <Widget>[
                  Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Search Profile',
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
