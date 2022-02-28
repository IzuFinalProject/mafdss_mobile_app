// import 'package:animated_theme_switcher/animated_theme_switcher.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:school_app/profile/bloc/profile_bloc.dart';
// import 'package:school_app/profile/view/edit_profile_form.dart';
// import 'package:school_app/profile/view/profile_page.dart';
// import 'package:user_repository/user_repository.dart';

// class EditProfilePage extends StatelessWidget {
//   const EditProfilePage({Key? key}) : super(key: key);
//   static Route route() {
//     return MaterialPageRoute<void>(builder: (_) => const EditProfilePage());
//   }

//   @override
//   Widget build(BuildContext context) =>ThemeSwitchingArea(
//         child: Builder(
//           builder: (context) => Scaffold(
//             appBar: AppBar(
//                 leading: const BackButton(),
//                 title: const Text('Edit Profile Page'),
//                 actions: [
//                   IconButton(
//                       onPressed: () {
//                         Navigator.push(context, ProfilePage.route());
//                       },
//                       icon: const Icon(CupertinoIcons.person))
//                 ]),
//             body: BlocProvider(
//           create: (context) =>ProfileBloc(UserRepository()),
//           child:EditProfileForm(),
//         )
//           ),
//         ),
//       );
// }