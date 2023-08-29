// registration_bloc.dart

import 'package:bizfra/bloc/registration_event.dart';
import 'package:bizfra/bloc/registration_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/business_model.dart';
import '../models/documents_model.dart';
import '../models/photo_model.dart';
import '../models/user_model.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  late UserModel _userModel;
  late BusinessModel _businessModel;
  late DocumentsModel _documentsModel;
  late PhotoModel _photoModel;
  late String text;

  RegistrationBloc() : super(RegistrationInitialState()) {
    on<UserSubmittedEvent>((event, emit) {
      // Handle user submission and emit state
      _userModel = event.user;
      emit(UserDetailsState(event.user)); // Emit the corresponding state
    });

    on<BusinessSubmittedEvent>((event, emit) {
      // Handle business submission and emit state
      _businessModel = event.business;
      emit(
          BusinessDetailsState(event.business)); // Emit the corresponding state
    });

    on<DocumentSubmittedEvent>((event, emit) {
      // Handle document submission and emit state
      _documentsModel = event.documents;
      emit(DocumentUploadState(
          documents: event.documents)); // Emit the corresponding state
    });
    on<PhotoTakenEvent>((event, emit) {
      // Handle document submission and emit state
      _photoModel = event.photo;
      emit(PhotoUploadState(event.photo)); // Emit the corresponding state
    });
    on<SummaryDetailsUpdatedEvent>((event, emit) {
      // Handle document submission and emit state
      emit(SummaryState(
          user: _userModel,
          business: _businessModel,
          documents: _documentsModel,
          photoModel: _photoModel)); // Emit the corresponding state
    });

  }
}
