import 'package:bizfra/bloc/registration_event.dart';
import 'package:bizfra/models/business_model.dart';
import 'package:bizfra/models/user_model.dart';
import 'package:bizfra/widgets/autocomplete_txt_widget/AutoCompleteTextWidget.dart';
import 'package:bizfra/widgets/textfield/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/registration_bloc.dart';
import '../../bloc/registration_state.dart';
import '../../data/business_expertise.dart';
import '../../data/organization_types.dart';
import '../../validation/FieldValidator.dart';
import '../buttons/back_button_widget.dart';
import '../buttons/next_button_widget.dart';
import '../container/container_widget.dart';
import '../header/header_title_padding_widget.dart';

class BusinessDetailsScreenWidget extends StatefulWidget {
  BusinessDetailsScreenWidget(registrationBloc, {super.key});

  String orgName = '';
  String orgType = '';
  String expertise = '';
  String address = '';
  String noOfbranches = '1';
  String website = '';
  UserModel? userModel;

  @override
  _BusinessDetailsScreenWidgetState createState() =>
      _BusinessDetailsScreenWidgetState();
}

class _BusinessDetailsScreenWidgetState
    extends State<BusinessDetailsScreenWidget> {
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
            const HeaderTitlePaddingWidget(headerTitle: 'Business Details'),
            ContainerWidget(
                widget: TextFieldWidget(
                    hintText: "Organization Name",
                    iconData: Icons.business_sharp,
                    isMandatory: true,
                    onChange: _updateOrgName,
                    onValidate: FieldValidator.validateOrgNm,
                    savedText: widget.orgName)),
            ContainerWidget(
                widget: AutoCompleteTextFieldWidget(
                    iconData: Icons.business_sharp,
                    isMandatory: true,
                    suggestions: org_type_suggestions,
                    hint: 'Organization Type',
                    onChange: _updateOrgType,
                    savedText: widget.orgType)),
            ContainerWidget(
                widget: AutoCompleteTextFieldWidget(
                    iconData: Icons.business_sharp,
                    isMandatory: true,
                    suggestions: biz_expertise_suggestions,
                    hint: 'Business Expertise',
                    onChange: _updateExpertise,
                    savedText: widget.expertise)),
            ContainerWidget(
                widget: TextFieldWidget(
                    hintText: "Registered Address",
                    iconData: Icons.home,
                    isMandatory: true,
                    onChange: _updateAddress,
                    onValidate: FieldValidator.validateAddress,
                    savedText: widget.address)),
            ContainerWidget(
                widget: TextFieldWidget(
                    hintText: "Website",
                    iconData: Icons.web,
                    isMandatory: true,
                    onChange: _updateWebsite,
                    onValidate: FieldValidator.validateWebsite,
                    savedText: widget.website)),
            ContainerWidget(
                widget: TextFieldWidget(
                    hintText: "Number of Branches",
                    iconData: Icons.numbers,
                    isMandatory: true,
                    onChange: _updatenumbranches,
                    onValidate: FieldValidator.validateBranches,
                    savedText: widget.noOfbranches))
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
                  BusinessModel businessModel = BusinessModel(
                      orgName: widget.orgName,
                      orgType: widget.orgType,
                      expertise: widget.expertise,
                      address: widget.address,
                      branches: widget.noOfbranches,
                      website: widget.website);
                  registrationBloc.add(BusinessSubmittedEvent(businessModel));
                  Navigator.pushNamed(context, '/documentsUpload');
                })
              ],
            ),
          ));
    });
  }

  void _updateOrgName(String newValue) {
    widget.orgName = newValue;
  }

  void _updateOrgType(String newValue) {
    widget.orgType = newValue;
  }

  void _updateExpertise(String newValue) {
    widget.expertise = newValue;
  }

  void _updateAddress(String newValue) {
    widget.address = newValue;
  }

  void _updatenumbranches(String newValue) {
    widget.noOfbranches = newValue;
  }

  void _updateWebsite(String newValue) {
    widget.website = newValue;
  }

  void _setDefaultValues(BusinessRegistrationState state) {
    widget.orgName = state.business!.orgName;
    widget.orgType = state.business!.orgType;
    widget.expertise = state.business!.expertise;
    widget.address = state.business!.address;
    widget.noOfbranches = state.business!.branches;
    widget.website = state.business!.website;
  }
}
