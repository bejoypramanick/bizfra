/*import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../bloc/registration_bloc.dart';
import '../../bloc/registration_state.dart';
import '../header/header_title_padding_widget.dart';

class SummaryDetailsScreenWidget extends StatelessWidget {
   SummaryDetailsScreenWidget(RegistrationBloc registrationBloc,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final registrationBloc = BlocProvider.of<RegistrationBloc>(context);
    return Scaffold(
      // appBar: HeaderWidget(),
      body: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          if (state is SummaryState) {
            return SingleChildScrollView(
                child: Column( mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,

                    children: [
               HeaderTitlePaddingWidget(headerTitle: 'Summary Details'),
                Container(
                    width: 200,
                    height: 200,
                    color: Colors.blue,
                    child: Image.memory(state!
                        .photoModel.photoData, fit: BoxFit.fill)),
              Padding(
                  padding:  EdgeInsets.all(40.0),

                  child: Table(

                    border: TableBorder.all(),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                           TableCell(
                               child: Flexible( child: Text('First Name'))),
                          TableCell(
                              child:
                                  Align(  child: Text(state!.user.firstName))),
                        ],
                      ),
                      TableRow(
                        children: [
                           TableCell(
                               child: Flexible( child: Text('Last Name'))),
                          TableCell(
                          child: Flexible( child: Text(state!.user.lastName))),
                        ],
                      ),
                      TableRow(
                        children: [
                           TableCell(
                               child: Flexible( child: Text('Date of Birth'))),
                          TableCell(
                          child: Flexible( child: Text(state!.user.dob))),

                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                      child: Flexible( child: Text('Email'))),
                          TableCell(
                          child: Flexible( child: Text(state!.user.email))),

                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                      child: Flexible( child: Text('Mobile'))),
                          TableCell(
                          child: Flexible( child: Text(state!.user.mobile))),

                        ],
                      ),
                      TableRow(
                        children: [
                           TableCell(
                              child: Flexible( child: Text('Organization Name'))),
                          TableCell(
                              child:
                                  Align(  child: Text(state!.business.orgName))),
                        ],
                      ),
                      TableRow(
                        children: [
                           TableCell(
                      child: Flexible( child: Text('Organization Type'))),

                          TableCell(
                              child:
                                  Align(  child: Text(state!.business.orgType))),
                        ],
                      ),
                      TableRow(
                        children: [
                           TableCell(
                      child: Flexible( child: Text('Business Expertise'))),

                          TableCell(
                              child: Flexible(
                                  child: Text(state!.business.expertise))),
                        ],
                      ),
                      TableRow(
                        children: [
                           TableCell(
                      child: Flexible( child: Text('Registered Address'))),

                          TableCell(
                              child:
                                  Align(  child: Text(state!.business.address))),
                        ],
                      ),
                      TableRow(
                        children: [
                           TableCell(
                               child: Flexible( child: Text('Website'))),
                          TableCell(
                              child:
                                  Align(  child: Text(state!.business.website))),
                        ],
                      ),
                      TableRow(
                        children: [
                           TableCell(
                      child: Flexible( child: Text('Number of Branches'))),

                          TableCell(
                              child: Flexible(
                                  child: Text(state!.business.branches))),
                        ],
                      ),
                      TableRow(
                        children: [
                           TableCell(
                      child: Flexible( child: Text('Aadhar Number'))),

                          TableCell(
                              child: Flexible(
                                  child: Text(state!.documents.aadharNumber))),
                        ],
                      ),
                      TableRow(
                        children: [
                           TableCell(
                               child: Flexible( child: Text('Pan Number'))),
                          TableCell(
                              child: Flexible(
                                  child: Text(state!.documents.panNumber))),
                        ],
                      ),
                      TableRow(
                        children: [
                           TableCell(
                               child: Flexible( child: Text('GST Number'))),
                          TableCell(
                              child: Flexible(
                                  child: Text(state!.documents.gstNumber))),
                        ],
                      ),
                      TableRow(
                        children: [
                           TableCell(
                               child: Flexible( child: Text('Aadhar Image'))),
                          TableCell(
                            child: Container(
                                constraints:  BoxConstraints(
                                    maxWidth: 200, // Set the maximum width
                                    maxHeight: 150),
                                child: Flexible(
                                    child: state!.documents.aadharFileType ==
                                            FileType.custom
                                        ? PDFView(
                                            pdfData:
                                                state!.documents.aadharData)
                                        : Image.memory(state!.documents
                                            .aadharData))), // Set the maximum height
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                           TableCell(
                               child: Flexible( child: Text('PAN Image'))),
                          TableCell(
                            child: Container(
                                constraints:  BoxConstraints(
                                    maxWidth: 200, // Set the maximum width
                                    maxHeight: 150),
                                child: Flexible(
                                    child: state!.documents.panFileType ==
                                            FileType.custom
                                        ? PDFView(
                                            pdfData: state!.documents.panData)
                                        : Image.memory(state!.documents
                                            .panData))), // Set the maximum height
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                           TableCell(
                               child: Flexible( child: Text('GST Image'))),
                          TableCell(
                            child: Container(
                                constraints:  BoxConstraints(
                                    maxWidth: 200, // Set the maximum width
                                    maxHeight: 150),
                                child: Flexible(
                                    child: state!.documents.gstFileType ==
                                            FileType.custom
                                        ? PDFView(
                                            pdfData: state!.documents.gstData)
                                        : Image.memory(state!
                                            .documents.gstData))), // Set the
                          )
                        ],
                      ),
                    ],
                  ))
            ]));

            /*       return ListView(
              children: [
                Text('User Details'),
                Text('${state!.user.firstName} ${state.user.lastName}'),
                Text('${state?.user.email}'),
                Text('${state?.user.mobile}'),
                Text('${state?.user.dob}'),
                Text('Business Details'),
                Text('${state?.business.orgName}'),
                Text('${state?.business.orgType}'),
                Text('${state?.business.expertise}'),
                Text('${state?.business.address}'),
              ],
            );*/
          } else {
            return Center( child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
*/
