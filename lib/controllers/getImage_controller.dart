import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

final StreamController _blocController = StreamController.broadcast();
final getImagePicker = new ImagePicker();

class GetImageController {
  PickedFile newImage;
  Sink get input => _blocController.sink;
  Stream get output => _blocController.stream;

  getImageGallery() async {
    newImage = await getImagePicker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    print("GET-IMAGE-CONTROLLER");
    input.add(newImage);
  }

  getImageCamera() async {
    newImage = await getImagePicker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    input.add(newImage);
    //  input.close();
  }

  dispose() {
    print("get image encerrado");
    _blocController.close();
  }
}
