import 'package:camera/camera.dart';
import 'dart:io';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

class AlarmSystem {
  static CameraDescription _camera;
  static CameraController _controller;
  static String _fileName;
  static File currentImage;


  static List<Image> _images = new List<Image>();

  static Future<void> initSystem() async {
    var cameras = await availableCameras();
      var tempPath = await getTemporaryDirectory();
      _fileName = tempPath.path + "/image.jpg";

    for (var camera in cameras) {
      if (camera.lensDirection == CameraLensDirection.front) {
        _camera = camera;
        print("Camera choosen: " + _camera.name);

        _controller = CameraController(_camera, ResolutionPreset.medium);
        await _controller.initialize();
        break;
      }
    }
  }

  static Future<bool> observer() async {
    if (_controller == null) {
      print("Camera not set");
      return false;
    }

    print("Take a picture to save it at $_fileName");
    try {
      if (await File(_fileName).exists()) File(_fileName).deleteSync();
      await _controller.takePicture(_fileName);
      currentImage = File(_fileName);

      var image = decodeImage(new File(_fileName).readAsBytesSync());
      _images.add(image);

      if (_images.length < 30) {
        return false;
      }

      _images.removeAt(0);

      var alarm = alarmCheck(_images);

      return alarm;
    } catch (exception) {
      print(exception);
      return false;
    }
  }


  static bool alarmCheck(List<Image> images){
    return false;
  }
}
