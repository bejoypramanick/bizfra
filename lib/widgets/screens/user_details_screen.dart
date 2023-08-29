import 'package:bizfra/bloc/registration_state.dart';
import 'package:bizfra/models/user_model.dart';
import 'package:bizfra/widgets/textfield/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/registration_bloc.dart';
import '../../bloc/registration_event.dart';
import '../../validation/FieldValidator.dart';
import '../buttons/next_button_widget.dart';
import '../calendar/calender_widget.dart';
import '../container/container_widget.dart';
import '../header/header_title_padding_widget.dart';

class UserDetailsScreenWidget extends StatefulWidget {
  UserDetailsScreenWidget(registrationBloc, {super.key});

  String firstName = '';
  String lastName = '';
  String dob = '';
  String email = '';
  String mobile = '';

  @override
  _UserDetailsScreenWidgetState createState() =>
      _UserDetailsScreenWidgetState();
}

class _UserDetailsScreenWidgetState extends State<UserDetailsScreenWidget> {
  @override
  Widget build(BuildContext context) {
    final registrationBloc = BlocProvider.of<RegistrationBloc>(context);
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
      if (state is UserDetailsState) {
        _setDefaultValues(state);
      }
      return Scaffold(
          // appBar: HeaderWidget(),
          body: Center(
              child: SingleChildScrollView(
                  child: Column(children: [
            const HeaderTitlePaddingWidget(headerTitle: 'User Details'),
            ContainerWidget(
                widget: TextFieldWidget(
              hintText: "First Name",
              iconData: Icons.person,
              isMandatory: true,
              onChange: _updateFirstName,
              onValidate: FieldValidator.validateName,
              savedText: widget.firstName,
            )),
            ContainerWidget(
                widget: TextFieldWidget(
                    hintText: "Last Name",
                    iconData: Icons.person,
                    isMandatory: true,
                    onChange: _updateLastName,
                    onValidate: FieldValidator.validateName,
                    savedText: widget.lastName)),
            ContainerWidget(
                widget: CalenderWidget(
              isMandatory: true,
              onChange: _updateDob,
              onValidate: FieldValidator.validateDob,
              savedText: widget.dob,
            )),
            ContainerWidget(
                widget: TextFieldWidget(
                    hintText: "Email",
                    iconData: Icons.email_sharp,
                    isMandatory: false,
                    onChange: _updateEmail,
                    onValidate: FieldValidator.validateEmail,
                    savedText: widget.email)),
            ContainerWidget(
                widget: TextFieldWidget(
                    hintText: "Mobile",
                    iconData: Icons.phone_android_sharp,
                    isMandatory: true,
                    onChange: _updateMobile,
                    onValidate: FieldValidator.validateMobile,
                    savedText: widget.mobile))
          ]))),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // BackButtonWidget(onPressed: navigateBack),
                NextButtonWidget(onPressed: () {
                  UserModel userModel = UserModel(
                      firstName: widget.firstName,
                      lastName: widget.lastName,
                      dob: widget.dob,
                      email: widget.email,
                      mobile: widget.mobile);
                  registrationBloc.add(UserSubmittedEvent(userModel));
                  registrationBloc.add(SummaryDetailsUpdatedEvent());
                  Navigator.pushNamed(context, '/businessDetails');
                })
              ],
            ),
          ));
    });
  }

  void _updateFirstName(String newValue) {
    widget.firstName = newValue;
  }

  void _updateLastName(String newValue) {
    widget.lastName = newValue;
  }

  void _updateDob(String newValue) {
    widget.dob = newValue;
  }

  void _updateEmail(String newValue) {
    widget.email = newValue;
  }

  void _updateMobile(String newValue) {
    widget.mobile = newValue;
  }

  void _setDefaultValues(UserDetailsState state) {
    widget.firstName = state.user.firstName;
    widget.lastName = state.user.lastName;
    widget.dob = state.user.dob;
    widget.email = state.user.email;
    widget.mobile = state.user.mobile;
  }
}
