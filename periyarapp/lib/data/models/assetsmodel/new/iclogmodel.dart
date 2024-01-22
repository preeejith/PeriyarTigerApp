class IcLogModel {
  IcLogModel({
    this.status,
    this.msg,
    this.totalLength,
    this.page,
    this.limit,
    this.data,
  });

  IcLogModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    totalLength = json['totalLength'];
    page = json['page'];
    limit = json['limit'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? status;
  String? msg;
  int? totalLength;
  int? page;
  int? limit;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    map['totalLength'] = totalLength;
    map['page'] = page;
    map['limit'] = limit;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.stock,
    this.status,
    this.id,
    this.assetId,
    this.employeeId,
    this.frominventoryId,
    this.toinventoryId,
    this.type,
    this.createDate,
    this.updateDate,
    this.v,
  });

  Data.fromJson(dynamic json) {
    stock = json['stock'];
    status = json['status'];
    id = json['_id'];
    assetId =
        json['assetId'] != null ? AssetId.fromJson(json['assetId']) : null;
    employeeId = json['employeeId'] != null
        ? EmployeeId.fromJson(json['employeeId'])
        : null;
    frominventoryId = json['frominventoryId'] != null
        ? FrominventoryId.fromJson(json['frominventoryId'])
        : null;
    toinventoryId = json['toinventoryId'] != null
        ? ToinventoryId.fromJson(json['toinventoryId'])
        : null;
    type = json['type'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  int? stock;
  String? status;
  String? id;
  AssetId? assetId;
  EmployeeId? employeeId;
  FrominventoryId? frominventoryId;
  ToinventoryId? toinventoryId;
  String? type;
  String? createDate;
  String? updateDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stock'] = stock;
    map['status'] = status;
    map['_id'] = id;
    if (assetId != null) {
      map['assetId'] = assetId?.toJson();
    }

    if (employeeId != null) {
      map['employeeId'] = employeeId?.toJson();
    }
    if (frominventoryId != null) {
      map['frominventoryId'] = frominventoryId?.toJson();
    }
    if (toinventoryId != null) {
      map['toinventoryId'] = toinventoryId?.toJson();
    }
    map['type'] = type;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    return map;
  }
}

class ToinventoryId {
  ToinventoryId({
    this.location,
    this.status,
    this.unitincharge,
    this.id,
    this.type,
    this.name,
    this.description,
    this.unitUnderIc,
    this.createDate,
    this.updateDate,
    this.v,
  });

  ToinventoryId.fromJson(dynamic json) {
    if (json['location'] != null) {
      location = [];
      json['location'].forEach((v) {
        location?.add((v));
      });
    }
    status = json['status'];
    if (json['unitincharge'] != null) {
      unitincharge = [];
      json['unitincharge'].forEach((v) {
        unitincharge?.add((v));
      });
    }
    id = json['_id'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    unitUnderIc = json['unitUnderIc'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  List<dynamic>? location;
  String? status;
  List<dynamic>? unitincharge;
  String? id;
  String? type;
  String? name;
  String? description;
  String? unitUnderIc;
  String? createDate;
  String? updateDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    if (unitincharge != null) {
      map['unitincharge'] = unitincharge?.map((v) => v.toJson()).toList();
    }
    map['_id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['description'] = description;
    map['unitUnderIc'] = unitUnderIc;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    return map;
  }
}

class FrominventoryId {
  FrominventoryId({
    this.location,
    this.status,
    this.unitincharge,
    this.id,
    this.type,
    this.name,
    this.description,
    this.createDate,
    this.updateDate,
    this.v,
  });

  FrominventoryId.fromJson(dynamic json) {
    if (json['location'] != null) {
      location = [];
      json['location'].forEach((v) {
        location?.add((v));
      });
    }
    status = json['status'];
    unitincharge =
        json['unitincharge'] != null ? json['unitincharge'].cast<String>() : [];
    id = json['_id'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  List<dynamic>? location;
  String? status;
  List<String>? unitincharge;
  String? id;
  String? type;
  String? name;
  String? description;
  String? createDate;
  String? updateDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['unitincharge'] = unitincharge;
    map['_id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['description'] = description;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    return map;
  }
}

class AssetId {
  AssetId({
    this.status,
    this.id,
    this.name,
    this.type,
    this.productType,
    this.createDate,
    this.updateDate,
    this.v,
    this.description,
  });

  AssetId.fromJson(dynamic json) {
    status = json['status'];
    id = json['_id'];
    name = json['name'];
    type = json['type'];
    productType = json['productType'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
    description = json['description'];
  }
  String? status;
  String? id;
  String? name;
  String? type;
  String? productType;
  String? createDate;
  String? updateDate;
  int? v;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['_id'] = id;
    map['name'] = name;
    map['type'] = type;
    map['productType'] = productType;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    map['description'] = description;
    return map;
  }
}

class EmployeeId {
  EmployeeId({
    this.status,
    this.id,
    this.userName,
    this.assiginedUnitId,
    this.createDate,
  });

  EmployeeId.fromJson(dynamic json) {
    status = json['status'];
    id = json['_id'];
    userName = json['userName'];
    assiginedUnitId = json['assiginedUnitId'];

    createDate = json['create_date'];
  }
  String? status;
  String? id;
  String? userName;
  String? assiginedUnitId;

  String? createDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['_id'] = id;
    map['userName'] = userName;
    map['assiginedUnitId'] = assiginedUnitId;

    map['create_date'] = createDate;

    return map;
  }
}
