import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/bloc/userprofilebloc/eventprofile.dart';
import 'package:parambikulam/bloc/userprofilebloc/stateprofile.dart';
import 'package:parambikulam/data/models/userprofile.dart';

class BlocProfile extends Bloc<EventProfile, StateProfile> {
  BlocProfile() : super(StateProfile()) {
    on<GetUserProfile>(_getUserProfile);
  }
  Future<FutureOr<void>> _getUserProfile(
      GetUserProfile event, Emitter<StateProfile> emit) async {
    emit(RetrievingUserData());
    UserProfileModel userProfileModel;
    userProfileModel = await AuthRepository().getUserData(url: '/user/me');
    if (userProfileModel.status == true) {
      print(userProfileModel.msg);
      // print(userProfileModel.userdata![0].user![0].email.toString());
      emit(UserDataReceived(userProfileModel: userProfileModel));
    } else {
      print(userProfileModel.msg);
    }
  }

  // @override
  // Stream<StateProfile> mapEventToState(EventProfile event) async* {
  //   if (event is GetUserProfile) {
  //     yield RetrievingUserData();
  //     UserProfileModel userProfileModel;
  //     userProfileModel = await AuthRepository().getUserData(url: '/user/me');
  //     if (userProfileModel.status == true) {
  //       print(userProfileModel.msg);
  //       // print(userProfileModel.userdata![0].user![0].email.toString());
  //       yield UserDataReceived(userProfileModel: userProfileModel);
  //     } else {
  //       print(userProfileModel.msg);
  //     }
  //   }
  // }
}
