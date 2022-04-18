class AnswerModel{
  String? title;
  String? value;

  AnswerModel({this.title, this.value});

  AnswerModel.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    value = json['value'] ?? '';
  }
}