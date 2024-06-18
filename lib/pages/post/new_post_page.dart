import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:peak/constants.dart';
import 'package:peak/pages/profile/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../providers/navigation/navigation_provider.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  File? selectedImage;
  String? postURL;

  TextEditingController postDescriptionController = TextEditingController();

  Future<CroppedFile?> cropImage(XFile image) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Crop Image",
          toolbarColor: appPrimaryColour,
          toolbarWidgetColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          dimmedLayerColor: appPrimaryColour,
        ),
        IOSUiSettings(
          title: "Crop Image",
        ),
      ],
    );
    return croppedFile;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 38.0),
      child: Stack(
        children: [
          Align(
            alignment: selectedImage != null ? Alignment.topCenter : Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  selectedImage != null
                      ? FractionallySizedBox(
                          widthFactor: 0.94,
                          child: Image.file(selectedImage!),
                        )
                      : const SizedBox.shrink(),
                  selectedImage != null
                      ? FractionallySizedBox(
                          widthFactor: 0.94,
                          child: Form(
                            child: TextFormField(
                              controller: postDescriptionController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: const InputDecoration(
                                label: Text("Description"),
                                hintText: "Description...",
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  selectedImage == null
                      ? ElevatedButton(
                          onPressed: () async {
                            try {
                              final XFile? image = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 100,
                              );

                              CroppedFile? croppedFile = await cropImage(image!);

                              setState(() {
                                selectedImage = File(croppedFile!.path);
                              });
                            } catch (error) {
                              debugPrint(error.toString());
                            }
                          },
                          child: const Text("Pick From Gallery"),
                        )
                      : const SizedBox.shrink(),
                  selectedImage == null
                      ? ElevatedButton(
                          onPressed: () async {
                            try {
                              final XFile? image = await ImagePicker().pickImage(
                                source: ImageSource.camera,
                                imageQuality: 100,
                              );

                              CroppedFile? croppedFile = await cropImage(image!);

                              setState(() {
                                selectedImage = File(croppedFile!.path);
                              });
                            } catch (error) {
                              debugPrint(error.toString());
                            }
                          },
                          child: const Text("Pick From Camera"),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          selectedImage != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (selectedImage != null) {
                          final storageRef = FirebaseStorage.instance.ref();

                          final imageReference = storageRef.child(selectedImage!.path);

                          try {
                            await imageReference.putFile(selectedImage!);

                            postURL = await imageReference.getDownloadURL();

                            if (postURL != null) {
                              String postID = const Uuid().v4();
                              FieldValue timePosted = FieldValue.serverTimestamp();

                              final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

                              await FirebaseFirestore.instance.collection('posts').doc(postID).set({
                                "posterID": firebaseAuth.currentUser!.uid.toString(),
                                "postID": postID,
                                'postTime': timePosted,
                                "description": postDescriptionController.text,
                                "imageUrl": postURL,
                                ///TODO change this to take in users hashtags on their post description
                                "tags": {"#meme": true, "#gym": true},
                              });

                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc("${firebaseAuth.currentUser?.uid.toString()}")
                                  .collection("postIDs")
                                  .doc(postID)
                                  .set({
                                "posterID": firebaseAuth.currentUser?.uid.toString(),
                                "postID": postID,
                                'postTime': timePosted,
                                "postURL": postURL,
                              });

                              if (context.mounted) {
                                context
                                    .read<NavigationProvider>()
                                    .navigatorBarNavigationReset(navigatorIndex: 3);
                              }
                            }
                          } catch (error) {
                            debugPrint(error.toString());
                          }
                        }
                      },
                      child: const Text("Post"),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
