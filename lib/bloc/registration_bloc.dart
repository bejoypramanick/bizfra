// registration_bloc.dart

import 'package:bizfra/bloc/registration_event.dart';
import 'package:bizfra/bloc/registration_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/business_model.dart';
import '../models/documents_model.dart';
import '../models/photo_model.dart';
import '../models/user_model.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {

  BusinessRegistrationState bizRegState =  BusinessRegistrationState(user: null, business: null, documents: null, photoModel: null);
  RegistrationBloc() : super(RegistrationInitialState()) {
    on<UserSubmittedEvent>((event, emit) {
      // Handle user submission and emit state
      bizRegState = bizRegState.copyWith(user: event.user);
      emit(bizRegState); // Emit the corresponding state
    });

    on<BusinessSubmittedEvent>((event, emit) {
      // Handle business submission and emit state
      bizRegState = bizRegState.copyWith(business: event.business);
      emit(bizRegState); // Emit the corresponding corresponding state
    });

    on<DocumentSubmittedEvent>((event, emit) {
      // Handle document submission and emit state
      bizRegState = bizRegState.copyWith(documents: event.documents);
      emit(bizRegState); // Emit the corresponding state
    });
    on<PhotoTakenEvent>((event, emit) {
      // Handle document submission and emit state
      bizRegState = bizRegState.copyWith(photoModel: event.photo);
      emit(bizRegState); // Emit the corresponding state
    });
    on<SummaryDetailsUpdatedEvent>((event, emit) {
      // Handle document submission and emit state
      emit(bizRegState);
    });

  }
}
