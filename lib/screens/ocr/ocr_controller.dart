part of 'ocr_imports.dart';
class OcrController {
  CameraController? cameraController;
  bool isPermissionGranted = false;

  late final Future<void> _future;


  Future<void> requestCameraPermission() async {
    final status = await Permission.camera.request();
    isPermissionGranted = status == PermissionStatus.granted;
  }
}