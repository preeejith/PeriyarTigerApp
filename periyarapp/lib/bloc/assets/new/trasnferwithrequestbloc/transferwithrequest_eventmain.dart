                              import 'package:equatable/equatable.dart';
                              import 'package:parambikulam/ui/assets/ic_main/viewrequestmaindetailed.dart';

                              class TransferwithRequestEvent extends Equatable {
                                @override
                                List<Object> get props => [];
                              }

                              class GetTransferwithRequest extends TransferwithRequestEvent {
                                final String? requestId;

                                final List<RequestModel> requestlist;

                                GetTransferwithRequest({this.requestId, required this.requestlist});
                                @override
                                List<Object> get props => [];
                              }
                              class FetchTransferwithRequest extends TransferwithRequestEvent {
                                final dynamic data;



                                FetchTransferwithRequest({this.data});
                                @override
                                List<Object> get props => [];
                              }