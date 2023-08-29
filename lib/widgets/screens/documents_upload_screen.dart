import 'dart:typed_data';
import 'package:bizfra/bloc/registration_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:bizfra/models/documents_model.dart';
import 'package:bizfra/validation/FieldValidator.dart';
import 'package:bizfra/widgets/fileupload/file_upload_widget.dart';
import 'package:bizfra/widgets/textfield/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/registration_bloc.dart';
import '../../bloc/registration_event.dart';
import '../buttons/back_button_widget.dart';
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
  String aadharFileName ="";
  String panFileName ="";
  String  gstFileName = "";
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
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
      if (state is BusinessRegistrationState) {
        _setDefaultValues(state);
      }
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
                    onValidate: FieldValidator.validateAadharNumber,
                    savedText: widget.aadharNumber)),
            FileUploadWidget(onUploadSuccess: _updateAadharByteArray, selectedFile: widget.aadharData!=null ? PlatformFile(bytes: widget.aadharData, name: widget.aadharFileName, size: widget.aadharData.elementSizeInBytes) : null),
            ContainerWidget(
                widget: TextFieldWidget(
                    hintText: "Business PAN Number",
                    iconData: Icons.numbers_sharp,
                    isMandatory: true,
                    onChange: _updatePAN,
                    onValidate: FieldValidator.validatePanNumber, savedText: widget.panNumber)),
            FileUploadWidget(onUploadSuccess: _updatePANByteArray, selectedFile: widget.panData !=null ? PlatformFile(bytes: widget.panData, name: widget.panFileName, size: widget.panData.elementSizeInBytes) : null),
            ContainerWidget(
                widget: TextFieldWidget(
                    hintText: "GST Registration Number",
                    iconData: Icons.numbers_sharp,
                    isMandatory: false,
                    onChange: _updateGST,
                    onValidate: FieldValidator.validateGstNumber,  savedText: widget.gstNumber)),
            FileUploadWidget(onUploadSuccess: _updateGSTByteArray, selectedFile: widget.gstData!=null? PlatformFile(bytes: widget.gstData, name: widget.gstFileName, size: widget.gstData.elementSizeInBytes) : null),
          ]))),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // BackButtonWidget(onPressed: navigateBack),

                BackButtonWidget(onPressed: () {
                  Navigator.of(context).pop();
                }),
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
                      gstFileType: widget.gstFileType,
                      aadharFileName: widget.aadharFileName,
                      panFileName: widget.panFileName,
                      gstFileName: widget.gstFileName);
                  registrationBloc.add(DocumentSubmittedEvent(documentModel));
                  registrationBloc.add(SummaryDetailsUpdatedEvent());
                  Navigator.pushNamed(context, '/photoUpload');
                })
              ],
            ),
          ));
    });
  }

  void _updateAadharNumber(String newValue) {
    widget.aadharNumber = newValue;
  }

  void _updateAadharByteArray(Uint8List? data, FileType fileType, String fileName) {
    widget.aadharData = data!;
    widget.aadharFileType = fileType;
    widget.aadharFileName = fileName;
  }

  void _updatePAN(String newValue) {
    widget.panNumber = newValue;
  }

  void _updatePANByteArray(Uint8List? data, FileType fileType,String fileName) {
    widget.panData = data!;
    widget.panFileType = fileType;
    widget.panFileName = fileName;
  }

  void _updateGST(String newValue) {
    widget.gstNumber = newValue;
  }

  void _updateGSTByteArray(Uint8List? data, FileType fileType, String fileName) {
    widget.gstData = data!;
    widget.gstFileType = fileType;
    widget.gstFileName = fileName;
  }

  void _setDefaultValues(BusinessRegistrationState state) {
    widget.aadharNumber = state.documents!.aadharNumber;
    widget.panNumber = state.documents!.panNumber;
    widget.gstNumber = state.documents!.gstNumber;
    widget.aadharData = state.documents!.aadharData;
    widget.panData = state.documents!.panData;
    widget.gstData = state.documents!.gstData;
    widget.aadharFileType = state.documents!.aadharFileType;
    widget.panFileType = state.documents!.panFileType;
    widget.gstFileType = state.documents!.gstFileType;
  }
}
