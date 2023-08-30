import 'package:bizfra/models/user_model.dart';
import 'package:bizfra/widgets/autocomplete_txt_widget/AutoCompleteTextWidget.dart';
import 'package:bizfra/widgets/container/autocomplete_container_widget.dart';
import 'package:bizfra/widgets/textfield/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/registration_bloc.dart';
import '../../bloc/registration_state.dart';
import '../../data/business_expertise.dart';
import '../../data/organization_types.dart';
import '../../helper/EventHelper.dart';
import '../../validation/FieldValidator.dart';
import '../buttons/back_button_widget.dart';
import '../buttons/next_button_widget.dart';
import '../container/container_widget.dart';
import '../container/text_field_container_widget.dart';
import '../header/header_title_padding_widget.dart';
import '../header/header_widget.dart';
import '../navigation/nav_bar_widget.dart';

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
          appBar: const HeaderWidget(),
          body: Center(
              child: SingleChildScrollView(
                  child: Column(children: [
            const HeaderTitlePaddingWidget(headerTitle: 'Business Details'),
            TextFieldContainerWidget(
                hintText: "Organization Name",
                iconData: Icons.business_sharp,
                isMandatory: true,
                onChange: _updateOrgName,
                onValidate: FieldValidator.validateOrgNm,
                savedText: widget.orgName),
            AutoCompleteTextFieldContainerWidget(
                iconData: Icons.business_sharp,
                isMandatory: true,
                suggestions: org_type_suggestions,
                hint: 'Organization Type',
                onChange: _updateOrgType,
                savedText: widget.orgType),
            AutoCompleteTextFieldContainerWidget(
                iconData: Icons.business_sharp,
                isMandatory: true,
                suggestions: biz_expertise_suggestions,
                hint: 'Business Expertise',
                onChange: _updateExpertise,
                savedText: widget.expertise),
            TextFieldContainerWidget(
                hintText: "Registered Address",
                iconData: Icons.home,
                isMandatory: true,
                onChange: _updateAddress,
                onValidate: FieldValidator.validateAddress,
                savedText: widget.address),
            TextFieldContainerWidget(
                hintText: "Website",
                iconData: Icons.web,
                isMandatory: true,
                onChange: _updateWebsite,
                onValidate: FieldValidator.validateWebsite,
                savedText: widget.website),
            TextFieldContainerWidget(
                hintText: "Number of Branches",
                iconData: Icons.numbers,
                isMandatory: true,
                onChange: _updatenumbranches,
                onValidate: FieldValidator.validateBranches,
                savedText: widget.noOfbranches)
          ]))),
          bottomNavigationBar:
              BottomNavBarWidget(backButtonWidget: BackButtonWidget(
            onButtonClicked: () {
              EventHelper.businessScreenBackButtonClicked(context);
            },
          ), nextButtonWidget: NextButtonWidget(onButtonClicked: () {
            EventHelper.businessScreenNextButtonClicked(
                registrationBloc, context, widget);
          })));
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
    widget.orgName = state.business?.orgName ?? "";
    widget.orgType = state.business?.orgType ?? "";
    widget.expertise = state.business?.expertise ?? "";
    widget.address = state.business?.address ?? "";
    widget.noOfbranches = state.business?.branches ?? "";
    widget.website = state.business?.website ?? "";
  }
}
