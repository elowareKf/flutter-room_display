import 'package:camera/camera.dart';
import 'dart:io';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

class AlarmSystem {
  static CameraDescription _camera;
  static CameraController _controller;
  static String _fileName;
  static List<int> currentImage;
  static Function callback;

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
      //currentImage = File(_fileName).readAsBytesSync();

      var image = decodeImage(new File(_fileName).readAsBytesSync());
      _images.add(image);

      if (_images.length < 3) {
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

    var latest = grayscale(gaussianBlur(copyResize(images.last, 250), 2));
    var first = grayscale(gaussianBlur(copyResize(images.first,250), 2));
    var result = new Image(latest.width, latest.height);
    int count = 0;

    for (int w = 0; w < latest.width; w++){
      for (int h = 0; h < latest.height; h++){
          var value = latest.getPixel(w, h).toInt() - first.getPixel(w, h).toInt();
          if (value < 0) value = value * -1;
          if (value > 400000) count++;

          result.setPixel(w, h, value);
      }
    }
    currentImage = encodeJpg(result);
    if (callback != null)
      callback();

      print("Alarm value $count");
    return count > 750;
  }
}
