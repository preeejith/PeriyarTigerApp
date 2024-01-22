// ignore_for_file: avoid_print
//////all ready waiting for up the server
import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parambikulam/bloc/assets/assetseditbloc/assetseditevent.dart';
import 'package:parambikulam/bloc/assets/assetseditbloc/assetseditstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';

import 'package:parambikulam/data/models/assetsmodel/assetseditmodel.dart';


import 'package:parambikulam/local/db/dbhelper.dart';

class GetAssetsEditDetailedsBloc
    extends Bloc<AssetsEditDetailedsEvent, AssetsEditDetailedsState> {
  GetAssetsEditDetailedsBloc() : super(AssetsEditDetailedsState()) {
    on<AssetsEditDetailedEvent>(_assetsEditDetailedEvent);

    on<FetchAssetsEditDetailedEvent>(_fetchAssetsEditDetailedEvent);
  }

  Future<FutureOr<void>> _assetsEditDetailedEvent(AssetsEditDetailedEvent event,
      Emitter<AssetsEditDetailedsState> emit) async {
    DatabaseHelper? db = DatabaseHelper.instance;
 
    emit(AssetsEditing());
    dynamic response;
    //////for edit  from the mastertable
///////
    Map map = {
      "assetId": event.assetId,
      "name": event.name,
      "description": event.description,
    };
    response = map;
    await db.addICAssetsEditListdata(jsonEncode(response));
////////above old edit system
    ///
    await db.updateassetsdata(event.name, "true", event.assetId);
    await db.updateassetmasterdata(
        event.name, event.description, event.assetId);
  }

  ///chnages
  Future<FutureOr<void>> _fetchAssetsEditDetailedEvent(
      FetchAssetsEditDetailedEvent event,
      Emitter<AssetsEditDetailedsState> emit) async {
    AssetsEditModel assetsEditModel;
    DatabaseHelper? db = DatabaseHelper.instance;
    emit(AssetsEditing());
    List items32 = [];

    items32 = await db.getICAssetsEditListDownloadData();
    if (items32.isNotEmpty)
      for (int k = 0; k < items32.length; k++) {
        assetsEditModel = await AuthRepository().assetsedit(
            url: '/asset/edit', data: jsonDecode(items32[k]['data']));

        if (assetsEditModel.status == true) {
          await db.deleteICAssetsEditListdata(
              int.parse(items32[k]['id'].toString()));
          emit(AssetsEditDetailedssuccess());
        } else if (assetsEditModel.status == false) {
          emit(AssetsEditError(error: assetsEditModel.msg));
        }
      }
  }
}
