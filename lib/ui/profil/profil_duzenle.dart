import 'dart:io';

import 'package:bunudaoku/db/db_helper.dart';
import 'package:bunudaoku/db/userdao.dart';
import 'package:bunudaoku/izin/izin.dart';
import 'package:bunudaoku/models/Kullanici.dart';
import 'package:bunudaoku/shared_preferences.dart/auth_sp.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfilDuzenle extends StatefulWidget {
  const ProfilDuzenle({Key? key}) : super(key: key);

  @override
  State<ProfilDuzenle> createState() => _ProfilDuzenleState();
}

class _ProfilDuzenleState extends State<ProfilDuzenle> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  final ImagePicker pickerProfile = ImagePicker();
  bool pickImage = false;
  CroppedFile? imageFileProfile;
  bool show = false;
  String dosyaYol = "";

  void onImageButtonPressed(ImageSource source, {BuildContext? context}) async {
    setState(() {
      pickImage = false;
    });

    try {
      final pickedFile = await pickerProfile.pickImage(
        source: source,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        CroppedFile? croppedFile = await crop(pickedFilePath: pickedFile.path);
        if (croppedFile != null) {
          setState(() {
            imageFileProfile = croppedFile;
            pickImage = true;
          });
          
          final imgFile = File(imageFileProfile!.path);
          dosyaYol = await VeritabaniYardimcisi.databaseYol(
              dosyaadi: "profile-img.jpeg");
          imgFile.copy(dosyaYol);
        }
        setState(() {
          show = false;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<CroppedFile?> crop({required String pickedFilePath}) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
        sourcePath: pickedFilePath,
        aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
        compressQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: Colors.white,
            toolbarTitle: "Resmi kırpın",
          ),
        ]);
    return croppedFile;
  }

  @override
  Widget build(BuildContext context) {
    UserDao.kullaniciGetir().then((value) {
      if (value != null) {
        //imageFileProfile.path = value.imgPath;
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Bilgilerini Düzenle'),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: (() {
              setState(() {
                show = !show;
              });
            }),
            child: Container(
              child: pickImage == false
                  ? const Center(child: Icon(Icons.add_a_photo_outlined))
                  : Image.file(File(imageFileProfile!.path), fit: BoxFit.cover),
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: nameController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Adınızı Giriniz',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: lastNameController,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Soyadınızı Giriniz',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity / 1.2,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                onPressed: () async {
                  Kullanici kullanici = (await AuthStorage.getAuthUser())!;
                  kullanici.name = nameController.text;
                  kullanici.lastName = lastNameController.text;
                  kullanici.imgPath = dosyaYol;
                  Kullanici? kullanicii = await UserDao.kullaniciGetir();
                  if (kullanicii == null) {
                    await UserDao.kullaniciEkle(kullanici: kullanici);
                  } else {
                    kullanici.id = kullanicii.id;
                    await UserDao.kullaniciGuncelle(kullanici: kullanici);
                  }
                  Navigator.pop(context);
                },
                child: const Text('Düzenle'),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: showBottomSheet(),
    );
  }

  Widget showBottomSheet() {
    if (show) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 9 / 10,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.green),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    onTap: () async {
                      if (await requestPermission(Permission.camera)) {
                        onImageButtonPressed(ImageSource.camera,
                            context: context);
                      } else {
                        /*const GetSnackBar(
                            title: "Lütfen kamera erişimine izin veriniz.");*/
                      }
                    },
                    title: const Text("Kamera"),
                    leading: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.green,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 9 / 10,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.green),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    onTap: () {
                      onImageButtonPressed(ImageSource.gallery,
                          context: context);
                    },
                    title: const Text("Galeri"),
                    leading: const Icon(
                      Icons.photo_library_outlined,
                      color: Colors.green,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 9 / 10,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.red),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        show = false;
                      });
                    },
                    title: const Text("İptal"),
                    leading: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
