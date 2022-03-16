import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_app/profile/bloc/profile_bloc.dart';
import 'package:school_app/profile/view/profile_page.dart';
import 'package:school_app/profile/widget/button_widget.dart';
import 'package:school_app/profile/widget/profile_widget.dart';
import 'package:user_repository/user_repository.dart';
import 'package:video_player/video_player.dart';

class EditProfilePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => EditProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Edit Profile Page',
      home: MyHomePage(title: 'Image Picker Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<XFile>? _imageFileList;

  dynamic _pickImageError;
  bool isVideo = false;

  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (isMultiImage) {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final List<XFile>? pickedFileList = await _picker.pickMultiImage(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _imageFileList = pickedFileList;
          });
          print("Image is done");
          context
              .read<ProfileBloc>()
              .add(EditUserProfilePicture(profileImage: _imageFileList));
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    } else {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            List<XFile>? lists = _imageFileList ?? [];
            lists.add(pickedFile!);
            _imageFileList = lists.cast<XFile>();
          });
          print("Image is done");
          context
              .read<ProfileBloc>()
              .add(EditUserProfilePicture(profileImage: _imageFileList));
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    }
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Column(
        children: [
          Text(
            'Upload Successful Go Back To Profile',
            textAlign: TextAlign.center,
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context, ProfilePage.route());
              },
              icon: const Icon(CupertinoIcons.person))
        ],
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _handlePreview() {
    return _previewImages();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        setState(() {
          _imageFileList = response.files;
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileBloc(UserRepository()),
        child: Scaffold(
            appBar: AppBar(
                leading: BackButton(onPressed: () {
                  Navigator.of(context).pop();
                }),
                title: const Text('Edit Profile Page'),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, ProfilePage.route());
                      },
                      icon: const Icon(CupertinoIcons.person))
                ]),
            body: BlocConsumer<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading){
                      const Center(child: CircularProgressIndicator());}
              return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Center(
                        child: !kIsWeb &&
                                defaultTargetPlatform == TargetPlatform.android
                            ? FutureBuilder<void>(
                                future: retrieveLostData(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<void> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                    case ConnectionState.waiting:
                                      return const Text(
                                          'You have not yet picked an image.',
                                          textAlign: TextAlign.center);
                                    case ConnectionState.done:
                                      return _handlePreview();
                                    default:
                                      if (snapshot.hasError) {
                                        return Text(
                                          'Pick image/video error: ${snapshot.error}}',
                                          textAlign: TextAlign.center,
                                        );
                                      } else {
                                        return const Text(
                                          'You have not yet picked an image.',
                                          textAlign: TextAlign.center,
                                        );
                                      }
                                  }
                                },
                              )
                            : _handlePreview())
                  ]);
            }, listener: (context, state) {
              if (state is ProfileError) {
                final msg = state.error;
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text(msg)),
                  );
              }
            }),
            floatingActionButton: BlocConsumer<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Semantics(
                      label: 'image_picker_example_from_gallery',
                      child: FloatingActionButton(
                        onPressed: () {
                          isVideo = false;
                          _onImageButtonPressed(ImageSource.gallery,
                              context: context);
                        },
                        heroTag: 'image0',
                        tooltip: 'Pick Image from gallery',
                        child: const Icon(Icons.photo),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          isVideo = false;
                          _onImageButtonPressed(
                            ImageSource.gallery,
                            context: context,
                            isMultiImage: true,
                          );
                        },
                        heroTag: 'image1',
                        tooltip: 'Pick Multiple Image from gallery',
                        child: const Icon(Icons.photo_library),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          isVideo = false;
                          _onImageButtonPressed(ImageSource.camera,
                              context: context);
                        },
                        heroTag: 'image2',
                        tooltip: 'Take a Photo',
                        child: const Icon(Icons.camera_alt),
                      ),
                    )
                  ],
                );
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
            )));
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add optional parameters'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: maxWidthController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxWidth if desired'),
                ),
                TextField(
                  controller: maxHeightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxHeight if desired'),
                ),
                TextField(
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Enter quality if desired'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    final double? width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : null;
                    final double? height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : null;
                    final int? quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : null;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
}

Column buildUserData(Profile profile) {
  return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    ProfileWidget(
      imagePath: profile.fileList.toString().split(",")[0],
      onClicked: () {},
    ),
    const SizedBox(height: 24),
    buildName(profile),
    const SizedBox(height: 24)
  ]);
}

Widget buildName(Profile user) => Column(
      children: [
        Text(
          user.username,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
