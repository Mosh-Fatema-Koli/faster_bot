import 'dart:convert';


class UnReadChatModel {
  int? code;
  String? kind;
  String? message;
  Data? data;

  UnReadChatModel({
     this.code,
     this.kind,
     this.message,
     this.data,
  });

  factory UnReadChatModel.fromJson(Map<String, dynamic> json) => UnReadChatModel(
    code: json["code"],
    kind: json["kind"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "kind": kind,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  List<ListElement>? list;

  Data({
     this.list,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class ListElement {
  String? id;
  TenantId? tenantId;
  TelegramUserId? telegramUserId;
  String? status;
  DateTime? lastMessageAt;
  String? lastMessage;
  String? lastMessageBy;
  String? label;
  dynamic botReadAt;
  DateTime? userReadAt;
  DateTime? createdAt;
  DateTime? updatedAt;


  ListElement({
     this.id,
     this.tenantId,
     this.telegramUserId,
     this.status,
     this.lastMessageAt,
     this.lastMessage,
     this.lastMessageBy,
     this.label,
     this.botReadAt,
     this.userReadAt,
     this.createdAt,
     this.updatedAt,

  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["_id"],
    tenantId: TenantId.fromJson(json["tenant_id"]),
    telegramUserId: TelegramUserId.fromJson(json["telegram_user_id"]),
    status: json["status"],
    lastMessageAt: DateTime.parse(json["last_message_at"]),
    lastMessage: json["last_message"],
    label: json["label"],
    lastMessageBy: json["last_message_by"],
    botReadAt: json["bot_read_at"],
    userReadAt: DateTime.parse(json["user_read_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),

  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "tenant_id": tenantId!.toJson(),
    "telegram_user_id": telegramUserId!.toJson(),
    "status": status,
    "last_message_at": lastMessageAt!.toIso8601String(),
    "last_message": lastMessage,
    "label": label,
    "last_message_by": lastMessageBy,
    "bot_read_at": botReadAt,
    "user_read_at": userReadAt!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
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

  });

  factory TelegramUserId.fromJson(Map<String, dynamic> json) => TelegramUserId(
    id: json["_id"],
    tgid: json["tgid"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    username: json["username"],
    photo: json["photo"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),

  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "tgid": tgid,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "photo": photo,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),

  };
}

class TenantId {
  String? id;
  String? userId;
  String? appId;
  String? secretToken;
  String? phone;
  String? botName;
  String? botUsername;
  String? botfatherToken;
  Properties? properties;
  CurrentWebhookInfo? currentWebhookInfo;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;


  TenantId({
     this.id,
     this.userId,
     this.appId,
     this.secretToken,
     this.phone,
     this.botName,
     this.botUsername,
     this.botfatherToken,
     this.properties,
     this.currentWebhookInfo,
     this.status,
     this.createdAt,
     this.updatedAt,

  });

  factory TenantId.fromJson(Map<String, dynamic> json) => TenantId(
    id: json["_id"],
    userId: json["user_id"],
    appId: json["app_id"],
    secretToken: json["secret_token"],
    phone: json["phone"],
    botName: json["bot_name"],
    botUsername: json["bot_username"],
    botfatherToken: json["botfather_token"],
    properties: Properties.fromJson(json["properties"]),
    currentWebhookInfo: CurrentWebhookInfo.fromJson(json["current_webhook_info"]),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user_id": userId,
    "app_id": appId,
    "secret_token": secretToken,
    "phone": phone,
    "bot_name": botName,
    "bot_username": botUsername,
    "botfather_token": botfatherToken,
    "properties": properties!.toJson(),
    "current_webhook_info": currentWebhookInfo!.toJson(),
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class CurrentWebhookInfo {
  String? url;
  bool? hasCustomCertificate;
  int? pendingUpdateCount;
  int? maxConnections;
  String? ipAddress;

  CurrentWebhookInfo({
     this.url,
     this.hasCustomCertificate,
     this.pendingUpdateCount,
     this.maxConnections,
     this.ipAddress,
  });

  factory CurrentWebhookInfo.fromJson(Map<String, dynamic> json) => CurrentWebhookInfo(
    url: json["url"],
    hasCustomCertificate: json["has_custom_certificate"],
    pendingUpdateCount: json["pending_update_count"],
    maxConnections: json["max_connections"],
    ipAddress: json["ip_address"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "has_custom_certificate": hasCustomCertificate,
    "pending_update_count": pendingUpdateCount,
    "max_connections": maxConnections,
    "ip_address": ipAddress,
  };
}

class Properties {
  int? id;
  bool? isBot;
  String? firstName;
  String? username;
  bool? canJoinGroups;
  bool? canReadAllGroupMessages;
  bool? supportsInlineQueries;

  Properties({
     this.id,
     this.isBot,
     this.firstName,
     this.username,
     this.canJoinGroups,
     this.canReadAllGroupMessages,
     this.supportsInlineQueries,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    id: json["id"],
    isBot: json["is_bot"],
    firstName: json["first_name"],
    username: json["username"],
    canJoinGroups: json["can_join_groups"],
    canReadAllGroupMessages: json["can_read_all_group_messages"],
    supportsInlineQueries: json["supports_inline_queries"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_bot": isBot,
    "first_name": firstName,
    "username": username,
    "can_join_groups": canJoinGroups,
    "can_read_all_group_messages": canReadAllGroupMessages,
    "supports_inline_queries": supportsInlineQueries,
  };
}
