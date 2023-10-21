
class TenentUserModel {
  int? code;
  String? kind;
  String? message;
  Data? data;

  TenentUserModel({
    this.code,
    this.kind,
    this.message,
    this.data,
  });

  factory TenentUserModel.fromJson(Map<String, dynamic> json) => TenentUserModel(
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
  Tenant? tenant;

  Data({
    this.tenant,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tenant: json["tenant"] == null ? null : Tenant.fromJson(json["tenant"]),
  );

  Map<String, dynamic> toJson() => {
    "tenant": tenant?.toJson(),
  };
}

class Tenant {
  String? id;
  UserId? userId;
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
  int? v;
  String? defaultReply;
  String? welcomeMessage;

  Tenant({
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
    this.v,
    this.defaultReply,
    this.welcomeMessage,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
    id: json["_id"],
    userId: json["user_id"] == null ? null : UserId.fromJson(json["user_id"]),
    appId: json["app_id"],
    secretToken: json["secret_token"],
    phone: json["phone"],
    botName: json["bot_name"],
    botUsername: json["bot_username"],
    botfatherToken: json["botfather_token"],
    properties: json["properties"] == null ? null : Properties.fromJson(json["properties"]),
    currentWebhookInfo: json["current_webhook_info"] == null ? null : CurrentWebhookInfo.fromJson(json["current_webhook_info"]),
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    v: json["__v"],
    defaultReply: json["default_reply"],
    welcomeMessage: json["welcome_message"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user_id": userId?.toJson(),
    "app_id": appId,
    "secret_token": secretToken,
    "phone": phone,
    "bot_name": botName,
    "bot_username": botUsername,
    "botfather_token": botfatherToken,
    "properties": properties?.toJson(),
    "current_webhook_info": currentWebhookInfo?.toJson(),
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "__v": v,
    "default_reply": defaultReply,
    "welcome_message": welcomeMessage,
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

class UserId {
  GoogleUser? googleUser;
  String? id;
  String? name;
  String? email;
  String? role;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UserId({
    this.googleUser,
    this.id,
    this.name,
    this.email,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    googleUser: json["google_user"] == null ? null : GoogleUser.fromJson(json["google_user"]),
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "google_user": googleUser?.toJson(),
    "_id": id,
    "name": name,
    "email": email,
    "role": role,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class GoogleUser {
  String? uid;
  String? email;
  String? name;

  GoogleUser({
    this.uid,
    this.email,
    this.name,
  });

  factory GoogleUser.fromJson(Map<String, dynamic> json) => GoogleUser(
    uid: json["uid"],
    email: json["email"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "name": name,
  };
}
