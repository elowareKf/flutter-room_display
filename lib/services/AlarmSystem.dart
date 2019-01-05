import 'package:camera/camera.dart';
import 'dart:io';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

class AlarmSystem {
  static CameraDescription _camera;
  static CameraController _controller;
  static String _fileName;

  static List<Image> _images = new List<Image>();

  Future<void> initSystem() async {
    var cameras = await availableCameras();
      var tempPath = await getApplicationDocumentsDirectory();
      _fileName = tempPath.path + "/images/image.jpg";

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

    print("Take a picture");
    try {
      if (await File(_fileName).exists()) File(_fileName).deleteSync();
      await _controller.takePicture(_fileName);

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
