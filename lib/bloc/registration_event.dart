// registration_event.dart
import 'package:bizfra/models/photo_model.dart';

import '../models/business_model.dart';
import '../models/documents_model.dart';
import '../models/user_model.dart';

abstract class RegistrationEvent {}

class UserSubmittedEvent extends RegistrationEvent {
  final UserModel user;

  UserSubmittedEvent(this.user);
}

class BusinessSubmittedEvent extends RegistrationEvent {
  final BusinessModel business;

  BusinessSubmittedEvent(this.business);
}

class DocumentSubmittedEvent extends RegistrationEvent {
  final DocumentsModel documents;

  DocumentSubmittedEvent(this.documents);
}

class PhotoTakenEvent extends RegistrationEvent {
  final PhotoModel photo;

  PhotoTakenEvent(this.photo);
}

class SummaryDetailsUpdatedEvent extends RegistrationEvent {
  SummaryDetailsUpdatedEvent();
}
