import 'package:bizfra/helper/ImageHelper.dart';
import 'package:bizfra/helper/ModelHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/registration_bloc.dart';
import '../../bloc/registration_state.dart';
import '../../helper/DataTableHelper.dart';
import '../../helper/EventHelper.dart';
import '../buttons/back_button_widget.dart';
import '../buttons/submit_button_widget.dart';
import '../header/header_title_padding_widget.dart';
import '../header/header_widget.dart';
import '../navigation/nav_bar_widget.dart';

class SummaryDetailsScreenWidget extends StatefulWidget {
  SummaryDetailsScreenWidget(RegistrationBloc registrationBloc, {super.key});

  @override
  _SummaryDetailsScreenWidgetState createState() =>
      _SummaryDetailsScreenWidgetState();
}

class _SummaryDetailsScreenWidgetState
    extends State<SummaryDetailsScreenWidget> {
  @override
  Widget build(BuildContext context) {
    final registrationBloc = BlocProvider.of<RegistrationBloc>(context);
    ModelHelper modelHelper = ModelHelper();
    // appBar: HeaderWidget(),
    body:
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
      if (state is BusinessRegistrationState) {
        modelHelper.populateUserModelFromState(state);
      }
      return Scaffold(
          appBar: const HeaderWidget(),
          body: SingleChildScrollView(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  const HeaderTitlePaddingWidget(
                      headerTitle: 'Summary Details'),
                  ImageHelper.buildImageBox(modelHelper.photoModel?.photoData),
                  DataTable(
                    columns: [
                      DataTableHelper.buildDataColumn("Field"),
                      DataTableHelper.buildDataColumn("Details")
                    ],
                    rows: [
                      DataTableHelper.buildDataRow(
                          'First Name', modelHelper.userModel!.firstName),
                      DataTableHelper.buildDataRow(
                          'Last Name', modelHelper.userModel!.lastName),
                      DataTableHelper.buildDataRow(
                          'Date of Birth', modelHelper.userModel!.dob),
                      DataTableHelper.buildDataRow(
                          'Email', modelHelper.userModel!.email),
                      DataTableHelper.buildDataRow(
                          'Mobile', modelHelper.userModel!.mobile),
                      DataTableHelper.buildDataRow('Organization Name',
                          modelHelper.businessModel!.orgName),
                      DataTableHelper.buildDataRow('Organization Type',
                          modelHelper.businessModel!.orgType),
                      DataTableHelper.buildDataRow('Business Expertise',
                          modelHelper.businessModel!.expertise),
                      DataTableHelper.buildDataRow('Registered Address',
                          modelHelper.businessModel!.address),
                      DataTableHelper.buildDataRow(
                          'Website', modelHelper.businessModel!.website),
                      DataTableHelper.buildDataRow('Number of Branches',
                          modelHelper.businessModel!.branches),
                      DataTableHelper.buildDataRow('Aadhar Number',
                          modelHelper.documentsModel!.aadharNumber),
                      DataTableHelper.buildDataRow(
                          'Pan Number', modelHelper.documentsModel!.panNumber),
                      DataTableHelper.buildDataRow(
                          'GST Number', modelHelper.documentsModel!.gstNumber),
                      DataTableHelper.buildDataRowForImage('Aadhar Image',
                          modelHelper.documentsModel?.aadharFile),
                      DataTableHelper.buildDataRowForImage(
                          'PAN Image', modelHelper.documentsModel?.panFile),
                      DataTableHelper.buildDataRowForImage(
                          'GST Image', modelHelper.documentsModel?.gstFile)
                    ],
                  ),
                ])),
          ),
          bottomNavigationBar:
              BottomNavBarWidget(backButtonWidget: BackButtonWidget(
            onButtonClicked: () {
              EventHelper.summaryScreenBackButtonClicked(context);
            },
          ), nextButtonWidget: SubmitButtonWidget(onButtonClicked: () {
            EventHelper.summaryScreenSubmitButtonClicked(
                registrationBloc, context, widget);
          })));
    });
  }
}
