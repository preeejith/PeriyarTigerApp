import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/userprofile.dart';

class StateProfile extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class BlocProfileInitial extends StateProfile {}

class RetrievingUserData extends StateProfile {}

class UserDataReceived extends StateProfile {
  final UserProfileModel? userProfileModel;
  UserDataReceived({this.userProfileModel});  
}
