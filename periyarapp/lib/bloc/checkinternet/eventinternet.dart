import 'package:equatable/equatable.dart';

class EventInternet extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();

}

class InternetFound extends EventInternet {}

class NoInternetFound extends EventInternet {}

class CheckingInternet extends EventInternet {}

class RefreshEvent extends EventInternet {}