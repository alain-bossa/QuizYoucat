import 'option.dart';

class Question {
  late String text;
  late String reponse;
  late int duration;
  late List<Option> options;

  Question(
    this.text,
    this.reponse,
    this.duration,
    this.options,
  );

  Question.fromJson(dynamic json) {
    text = json["text"];
    reponse = json["reponse"];
    duration = json["duration"];
    options = List<Option>.from(json["options"].map((x) => Option.fromJson(x)));
  }

  static jsonToObject(dynamic json) {
    List<Option> options = [];
    if (json["options"] != null) {
      options =
          List<Option>.from(json["options"].map((x) => Option.fromJson(x)));
    }
    return Question(
        json["text"], json["reponse"], json["duration"], options);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["text"] = text;
    map["reponse"];
    map["duration"] = duration;
    map["options"] = List<dynamic>.from(options.map((x) => x.toJson()));
    return map;
  }
}
