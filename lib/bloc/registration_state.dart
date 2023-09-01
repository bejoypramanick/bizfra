// registration_state.dart
import 'package:bizfra/models/photo_model.dart';

import '../models/business_model.dart';
import '../models/id_model.dart';
import '../models/user_model.dart';

abstract class RegistrationState {}

class RegistrationInitialState extends RegistrationState {}

class BusinessRegistrationState extends RegistrationState {
  final UserModel? user;
  final BusinessModel? business;
//  final DocumentsModel? documents;
  final PhotoModel? photoModel;
  final IdModel? idModel;

  BusinessRegistrationState({
    required this.user,
    required this.business,
 //   required this.documents,
    required this.photoModel,
    required this.idModel
  });

  BusinessRegistrationState copyWith(
      {UserModel? user,
      BusinessModel? business,
    //  DocumentsModel? documents,
      PhotoModel? photoModel,
      IdModel? idModel}) {
    return BusinessRegistrationState(
        user: user ?? this.user,
        business: business ?? this.business,
     //   documents: documents ?? this.documents,
        photoModel: photoModel ?? this.photoModel, idModel: idModel ?? this.idModel);
  }
}
