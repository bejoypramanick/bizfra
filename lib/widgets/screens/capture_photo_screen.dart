import 'dart:io';
import 'dart:typed_data';

import 'package:bizfra/bloc/registration_event.dart';
import 'package:bizfra/models/photo_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/registration_bloc.dart';
import '../../bloc/registration_state.dart';
import '../../helper/EventHelper.dart';
import '../buttons/back_button_widget.dart';
import '../buttons/camera_button_widget.dart';
import '../buttons/next_button_widget.dart';
import '../navigation/nav_bar_widget.dart';

class CameraWidget extends StatefulWidget {
  CameraWidget(RegistrationBloc registrationBloc, {super.key});

  Uint8List photoData = Uint8List(0);
  bool isPhotoClicked = false;
  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera

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
        widget.photoData = pictureBytes;
        widget.isPhotoClicked = true;
        setState(() {

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
      if (state is BusinessRegistrationState && widget.isPhotoClicked == false ) {

          widget.photoData = state.photoModel?.photoData ??  Uint8List(0);

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
                  padding: EdgeInsets.all(30),
                  child: controller == null
                      ? Center(child: Text("Loading Camera..."))
                      : !controller!.value.isInitialized
                          ? Center(child: CircularProgressIndicator())
                          : CameraPreview(controller!),
                ),
                CameraButtonWidget(onPressed: takePicture),
                Container(
                  padding: EdgeInsets.all(30),
                  child: widget.photoData != null
                    ? Image.memory(widget.photoData, height: 300)
                    : Text("No Photo"),
                )
              ],
            ),
          ),
        ),

          bottomNavigationBar:
          BottomNavBarWidget(backButtonWidget: BackButtonWidget(
            onButtonClicked: () {
              EventHelper.photoScreenBackButtonClicked(context);
            },
          ), nextButtonWidget: NextButtonWidget(onButtonClicked: () {
            EventHelper.photoScreenNextButtonClicked(
                registrationBloc, context, widget);
          })));

    });
  }


}
