
class BlockListModel {
  int? code;
  String? kind;
  String? message;
  Data? data;

  BlockListModel({
    this.code,
    this.kind,
    this.message,
    this.data,
  });

  factory BlockListModel.fromJson(Map<String, dynamic> json) => BlockListModel(
    code: json["code"],
    kind: json["kind"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "kind": kind,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  List<ListElement>? list;

  Data({
    this.list,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: json["list"] == null ? [] : List<ListElement>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class ListElement {
  String? id;
  String? tenantId;
  TelegramUserId? telegramUserId;
  String? status;
  DateTime? lastMessageAt;
  String? lastMessage;
  String? lastMessageBy;
  dynamic botReadAt;
  DateTime? userReadAt;
  dynamic label;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ListElement({
    this.id,
    this.tenantId,
    this.telegramUserId,
    this.status,
    this.lastMessageAt,
    this.lastMessage,
    this.lastMessageBy,
    this.botReadAt,
    this.userReadAt,
    this.label,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["_id"],
    tenantId: json["tenant_id"],
    telegramUserId: json["telegram_user_id"] == null ? null : TelegramUserId.fromJson(json["telegram_user_id"]),
    status: json["status"],
    lastMessageAt: json["last_message_at"] == null ? null : DateTime.parse(json["last_message_at"]),
    lastMessage: json["last_message"],
    lastMessageBy: json["last_message_by"],
    botReadAt: json["bot_read_at"],
    userReadAt: json["user_read_at"] == null ? null : DateTime.parse(json["user_read_at"]),
    label: json["label"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "tenant_id": tenantId,
    "telegram_user_id": telegramUserId?.toJson(),
    "status": status,
    "last_message_at": lastMessageAt?.toIso8601String(),
    "last_message": lastMessage,
    "last_message_by": lastMessageBy,
    "bot_read_at": botReadAt,
    "user_read_at": userReadAt?.toIso8601String(),
    "label": label,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class TelegramUserId {
  String? id;
  String? tgid;
  String? firstName;
  String? lastName;
  dynamic username;
  String? photo;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  TelegramUserId({
    this.id,
    this.tgid,
    this.firstName,
    this.lastName,
    this.username,
    this.photo,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TelegramUserId.fromJson(Map<String, dynamic> json) => TelegramUserId(
    id: json["_id"],
    tgid: json["tgid"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    username: json["username"],
    photo: json["photo"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "tgid": tgid,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "photo": photo,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
