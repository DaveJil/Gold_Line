import 'package:image_picker/image_picker.dart';

class UploadFiles {
  final ImagePicker _picker = ImagePicker();

  Future getImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    final path = pickedImage!.path;
    return path;
  }

  // get image from camera
  Future getImageFromCamera() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    final path = pickedImage!.path;
    return path;
  }
}

// Future getCameraImage() async {
//   dynamic image;
//   final picker = ImagePicker();
//
//   var pickedFile = await picker.getImage(
//       source: ImageSource.camera,
//       imageQuality: 50, // <- Reduce Image quality
//       maxHeight: 500, // <- reduce the image size
//       maxWidth: 500);
//
//   image = File(pickedFile!.path);
//
//   upload(image);
// }

// Future getGalleryImage() async {
//   dynamic image;
//   final picker = ImagePicker();
//
//   var pickedFile = await picker.pickImage(
//       source: ImageSource.camera,
//       imageQuality: 50, // <- Reduce Image quality
//       maxHeight: 500, // <- reduce the image size
//       maxWidth: 500);
//
//   image = File(pickedFile!.path);
//
//   upload(image);
// }

// void uploadAvatar(File file) async {
//   String fileName = file.path.split('/').last;
//
//   FormData data = FormData.fromMap({
//     "avatar": await MultipartFile.fromFile(
//       file.path,
//       filename: fileName,
//       //important
//     ),
//   });
//
//   Dio dio = Dio();
//
//   dio
//       .post("user/profile", data: data)
//       .then((response) => //print(response))
//       .catchError((error) => //print(error));
// }
