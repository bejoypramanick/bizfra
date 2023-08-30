import 'dart:typed_data';

import 'package:bizfra/bloc/registration_state.dart';
import 'package:bizfra/models/business_model.dart';
import 'package:bizfra/models/documents_model.dart';
import 'package:bizfra/widgets/screens/capture_photo_screen.dart';
import 'package:bizfra/widgets/screens/documents_upload_screen.dart';

import '../models/photo_model.dart';
import '../models/user_model.dart';
import '../widgets/screens/business_details_screen.dart';
import '../widgets/screens/user_details_screen.dart';

class ModelHelper {
  static UserModel populateUserModelFromWidget(UserDetailsScreenWidget widget) {
    UserModel userModel = UserModel(
        firstName: widget.firstName,
        lastName: widget.lastName,
        dob: widget.dob,
        email: widget.email,
        mobile: widget.mobile);
    return userModel;
  }

  static BusinessModel populateBusinessModelFromWidget(
      BusinessDetailsScreenWidget widget) {
    BusinessModel businessModel = BusinessModel(
        orgName: widget.orgName,
        orgType: widget.orgType,
        expertise: widget.expertise,
        address: widget.address,
        branches: widget.noOfbranches,
        website: widget.website);
    return businessModel;
  }

  static DocumentsModel populateDocumentModelFromWidget(
      DocumentUploadScreenWidget widget) {
    DocumentsModel documentModel = DocumentsModel(
        aadharNumber: widget.aadharNumber,
        panNumber: widget.panNumber,
        gstNumber: widget.gstNumber,
        aadharFile: widget.aadharFile,
        panFile: widget.panFile,
        gstFile: widget.gstFile);
    return documentModel;
  }

  static PhotoModel populatePhotoModelFromWidget(CameraWidget widget) {
    PhotoModel photoModel =
        PhotoModel(photoData: widget?.photoData ?? Uint8List(0));
    return photoModel;
  }

  UserModel? userModel;
  BusinessModel? businessModel;
  DocumentsModel? documentsModel;
  PhotoModel? photoModel;

  void populateUserModelFromState(BusinessRegistrationState state) {
    userModel = state.user;
    businessModel = state.business;
    documentsModel = state.documents;
    photoModel = state.photoModel;
  }
}
