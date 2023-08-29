import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:bizfra/models/documents_model.dart';
import 'package:bizfra/validation/FieldValidator.dart';
import 'package:bizfra/widgets/fileupload/file_upload_widget.dart';
import 'package:bizfra/widgets/textfield/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/registration_bloc.dart';
import '../../bloc/registration_event.dart';
import '../buttons/next_button_widget.dart';
import '../container/container_widget.dart';
import '../header/header_title_padding_widget.dart';

class DocumentUploadScreenWidget extends StatefulWidget {
  DocumentUploadScreenWidget(RegistrationBloc registrationBloc, {super.key});

  String aadharNumber = '';
  String panNumber = '';
  String gstNumber = '';
  Uint8List aadharData = Uint8List(0);
  Uint8List panData = Uint8List(0);
  Uint8List gstData = Uint8List(0);
  FileType aadharFileType = FileType.any;
  FileType panFileType = FileType.any;
  FileType gstFileType = FileType.any;

  @override
  _DocumentUploadScreenWidgetState createState() =>
      _DocumentUploadScreenWidgetState();
}

class _DocumentUploadScreenWidgetState
    extends State<DocumentUploadScreenWidget> {
  @override
  Widget build(BuildContext context) {
    final registrationBloc = BlocProvider.of<RegistrationBloc>(context);
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
                child: Column(children: [
          const HeaderTitlePaddingWidget(headerTitle: 'Document Upload'),
          ContainerWidget(
              widget: TextFieldWidget(
                  hintText: "Aadhar Number",
                  iconData: Icons.numbers_sharp,
                  isMandatory: true,
                  onChange: _updateAadharNumber,
                  onValidate: FieldValidator.validateAadharNumber)),
          FileUploadWidget(onUploadSuccess: _updateAadharByteArray),
          ContainerWidget(
              widget: TextFieldWidget(
                  hintText: "Business PAN Number",
                  iconData: Icons.numbers_sharp,
                  isMandatory: true,
                  onChange: _updatePAN,
                  onValidate: FieldValidator.validatePanNumber)),
          FileUploadWidget(onUploadSuccess: _updatePANByteArray),
          ContainerWidget(
              widget: TextFieldWidget(
                  hintText: "GST Registration Number",
                  iconData: Icons.numbers_sharp,
                  isMandatory: false,
                  onChange: _updateGST,
                  onValidate: FieldValidator.validateGstNumber)),
          FileUploadWidget(onUploadSuccess: _updateGSTByteArray),
        ]))),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // BackButtonWidget(onPressed: navigateBack),
              NextButtonWidget(onPressed: () {
                DocumentsModel documentModel = DocumentsModel(
                    aadharNumber: widget.aadharNumber,
                    panNumber: widget.panNumber,
                    gstNumber: widget.gstNumber,
                    aadharData: widget.aadharData,
                    panData: widget.panData,
                    gstData: widget.gstData,
                    aadharFileType: widget.aadharFileType,
                    panFileType: widget.panFileType,
                    gstFileType: widget.gstFileType);
                registrationBloc.add(DocumentSubmittedEvent(documentModel));
                Navigator.pushNamed(context, '/photoUpload');
              })
            ],
          ),
        ));
  }

  void _updateAadharNumber(String newValue) {
    widget.aadharNumber = newValue;
  }

  void _updateAadharByteArray(Uint8List? data, FileType fileType) {
    widget.aadharData = data!;
    widget.aadharFileType = fileType;
  }

  void _updatePAN(String newValue) {
    widget.panNumber = newValue;
  }

  void _updatePANByteArray(Uint8List? data, FileType fileType) {
    widget.panData = data!;
    widget.panFileType = fileType;
  }

  void _updateGST(String newValue) {
    widget.gstNumber = newValue;
  }

  void _updateGSTByteArray(Uint8List? data, FileType fileType) {
    widget.gstData = data!;
    widget.gstFileType = fileType;
  }
}
