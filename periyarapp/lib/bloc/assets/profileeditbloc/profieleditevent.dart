// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/profileeditbloc/profileeditbloc.dart';
import 'package:parambikulam/bloc/assets/profileeditbloc/profileeditstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/profileupdatemodel.dart';

//////all ready waiting for up the server

class GetProfileUpdateBloc
    extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
  GetProfileUpdateBloc() : super(ProfileUpdateState()) {
    on<GetProfileUpdate>(_getProfileUpdate);
  }

  Future<FutureOr<void>> _getProfileUpdate(
      GetProfileUpdate event, Emitter<ProfileUpdateState> emit) async {
    emit(ProfileUpdateing());

    ViewProfileUpdateModel viewProfileUpdateModel;

    Map map = {
      "name": event.name,
      "dob": event.dob,
      "gender": event.gender,
      "phonenumber": event.phonenumber,
    };

    viewProfileUpdateModel = await AuthRepository()
        .profileedit(url: '/edit/profile/employee', data: map);

    if (viewProfileUpdateModel.status == true) {
      emit(
          ProfileUpdatesuccess(viewProfileUpdateModel: viewProfileUpdateModel));
    } else if (viewProfileUpdateModel.status == false) {
      emit(ProfileUpdateError(error: ''));
    }
  }
}
