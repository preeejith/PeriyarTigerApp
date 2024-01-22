


class VhaliRecordAddedModel {
  int? id;
  final String? boatname;
  final String? boatownername;
  final String? boatno;
  final String? length;

  // List<double>? location;
  final String? gender;
  final String? health;
  final String? type;
  // String? status;
  // String? userid;
  // String? field;
  final String? description;
  final String? lat;
  final String? lon;
  final List<String>? image;

  

  VhaliRecordAddedModel({
    this.id,
    required this.boatname,
    required this.boatownername,
    required this.boatno,
    required this.length,

    // this.location,
    required this.gender,
    required this.health,
    required this.type,
    // this.status,
    // this.userid,
    // this.field,
    required this.description,
    required this.lat,
    required this.lon,
    required this.image,
    // this.rescueVideo,
    // this.sId,
    // this.createDate,

    //  required  this.image,
    // this.photos,
    //  this.documents,
    // this.updateDate,
    //required  this.released,
    // this.iV
  });

  static VhaliRecordAddedModel fromJson(Map<String, Object?> map) {
    //final id = map['id'] as int;
    final data = map['data'];
    print(data);
    final boatname = map['boatname'] as String;
    final boatownername = map['boatownername'] as String;
    final boatno = map['boatno'] as String;
    final length = map['length'] as String;

    // location = map['location'].cast<double>();
    final gender = map['gender'] as String;
    final health = map['health'] as String;
    final type = map['type'] as String;
    // status = map['status']as String;
    // userid = map['userid'] as String;
    // field = map['field'] as String;
    final description = map['description'] as String;
    final lat = map['lat'] as String;
    final lon = map['lon'] as String;
    final image = map['image'] as String;
    //     if (json['rescueVideo'] != null) {
    //   rescueVideo = json['rescueVideo'].cast<String>();
    // }
    // else {}
    //   if (json['photos'] != null) {
    //   photos = json['photos'].cast<String>();
    // } else {}
    //   if (json['photo'] != null) {
    //   documents = json['photo'].cast<String>();
    // } else {}
    // rescueVideo = json['rescueVideo'].cast<String>();
    // photos = json['photos'].cast<String>();
    //     documents = json['photo'].cast<String>();
    // sId = map['id']as String;
    // createDate = map['create_date']as String;
    // updateDate = map['update_date']as String;

    //  if (map['image']as String != "") {
    //     final image = map['image'] as String;
    //   }
    //   else {}
    // final   Image = map['image'] as String;
    //  final released = map['released'] as String;
    // iV = map['__v'] as int;
    return VhaliRecordAddedModel(
        // id: id,
        boatname: boatname,
        boatno: boatno,
        boatownername: boatownername,
        length: length,
        gender: gender,
        health: health,
        type: type,
        description: description,
        lat: lat,
        lon: lon,
        image: [image, image]);
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};

  //   data['length'] = length;
  //   data['boatno'] = boatno;
  //   data['boatname'] = boatname;
  //   data['ownerName'] = boatownername;
  //   data['location'] = location;
  //   data['gender'] = gender;
  //   data['health'] = health;
  //   data['type'] = type;
  //   data['status'] = status;
  //   data['userid'] = userid;
  //   data['field'] = field;
  //   data['description'] = description;
  //   data['lat'] = lat;
  //   data['lon'] = lon;
  //   data['rescueVideo'] = rescueVideo;
  //   data['photo'] = documents;
  //   data['_id'] = sId;
  //   data['create_date'] = createDate;
  //   data['update_date'] = updateDate;
  //   data['released'] = released;
  //   data['__v'] = iV;
  //   return data;
  // }
}

// class PhotoAddedResponse {
//   bool? status;
//   String? id;
//   String? msg;

//   PhotoAddedResponse({this.status, this.id, this.msg});

//   PhotoAddedResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     id = json['id'];
//     msg = json['msg'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['id'] = id;
//     data['msg'] = msg;
//     return data;
//   }
// }

// class DocumentAddedResponse {
//   bool? status;
//   String? id;
//   String? msg;

//   DocumentAddedResponse({this.status, this.id, this.msg});

//   DocumentAddedResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     id = json['id'];
//     msg = json['msg'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['id'] = id;
//     data['msg'] = msg;
//     return data;
//   }
// }

// class VideoAddedResponse {
//   bool? status;
//   String? id;
//   String? msg;

//   VideoAddedResponse({this.status, this.id, this.msg});

//   // VideoAddedResponse.fromJson(Map<String, dynamic> json) {
//   //   status = json['status'];
//   //   id = json['id'];
//   //   msg = json['msg'];
//   // }

//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = <String, dynamic>{};
//   //   data['status'] = status;
//   //   data['id'] = id;
//   //   data['msg'] = msg;
//   //   return data;
//   // }
// }

// class RecordListModel {
//   bool? status;
//   List<VhaliRecordAddedModel>? recordModelList;
//   String? msg;

//   // RecordListModel({this.status, this.recordModelList, this.msg});

//   // RecordListModel.fromJson(Map<String, dynamic> json) {
//   //   status = json['status'];
//   //   if (json['data'] != null) {
//   //     recordModelList = <VhaliRecordAddedModel>[];
//   //     json['data'].forEach((v) {
//   //       recordModelList!.add(VhaliRecordAddedModel.fromJson(v));
//   //     });
//   //   }
//   //   msg = json['msg'];
//   // }

//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = <String, dynamic>{};
//   //   data['status'] = status;
//   //   if (recordModelList != null) {
//   //     data['data'] = recordModelList!.map((v) => v.toJson()).toList();
//   //   }
//   //   data['msg'] = msg;
//   //   return data;
//   // }
// }
