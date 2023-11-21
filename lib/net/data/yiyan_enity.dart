class YiyanEnity {
  int? code;
  YiyanData? data;
  dynamic error;
  int? updateTime;

  YiyanEnity({
    this.code,
    this.data,
    this.error,
    this.updateTime,
  });

  factory YiyanEnity.fromJson(Map<String, dynamic> json) => YiyanEnity(
    code: json["code"],
    data: json["data"] == null ? null : YiyanData.fromJson(json["data"]),
    error: json["error"],
    updateTime: json["updateTime"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data?.toJson(),
    "error": error,
    "updateTime": updateTime,
  };
}

class YiyanData {
  int? id;
  String? tag;
  String? name;
  String? origin;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;

  YiyanData({
    this.id,
    this.tag,
    this.name,
    this.origin,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  factory YiyanData.fromJson(Map<String, dynamic> json) => YiyanData(
    id: json["id"],
    tag: json["tag"],
    name: json["name"],
    origin: json["origin"],
    content: json["content"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tag": tag,
    "name": name,
    "origin": origin,
    "content": content,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}