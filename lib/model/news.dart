class News {
  int? type;
  String? message;
  List<dynamic>? promoted;
  List<Data>? data;
  RateLimit? rateLimit;
  bool? hasWarning;

  News({
    this.type,
    this.message,
    this.promoted,
    this.data,
    this.rateLimit,
    this.hasWarning,
  });

  News.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    message = json['Message'];
    promoted = json['Promoted'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    rateLimit = json['RateLimit'] != null ? RateLimit.fromJson(json['RateLimit']) : null;
    hasWarning = json['HasWarning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Type'] = type;
    data['Message'] = message;
    if (promoted != null) {
      data['Promoted'] = promoted;
    }
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (rateLimit != null) {
      data['RateLimit'] = rateLimit!.toJson();
    }
    data['HasWarning'] = hasWarning;
    return data;
  }
}

class Data {
  String? id;
  String? guid;
  int? publishedOn;
  String? imageurl;
  String? title;
  String? url;
  String? body;
  String? tags;
  String? lang;
  String? upvotes;
  String? downvotes;
  String? categories;
  SourceInfo? sourceInfo;
  String? source;

  Data({
    this.id,
    this.guid,
    this.publishedOn,
    this.imageurl,
    this.title,
    this.url,
    this.body,
    this.tags,
    this.lang,
    this.upvotes,
    this.downvotes,
    this.categories,
    this.sourceInfo,
    this.source,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guid = json['guid'];
    publishedOn = json['published_on'];
    imageurl = json['imageurl'];
    title = json['title'];
    url = json['url'];
    body = json['body'];
    tags = json['tags'];
    lang = json['lang'];
    upvotes = json['upvotes'];
    downvotes = json['downvotes'];
    categories = json['categories'];
    sourceInfo = json['source_info'] != null ? SourceInfo.fromJson(json['source_info']) : null;
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['guid'] = guid;
    data['published_on'] = publishedOn;
    data['imageurl'] = imageurl;
    data['title'] = title;
    data['url'] = url;
    data['body'] = body;
    data['tags'] = tags;
    data['lang'] = lang;
    data['upvotes'] = upvotes;
    data['downvotes'] = downvotes;
    data['categories'] = categories;
    if (sourceInfo != null) {
      data['source_info'] = sourceInfo!.toJson();
    }
    data['source'] = source;
    return data;
  }
}

class SourceInfo {
  String? name;
  String? img;
  String? lang;

  SourceInfo({this.name, this.img, this.lang});

  SourceInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    img = json['img'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['img'] = img;
    data['lang'] = lang;
    return data;
  }
}

class RateLimit {
  RateLimit();

  RateLimit.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}
