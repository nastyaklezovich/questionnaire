class AnswerModel {
  String? title;
  String? value;

  AnswerModel({this.title, this.value});

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      AnswerModel(
        title: json['title'] ?? '',
        value: json['value'] ?? '',
      );
}