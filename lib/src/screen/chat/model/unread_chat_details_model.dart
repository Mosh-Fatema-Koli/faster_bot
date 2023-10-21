class ChatDetailsModel {
  String? sId;
  String? chatThreadId;
  int? messageId;
  String? sender;
  Content? content;
  DateTime? originalTimestamp;
  dynamic botReadAt;
  String? userReadAt;
  String? hitLogId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ChatDetailsModel(
      {this.sId,
        this.chatThreadId,
        this.messageId,
        this.sender,
        this.content,
        this.originalTimestamp,
        this.botReadAt,
        this.userReadAt,
        this.hitLogId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  ChatDetailsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    chatThreadId = json['chat_thread_id'];
    messageId = json['message_id'];
    sender = json['sender'];
    content =
    json['content'] != null ? Content.fromJson(json['content']) : null;
    originalTimestamp =DateTime.fromMillisecondsSinceEpoch(json['original_timestamp'] * 1000);
    botReadAt = json['bot_read_at'];
    userReadAt = json['user_read_at'];

    hitLogId = json['hit_log_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['chat_thread_id'] = this.chatThreadId;
    data['message_id'] = this.messageId;
    data['sender'] = this.sender;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['original_timestamp'] = this.originalTimestamp;
    data['bot_read_at'] = this.botReadAt;
    data['user_read_at'] = this.userReadAt;
    data['hit_log_id'] = this.hitLogId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Content {
  String? kind;
  DataModel? data;

  Content({this.kind, this.data});

  Content.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    data = json['data'] != null ? DataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = this.kind;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataModel {
  dynamic text;
  String? file;
  Meta? meta;

  DataModel({this.text, this.file, this.meta});

  DataModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    file = json['file'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['text'] = this.text;
    data['file'] = this.file;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Meta {
  String? mediaGroupId;

  Meta({this.mediaGroupId});

  Meta.fromJson(Map<String, dynamic> json) {
    mediaGroupId = json['media_group_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['media_group_id'] = this.mediaGroupId;
    return data;
  }
}


class Message {
  int? messageId;
  From? from;
  Chat? chat;
  int? date;
  String? mediaGroupId;
  List<Photo>? photo;

  Message(
      {this.messageId,
        this.from,
        this.chat,
        this.date,
        this.mediaGroupId,
        this.photo});

  Message.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'];
    from = json['from'] != null ? From.fromJson(json['from']) : null;
    chat = json['chat'] != null ? Chat.fromJson(json['chat']) : null;
    date = json['date'];
    mediaGroupId = json['media_group_id'];
    if (json['photo'] != null) {
      photo = <Photo>[];
      json['photo'].forEach((v) {
        photo!.add(Photo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message_id'] = this.messageId;
    if (this.from != null) {
      data['from'] = this.from!.toJson();
    }
    if (this.chat != null) {
      data['chat'] = this.chat!.toJson();
    }
    data['date'] = this.date;
    data['media_group_id'] = this.mediaGroupId;
    if (this.photo != null) {
      data['photo'] = this.photo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class From {
  int? id;
  bool? isBot;
  String? firstName;
  String? lastName;
  String? languageCode;

  From({this.id, this.isBot, this.firstName, this.lastName, this.languageCode});

  From.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isBot = json['is_bot'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    languageCode = json['language_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['is_bot'] = this.isBot;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['language_code'] = this.languageCode;
    return data;
  }
}

class Chat {
  int? id;
  String? firstName;
  String? lastName;
  String? type;

  Chat({this.id, this.firstName, this.lastName, this.type});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['type'] = this.type;
    return data;
  }
}

class Photo {
  String? fileId;
  String? fileUniqueId;
  int? fileSize;
  int? width;
  int? height;

  Photo(
      {this.fileId, this.fileUniqueId, this.fileSize, this.width, this.height});

  Photo.fromJson(Map<String, dynamic> json) {
    fileId = json['file_id'];
    fileUniqueId = json['file_unique_id'];
    fileSize = json['file_size'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['file_id'] = this.fileId;
    data['file_unique_id'] = this.fileUniqueId;
    data['file_size'] = this.fileSize;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}
