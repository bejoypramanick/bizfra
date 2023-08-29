// registration_state.dart
import 'package:bizfra/models/photo_model.dart';

import '../models/business_model.dart';
import '../models/documents_model.dart';
import '../models/user_model.dart';

abstract class RegistrationState {}

class RegistrationInitialState extends RegistrationState {}

class UserDetailsState extends RegistrationState {
  final UserModel user;

  UserDetailsState(this.user);
}

class BusinessDetailsState extends RegistrationState {
  final BusinessModel business;

  BusinessDetailsState(this.business);
}

class DocumentUploadState extends RegistrationState {
  final DocumentsModel documents;

  DocumentUploadState({required this.documents});
}

class PhotoUploadState extends RegistrationState {
  final PhotoModel photoModel;

  PhotoUploadState(this.photoModel);
}

class SummaryState extends RegistrationState {
  final UserModel user;
  final BusinessModel business;
  final DocumentsModel documents;

  final PhotoModel photoModel;

  SummaryState({
    required this.user,
    required this.business,
    required this.documents,
    required this.photoModel,
  });
}
