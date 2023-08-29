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
  PlatformFile? aadharFile;
  PlatformFile? panFile;
  PlatformFile? gstFile;

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
            FileUploadWidget(onUploadSuccess: _updateAadharFile, selectedFile: widget.aadharFile),
            ContainerWidget(
                widget: TextFieldWidget(
                    hintText: "Business PAN Number",
                    iconData: Icons.numbers_sharp,
                    isMandatory: true,
                    onChange: _updatePAN,
                    onValidate: FieldValidator.validatePanNumber, savedText: widget.panNumber)),
            FileUploadWidget(onUploadSuccess: _updatePANFile, selectedFile: widget.panFile),
            ContainerWidget(
                widget: TextFieldWidget(
                    hintText: "GST Registration Number",
                    iconData: Icons.numbers_sharp,
                    isMandatory: false,
                    onChange: _updateGST,
                    onValidate: FieldValidator.validateGstNumber,  savedText: widget.gstNumber)),
            FileUploadWidget(onUploadSuccess: _updateGSTFile, selectedFile: widget.gstFile),
          ]))),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // BackButtonWidget(onPressed: navigateBack),

                BackButtonWidget(onPressed: () {
                 // Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/businessDetails');
                }),
                NextButtonWidget(onPressed: () {
                  DocumentsModel documentModel = DocumentsModel(aadharNumber: widget.aadharNumber, panNumber: widget.panNumber, gstNumber: widget.gstNumber, aadharFile: widget.aadharFile, panFile: widget.panFile, gstFile: widget.gstFile);
                  registrationBloc.add(DocumentSubmittedEvent(documentModel));
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

  void _updateAadharFile(PlatformFile file) {
    widget.aadharFile = file!;
  }

  void _updatePAN(String newValue) {
    widget.panNumber = newValue;
  }

  void _updatePANFile(PlatformFile file) {
    widget.panFile = file!;
  }

  void _updateGST(String newValue) {
    widget.gstNumber = newValue;
  }

  void _updateGSTFile(PlatformFile file) {
    widget.gstFile= file!;

  }

  void _setDefaultValues(BusinessRegistrationState state) {
    widget.aadharNumber = state.documents?.aadharNumber ?? "";
    widget.panNumber = state.documents?.panNumber ?? "";
    widget.gstNumber = state.documents?.gstNumber ?? "";
   widget.aadharFile = state.documents?.aadharFile;
    widget.panFile = state.documents?.panFile;
    widget.gstFile = state.documents?.gstFile;

  }
}
