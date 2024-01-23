// ignore_for_file: use_build_context_synchronously

part of 'ocr_imports.dart';

class Ocr extends StatefulWidget {
  const Ocr({super.key});

  @override
  State<Ocr> createState() => _OcrState();
}

class _OcrState extends State<Ocr> with WidgetsBindingObserver {
 /* final textRecognizer = GoogleMlKit.vision.textRecognizer(script:TextRecognitionScript.latin);*/
  final OcrController controller = OcrController();
  late final Future<void> _future;
  CameraController? _cameraController;
  bool _isPermissionGranted = false;
  //final textRecognizer = TextRecognizer();
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopCamera();
    /*textRecognizer.close();*/
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _future = _requestCameraPermission();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        return Stack(
          children: [
            if (_isPermissionGranted)
              FutureBuilder<List<CameraDescription>>(
                future: availableCameras(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _initCameraController(snapshot.data!);

                    return Center(
                        child: CameraPreview(
                      _cameraController!,
                    ));
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              ),
            Scaffold(
              appBar: AppBar(
                title: const Text('Text Recognition Sample'),
              ),
              backgroundColor: _isPermissionGranted ? Colors.transparent : null,
              body: _isPermissionGranted
                  ? Column(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                     /*   InkWell(
                          onTap: _scanImage,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: primaryColor,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                            child:  const Text('Scan text', style: AppTextStyle.s12_w400(color: Colors.white)),
                          ),
                        ),*/
                      ],
                    )
                  : Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                        child: const Text(
                          'Camera permission denied',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }

  void _startCamera() {
    if (_cameraController != null) {
      _cameraSelected(_cameraController!.description);
    }
  }

  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras) {
    if (_cameraController != null) {
      return;
    }

    // Select the first rear camera.
    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.ultraHigh,
      imageFormatGroup: Platform.isAndroid ? ImageFormatGroup.jpeg : ImageFormatGroup.yuv420,
      enableAudio: false,
    );
    await _cameraController!.initialize();
    await _cameraController!.setFlashMode(FlashMode.off);

    if (!mounted) {
      return;
    }
    setState(() {});
  }

 /* Future<void> _scanImage() async {
    if (_cameraController == null) return;
    try {

      final pictureFile = await _cameraController!.takePicture();
      final file = File(pictureFile.path);
      final navigator = Navigator.of(context);
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );
      final croppedFilePath = File(croppedFile!.path);
      final inputImage = InputImage.fromFile(croppedFilePath);
      final recognizedText = await textRecognizer.processImage(inputImage);
      recognizedText.text.replaceAll('÷', '/');
      if (isMathOperator(recognizedText.text)) {
         _extractMathOperations(recognizedText.text);
      }
      await navigator.push(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              ChatScreen(scannedText: recognizedText.text),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }

  }*/
  bool isMathOperator(String text) {
    final mathOperatorSet = {'+', '-', '*', '/', '√', '^', '÷'};
    for (String operator in mathOperatorSet) {
      if (text.contains(operator)) {
        return true;
      }
    }
    return false ;
  }

  List<String> _extractMathOperations(String text) {
    final mathOperators = ['+', '-', '*', '/', '^', '÷'];
    final operations = <String>[];
    for (String line in text.split('\n')) {
      for (String word in line.split(' ')) {
        if (mathOperators.contains(word) || word.contains(r'\d+')) {
          operations.add(word);
        }
      }
    }
    return operations;
  }
}
