import 'package:bizfra/widgets/screens/business_details_screen.dart';
import 'package:bizfra/widgets/screens/capture_photo_screen.dart';
import 'package:bizfra/widgets/screens/id_screen_widget.dart';
import 'package:bizfra/widgets/screens/summary_screen.dart';
import 'package:bizfra/widgets/screens/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/registration_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final RegistrationBloc _registrationBloc = RegistrationBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationBloc>(
        create: (context) => _registrationBloc,
        child: MaterialApp(
            initialRoute: '/userDetails', // Start with the user details page
            routes: {
              '/userDetails': (context) =>
                  UserDetailsScreenWidget(_registrationBloc),
              '/businessDetails': (context) =>
                  BusinessDetailsScreenWidget(_registrationBloc),
              '/idUpload': (context) =>
                  IdScreenWidget(_registrationBloc),
            /*  '/documentsUpload': (context) =>
                  DocumentUploadScreenWidget(_registrationBloc),*/
              '/photoUpload': (context) => CameraWidget(_registrationBloc),
              '/summaryDetails': (context) =>
                  SummaryDetailsScreenWidget(_registrationBloc),
              // Add routes for other pages
            }));
  }
}
