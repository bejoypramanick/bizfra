import 'package:bizfra/helper/ImageHelper.dart';
import 'package:bizfra/helper/ModelHelper.dart';
import 'package:bizfra/models/registration_model.dart';
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
    RegistrationModel registrationModel;
    // appBar: HeaderWidget(),
    body:
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
      if (state is BusinessRegistrationState) {
          modelHelper.populateRegistrationModelFromState(state);
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
                  ImageHelper.buildImageBox(modelHelper.registrationModel?.photoModel?.photoData),
                  DataTable(
                    columns: [
                      DataTableHelper.buildDataColumn("Field"),
                      DataTableHelper.buildDataColumn("Details")
                    ],
                    rows: [
                      DataTableHelper.buildDataRow(
                          'First Name', modelHelper.registrationModel?.user?.firstName),
                      DataTableHelper.buildDataRow(
                          'Last Name', modelHelper.registrationModel?.user?.lastName),
                      DataTableHelper.buildDataRow(
                          'Date of Birth', modelHelper.registrationModel?.user?.dob),
                      DataTableHelper.buildDataRow(
                          'Email', modelHelper.registrationModel?.user?.email),
                      DataTableHelper.buildDataRow(
                          'Mobile', modelHelper.registrationModel?.user?.mobile),
                      DataTableHelper.buildDataRow('Organization Name',
                          modelHelper.registrationModel?.business?.orgName),
                      DataTableHelper.buildDataRow('Organization Type',
                          modelHelper.registrationModel?.business?.orgType),
                      DataTableHelper.buildDataRow('Business Expertise',
                          modelHelper.registrationModel?.business?.expertise),
                      DataTableHelper.buildDataRow('Registered Address',
                          modelHelper.registrationModel?.business?.address),
                      DataTableHelper.buildDataRow(
                          'Website', modelHelper.registrationModel?.business?.website),
                      DataTableHelper.buildDataRow('Number of Branches',
                          modelHelper.registrationModel?.business?.branches),
                      DataTableHelper.buildDataRow('Aadhar Number',
                          modelHelper.registrationModel?.idModel?.aadharNumber),
                      DataTableHelper.buildDataRow(
                          'Pan Number', modelHelper.registrationModel?.idModel?.panNumber),
                      DataTableHelper.buildDataRow(
                          'GST Number', modelHelper.registrationModel?.idModel?.gstNumber),
             /*         DataTableHelper.buildDataRowForImage('Aadhar Image',
                          modelHelper.documentsModel?.aadharFile),
                      DataTableHelper.buildDataRowForImage(
                          'PAN Image', modelHelper.documentsModel?.panFile),
                      DataTableHelper.buildDataRowForImage(
                          'GST Image', modelHelper.documentsModel?.gstFile),*/
                      DataTableHelper.buildTermsCheckbox()

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
                modelHelper.registrationModel!, context, widget);
          })));
    });
  }
}
