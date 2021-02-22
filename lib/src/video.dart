import 'package:camera/camera.dart';
import 'package:educa/model/storage.dart';
import 'package:educa/src/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Video extends StatefulWidget {
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  List<CameraDescription> _cameras;
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  bool isCameraReady = false;
  bool showCapturedPhoto = false;
  bool _isRecording = false;
  bool enableAudio = true;

  // XFile videoFile;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();

    print(_cameras);

    _controller = CameraController(_cameras.first, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Builder(
            builder: (context) => Stack(
                  children: [
                    /*  Image.asset(
                      'assets/humberto-large.png',
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                    ), */
                    _buildCameraPreview(),

                    Positioned(
                      top: 60,
                      left: 30,
                      child: Container(
                        width: 300,
                        height: 5,
                        child: Slider(
                          min: 0,
                          max: 100,
                          value: 20,
                          activeColor: kEducaBlue,
                          inactiveColor: kEducaWhite,
                          onChanged: (double value) {},
                        ),
                      ),
                    ),

                    // bottom button row
                    Positioned(
                      left: 85,
                      bottom: 81,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 44,
                            padding: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                                color: kEducaBlack.withOpacity(.25),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                )),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.mic_none,
                                size: 34,
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: kEducaBlue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () async {
                                if (_isRecording) {
                                  XFile _file = await onStopButtonPressed();

                                  showBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          EducaBottomSheet(videoFile: _file));
                                } else {
                                  onVideoRecordButtonPressed();
                                }
                              },
                              icon: Icon(_isRecording
                                  ? Icons.videocam_off
                                  : Icons.videocam),
                            ),
                          ),
                          Container(
                            height: 44,
                            padding: const EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                              color: kEducaBlack.withOpacity(.25),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: IconButton(
                              onPressed: _controller != null &&
                                      _controller.value.isRecordingVideo
                                  ? null
                                  : _onCameraSwitch,
                              icon: Icon(
                                Icons.refresh,
                                size: 34,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )));
  }

  _buildCameraPreview() {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return Transform.scale(
              scale: _controller.value.aspectRatio / deviceRatio,
              child: Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: CameraPreview(_controller), //cameraPreview
                ),
              ));
        } else {
          return Center(
              child:
                  CircularProgressIndicator()); // Otherwise, display a loading indicator.
        }
      },
    );
  }

  Future<void> _onCameraSwitch() async {
    final CameraDescription cameraDescription =
        (_controller.description == _cameras[0]) ? _cameras[1] : _cameras[0];

    if (_controller != null) {
      await _controller.dispose();
    }
    _controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: enableAudio,
    );

    _controller.addListener(() {
      if (mounted) setState(() {});
      if (_controller.value.hasError) {
        showInSnackBar('Camera error ${_controller.value.errorDescription}');
      }
    });

    try {
      await _controller.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onVideoRecordButtonPressed() {
    startVideoRecording().then((_) {
      if (mounted) setState(() => _isRecording = true);
    });
  }

  Future<XFile> onStopButtonPressed() async {
    final _file = await stopVideoRecording();

    if (mounted) setState(() => _isRecording = false);

    return _file;
  }

  Future<void> startVideoRecording() async {
    if (!_controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return;
    }

    if (_controller.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      await _controller.startVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  Future<XFile> stopVideoRecording() async {
    if (!_controller.value.isRecordingVideo) {
      return null;
    }

    try {
      return await _controller.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  void logError(String code, String message) =>
      print('Error: $code\nError Message: $message');
}

//
//
//
class EducaBottomSheet extends StatefulWidget {
  EducaBottomSheet({
    Key key,
    @required this.videoFile,
  }) : super(key: key);

  final XFile videoFile;

  @override
  _EducaBottomSheetState createState() => _EducaBottomSheetState();
}

class _EducaBottomSheetState extends State<EducaBottomSheet> {
  final _titleController = TextEditingController();

  final _topicController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _titleController.dispose();
    _topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 38),
      height: 455,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 28),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text('Retake', style: textTheme.headline3)),
          ),
          SizedBox(height: 19),
          Text('Topic', style: textTheme.bodyText1.copyWith(color: kEducaBlue)),
          SizedBox(height: 6),
          TextFormField(
            controller: _titleController,
            // initialValue: 'Biology Basics',
            decoration: InputDecoration(hintText: 'Biology Basics'),
            style: textTheme.headline3,
          ),
          SizedBox(height: 23),
          Text('Title', style: textTheme.bodyText1.copyWith(color: kEducaBlue)),
          SizedBox(height: 6),
          TextFormField(
            controller: _topicController,
            style: textTheme.headline3,
            decoration: InputDecoration(
              hintText: 'Biology & Scientific Methodologies',
            ),
          ),
          Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            width: double.infinity,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                onPressed: () {
                  String title = _titleController.text;
                  String topic = _topicController.text;

                  context.read<StorageProvider>().store(
                      videofile: widget.videoFile, title: title, topic: topic);

                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'Upload',
                  style: textTheme.headline3.copyWith(color: kEducaWhite),
                ),
              ),
            ),
          ),
          SizedBox(height: 87),
        ],
      ),
    );
  }
}
