import 'dart:io';
import 'dart:typed_data';

import 'package:bizfra/bloc/registration_event.dart';
import 'package:bizfra/models/photo_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/registration_bloc.dart';
import '../../bloc/registration_state.dart';
import '../buttons/back_button_widget.dart';
import '../buttons/next_button_widget.dart';

class CameraWidget extends StatefulWidget {
  CameraWidget(RegistrationBloc registrationBloc, {super.key});

  Uint8List photoData = Uint8List(0);

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for captured image

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      for (CameraDescription camera in cameras!) {
        if (camera.lensDirection == CameraLensDirection.front ||
            camera.lensDirection == CameraLensDirection.external) {
          controller = CameraController(camera, ResolutionPreset.max);
          await controller!.initialize();
          setState(() {});
          break;
        }
      }
    } else {
      print("No cameras found");
    }
  }

  Future<void> takePicture() async {
    try {
      if (controller != null && controller!.value.isInitialized) {
        final XFile picture = await controller!.takePicture();
        // final Uint8List pictureBytes = await  File(picture.path).readAsBytes();
        final Uint8List pictureBytes = await picture.readAsBytes();
        print(
            "Picture captured: ${picture.path}"); // Debugging: Check the picture path
        setState(() {
          image = picture;
          widget.photoData = pictureBytes;
        });
      }
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final registrationBloc = BlocProvider.of<RegistrationBloc>(context);

    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
      if (state is SummaryState) {
        _setDefaultValues(state);
      }
      return Scaffold(
        appBar: AppBar(
          title: Text('Take Picture'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 400,
                  width: 400,
                  child: controller == null
                      ? Center(child: Text("Loading Camera..."))
                      : !controller!.value.isInitialized
                          ? Center(child: CircularProgressIndicator())
                          : CameraPreview(controller!),
                ),
                ElevatedButton.icon(
                  onPressed: takePicture,
                  icon: Icon(Icons.camera),
                  label: Text("Capture"),
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  child: widget.photoData != null
                      ? Image.memory(widget.photoData, height: 300)
                      : Text("No image captured"),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BackButtonWidget(onPressed: () {
                Navigator.of(context).pop();
              }),
              NextButtonWidget(onPressed: () {
                final photoModel = PhotoModel(photoData: widget.photoData);
                registrationBloc.add(PhotoTakenEvent(photoModel));
                registrationBloc.add(SummaryDetailsUpdatedEvent());
                Navigator.pushNamed(context, '/summaryDetails');
              })
            ],
          ),
        ),
      );
    });
  }

  void _setDefaultValues(SummaryState state) {
    widget.photoData = state.photoModel.photoData;
  }
}
