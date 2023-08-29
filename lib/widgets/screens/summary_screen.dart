import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../bloc/registration_bloc.dart';
import '../../bloc/registration_state.dart';
import '../../models/documents_model.dart';
import '../buttons/back_button_widget.dart';
import '../buttons/next_button_widget.dart';
import '../buttons/submit_button_widget.dart';
import '../header/header_title_padding_widget.dart';

class SummaryDetailsScreenWidget extends StatelessWidget {
  SummaryDetailsScreenWidget(RegistrationBloc registrationBloc, {super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: HeaderWidget(),

      body: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (context, state) {
        if (state is BusinessRegistrationState) {
          body:
          return SingleChildScrollView( child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                const HeaderTitlePaddingWidget(headerTitle: 'Summary Details'),
                SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.memory(state!.photoModel!.photoData,
                        fit: BoxFit.fill)),

                    DataTable(
                  columns: const [
                    DataColumn(
                        label: Text('Field',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Details',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)))
                  ],
                  rows: [
                    DataRow(cells: [
                      const DataCell(Text('First Name')),
                      DataCell(Text(state!.user!.firstName)),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Last Name')),
                      DataCell(Text(state!.user!.lastName)),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Date of Birth')),
                      DataCell(Text(state!.user!.dob)),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Email')),
                      DataCell(Text(state!.user!.email)),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Mobile')),
                      DataCell(Text(state!.user!.mobile)),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Organization Name')),
                      DataCell(Text(state!.business!.orgName)),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Organization Type')),
                      DataCell(Text(state!.business!.orgType)),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Business Expertise')),
                      DataCell(Text(state!.business!.expertise)),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Registered Address')),
                      DataCell(Text(state!.business!.address)),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Website')),
                      DataCell(Text(state!.business!.website)),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Number of Branches')),
                      DataCell(Text(state!.business!.branches)),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Aadhar Number')),
                      DataCell(Text(state!.documents!.aadharNumber)),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Pan Number')),
                      DataCell(Text(state!.documents!.panNumber)),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('GST Number')),
                      DataCell(Text(state!.documents!.gstNumber)),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Aadhar Image')),
                      DataCell(Container(
                          constraints: const BoxConstraints(
                              maxWidth: 200, maxHeight: 200),
                          child: state!.documents!.aadharFileType ==
                                  FileType.custom
                              ? PDFView(pdfData: state!.documents!.aadharData)
                              : Image.memory(state!.documents!.aadharData,
                                  fit: BoxFit.fill))),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('PAN Image')),
                      DataCell(Container(
                          constraints: const BoxConstraints(
                              maxWidth: 200, maxHeight: 200),
                          child: state!.documents!.panFileType == FileType.custom
                              ? PDFView(pdfData: state!.documents!.panData)
                              : Image.memory(state!.documents!.panData,
                                  fit: BoxFit.fill))),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('GST Image')),
                      DataCell(Container(
                          constraints: const BoxConstraints(
                              maxWidth: 200, maxHeight: 200),
                          child: state!.documents!.gstFileType == FileType.custom
                              ? PDFView(pdfData: state!.documents!.gstData)
                              : Image.memory(state!.documents!.gstData,
                                  fit: BoxFit.fill))),
                    ]),
                  ],
                ),

              ])));
        } else {
          return ListView(children: const <Widget>[]);
        }

      }),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // BackButtonWidget(onPressed: navigateBack),
              BackButtonWidget(onPressed: (){
                Navigator.of(context).pop();
              }),
              SubmitButtonWidget(onPressed: () {


              })

            ],
          ),
        )
    );
  }
}
