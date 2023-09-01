import 'package:bizfra/bloc/registration_bloc.dart';
import 'package:bizfra/helper/HttpHelper.dart';
import 'package:bizfra/models/business_model.dart';
import 'package:bizfra/models/documents_model.dart';
import 'package:bizfra/models/id_model.dart';
import 'package:bizfra/models/photo_model.dart';
import 'package:bizfra/models/registration_model.dart';
import 'package:bizfra/widgets/screens/business_details_screen.dart';
import 'package:bizfra/widgets/screens/documents_upload_screen.dart';
import 'package:bizfra/widgets/screens/id_screen_widget.dart';
import 'package:bizfra/widgets/screens/summary_screen.dart';
import 'package:flutter/cupertino.dart';

import '../bloc/registration_event.dart';
import '../models/user_model.dart';
import '../widgets/screens/capture_photo_screen.dart';
import '../widgets/screens/user_details_screen.dart';
import 'ModelHelper.dart';

//populates model
// invokes event
// navigates to next/previous screen
class EventHelper {
  static void userScreenNextButtonClicked(RegistrationBloc registrationBloc, BuildContext context, UserDetailsScreenWidget widget) {
    UserModel userModel = ModelHelper.populateUserModelFromWidget(widget);
    registrationBloc.add(UserSubmittedEvent(userModel));
    Navigator.pushNamed(context, '/businessDetails');
  }

  static void businessScreenNextButtonClicked(RegistrationBloc registrationBloc,
      BuildContext context, BusinessDetailsScreenWidget widget) {
    BusinessModel businessModel =
        ModelHelper.populateBusinessModelFromWidget(widget);
    registrationBloc.add(BusinessSubmittedEvent(businessModel));
  //  Navigator.pushNamed(context, '/documentsUpload');
    Navigator.pushNamed(context, '/idUpload');
  }

  static void businessScreenBackButtonClicked(BuildContext context) {
    Navigator.pushNamed(context, '/userDetails');
  }

  static void idScreenNextButtonClicked(RegistrationBloc registrationBloc,
      BuildContext context, IdScreenWidget widget) {
    IdModel idModel =
    ModelHelper.populateIdModelFromWidget(widget);
    registrationBloc.add(IdSubmittedEvent(idModel));
    Navigator.pushNamed(context, '/photoUpload');
  }

  static void idScreenBackButtonClicked(BuildContext context) {
    Navigator.pushNamed(context, '/businessDetails');
  }

  static void documentScreenNextButtonClicked(RegistrationBloc registrationBloc,
      BuildContext context, DocumentUploadScreenWidget widget) {
      DocumentsModel documentModel =
        ModelHelper.populateDocumentModelFromWidget(widget);
    registrationBloc.add(DocumentSubmittedEvent(documentModel));
    Navigator.pushNamed(context, '/photoUpload');
  }

  static void documentScreenBackButtonClicked(BuildContext context) {
    Navigator.pushNamed(context, '/businessDetails');
  }

  static void photoScreenNextButtonClicked(RegistrationBloc registrationBloc,
      BuildContext context, CameraWidget widget) {
    PhotoModel photoModel = ModelHelper.populatePhotoModelFromWidget(widget);
    registrationBloc.add(PhotoTakenEvent(photoModel));
    Navigator.pushNamed(context, '/summaryDetails');
  }

  static void photoScreenBackButtonClicked(BuildContext context) {
    Navigator.pushNamed(context, '/idUpload');
  }

  static void summaryScreenBackButtonClicked(BuildContext context) {
    Navigator.pushNamed(context, '/photoUpload');
  }

  static void summaryScreenSubmitButtonClicked(
      RegistrationModel registrationModel,
      BuildContext context,
      SummaryDetailsScreenWidget widget) {

    HttpHelper.submitData(registrationModel, '/register/organization');
  }
}
