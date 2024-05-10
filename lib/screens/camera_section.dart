import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tflite/tflite.dart';
import 'package:ui_sensemo/main.dart';
import 'package:ui_sensemo/screens/home_screen.dart';
import 'package:video_player/video_player.dart';

class PhoneCamera extends StatefulWidget {
  const PhoneCamera({super.key});

  @override
  State<PhoneCamera> createState() => _PhoneCameraState();
}

class _PhoneCameraState extends State<PhoneCamera> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';

@override
  void initState() {
    super.initState();
    loadmodel();
  }

  @override
  void dispose() {
    // Release camera resources
    cameraController?.stopImageStream();
    cameraController?.dispose();
    // Close TFLite model
    Tflite.close();
    super.dispose();
  }

  loadmodel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
    loadCamera();
  }

  loadCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await cameraController!.initialize();
    if (mounted) {
      setState(() {});
      cameraController!.startImageStream((imageStream) {
        cameraImage = imageStream;
        runModel();
      });
    }
  }

  runModel() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );
      predictions!.forEach((element) {
        setState(() {
          output = element['label'];
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Live Feed',
            style: TextStyle(color: Color(0xFF00BF62)),
          ),
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Color(0xFF00BF62)),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Live Feed',
            style: TextStyle(color: Color(0xFF00BF62)),
          ),
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Color(0xFF00BF62)),
        ),
        body: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: AspectRatio(
                          aspectRatio: cameraController!.value.aspectRatio,
                          child: CameraPreview(cameraController!),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: Text(
                            output,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Color(0xFF00BF62),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}


class ImageUpload extends StatefulWidget {
  final File? imageFile;

  const ImageUpload({Key? key, required this.imageFile}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  late List<dynamic> _output = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  // Load TFLite model
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  // Run model on the provided image
  runModel(File imageFile) async {
    var output = await Tflite.runModelOnImage(
      path: imageFile.path,
      numResults: 5, // Number of classification results
    );
    setState(() {
      _output = output!;
      _loading = false;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text(
          'Image Uploaded',
          style: TextStyle(color: Color(0xFF00BF62)), // Set text color
        ),
        backgroundColor: Colors.black, // Set the AppBar color to black
        iconTheme: const IconThemeData(color: Color(0xFF00BF62)), // Set icon color
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.black),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.imageFile != null
                  ? Image.file(widget.imageFile!)
                  : const Text('No image selected'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _loading = true;
                  });
                  runModel(widget.imageFile!);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF00BF62)), // Background color
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black), // Text color
                ),
                child: const Text('Process Image'),
              ),
              if (_loading) const CircularProgressIndicator(),
              if (_output.isNotEmpty)
                Column(
                  children: _output.map<Widget>((output) {
                    return Text(
                      '${output['label']} - Confidence: ${(output['confidence'] as double).toStringAsFixed(2)}',
                      style: const TextStyle(color: Color(0xFF00BF62))
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}



class VideoUpload extends StatefulWidget {
  final File videoFile;
  const VideoUpload({Key? key, required this.videoFile}) : super(key: key);

  @override
  State<VideoUpload> createState() => _VideoUploadState();
}

class _VideoUploadState extends State<VideoUpload> {
  String output = '';
  bool _loading = false;
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    loadmodel();
  }

   loadmodel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  // runModel() async {
  // }
  


  @override
  Widget build(BuildContext context) {
    _videoPlayerController = VideoPlayerController.file(widget.videoFile)..initialize().then((_){
    setState((){

    });
    _videoPlayerController!.play();
  });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Video Uploaded',
          style: TextStyle(color: Color(0xFF00BF62)), // Set text color
        ),
        backgroundColor: Colors.black, // Set the AppBar color to black
        iconTheme: const IconThemeData(color: Color(0xFF00BF62)), // Set icon color
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.videoFile != null
                  ?  AspectRatio(aspectRatio: _videoPlayerController!.value.aspectRatio,child: VideoPlayer(_videoPlayerController!),)
                  : const Text("No video selected", style: TextStyle(color: Colors.white),),
              Text(
                output,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color(0xFF00BF62),
                ),
              )
          ],
        ),
    )
    );
  }
}