import 'package:bizfra/models/photo_model.dart';
import 'package:bizfra/models/user_model.dart';

import 'business_model.dart';
import 'id_model.dart';

class RegistrationModel {
  final BusinessModel? business;
  final IdModel? idModel;
  final PhotoModel? photoModel;
  final UserModel? user;

  RegistrationModel(
      {required this.business,
      required this.idModel,
      required this.photoModel,
      required this.user});
// You can add file paths for document uploads here

  Map<String, dynamic> toJson() {
    return {
      'business': business?.toJson(),
      'idModel': idModel?.toJson(),
      'photoModel': photoModel?.toJson(),
      'user': user?.toJson(),
    };
  }
}
