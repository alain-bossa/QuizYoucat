import 'question.dart';

class Quiz {
  late int id;
  late String title;
  late String description;
  late String imagePath;
  late int categoryId;
  late List<Question> questions;

  Quiz(this.id, this.title, this.description,
      this.imagePath, this.categoryId, this.questions);

  Quiz.fromJson(dynamic json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    imagePath = json["imagePath"];
    categoryId = json["categoryId"];
    questions = json["questions"];
  }

  static jsonToObject(dynamic json) {
    List<Question> questionList = [];
    if (json["questions"] != null) {
      questionList = List<Question>.from(
          json["questions"].map((x) => Question.fromJson(x)));
    }
    return Quiz(
        json["id"],
        json["title"],
        json["description"],
        json["imagePath"],
        json["categoryId"],
        questionList);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["title"] = title;
    map["description"] = description;
    map["imagePath"] = imagePath;
    map["categoryId"] = categoryId;
    map["questions"] = List<dynamic>.from(questions.map((x) => x.toJson()));
    return map;
  }
}
