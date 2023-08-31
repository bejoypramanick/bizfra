import 'package:bizfra/bloc/registration_state.dart';
import 'package:bizfra/validation/FieldValidator.dart';
import 'package:bizfra/widgets/fileupload/file_upload_widget.dart';
import 'package:bizfra/widgets/textfield/text_field_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/registration_bloc.dart';
import '../../helper/EventHelper.dart';
import '../buttons/back_button_widget.dart';
import '../buttons/next_button_widget.dart';
import '../container/container_widget.dart';
import '../container/text_field_container_widget.dart';
import '../header/header_title_padding_widget.dart';
import '../header/header_widget.dart';
import '../navigation/nav_bar_widget.dart';

class IdScreenWidget extends StatefulWidget {
  IdScreenWidget(RegistrationBloc registrationBloc, {super.key});

  String aadharNumber = '';
  String panNumber = '';
  String gstNumber = '';


  @override
  _IdScreenWidgetState createState() =>
      _IdScreenWidgetState();
}

class _IdScreenWidgetState
    extends State<IdScreenWidget> {
  @override
  Widget build(BuildContext context) {
    final registrationBloc = BlocProvider.of<RegistrationBloc>(context);
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          if (state is BusinessRegistrationState) {
            _setDefaultValues(state);
          }
          return Scaffold(
              appBar: const HeaderWidget(),
              body: Center(
                  child: SingleChildScrollView(
                      child: Column(children: [
                        const HeaderTitlePaddingWidget(headerTitle: 'Identification'),
                        TextFieldContainerWidget(
                            hintText: "Aadhar Number",
                            iconData: Icons.numbers_sharp,
                            isMandatory: true,
                            onChange: _updateAadharNumber,
                            onValidate: FieldValidator.validateAadharNumber,
                            savedText: widget.aadharNumber),

                        TextFieldContainerWidget(
                            hintText: "Business PAN Number",
                            iconData: Icons.numbers_sharp,
                            isMandatory: true,
                            onChange: _updatePAN,
                            onValidate: FieldValidator.validatePanNumber,
                            savedText: widget.panNumber),

                        TextFieldContainerWidget(
                            hintText: "GST Registration Number",
                            iconData: Icons.numbers_sharp,
                            isMandatory: false,
                            onChange: _updateGST,
                            onValidate: FieldValidator.validateGstNumber,
                            savedText: widget.gstNumber),

                      ]
                      )
                  )
              ),
              bottomNavigationBar:
              BottomNavBarWidget(backButtonWidget: BackButtonWidget(
                onButtonClicked: () {
                  EventHelper.idScreenBackButtonClicked(context);
                },
              ), nextButtonWidget: NextButtonWidget(onButtonClicked: () {
                EventHelper.idScreenNextButtonClicked(
                    registrationBloc, context, widget);
              })));
        });
  }

  void _updateAadharNumber(String newValue) {
    widget.aadharNumber = newValue;
  }

  void _updatePAN(String newValue) {
    widget.panNumber = newValue;
  }

  void _updateGST(String newValue) {
    widget.gstNumber = newValue;
  }


  void _setDefaultValues(BusinessRegistrationState state) {
    widget.aadharNumber = state.documents?.aadharNumber ?? "";
    widget.panNumber = state.documents?.panNumber ?? "";
    widget.gstNumber = state.documents?.gstNumber ?? "";
  }
}
