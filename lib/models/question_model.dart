import 'answer_model.dart';

class QuestionsModelList {
  List<QuestionModel>? questions;
  String? error;

  QuestionsModelList({this.questions, this.error});

  factory QuestionsModelList.fromJson(Map<String, dynamic> json) =>
      QuestionsModelList(
        questions: (json['questions'] as List?)?.map((item) =>
            QuestionModel.fromJson(item)).toList(),
      );

  QuestionsModelList copyWith({
    String? error,
    List<QuestionModel>? questions,
  }) {
    return QuestionsModelList(
      error: error ?? this.error,
      questions: questions ?? this.questions,
    );
  }
}

class QuestionModel {
  String? title;
  List<AnswerModel>? answers;

  QuestionModel({this.title, this.answers});

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      QuestionModel(
        title: json['title'] ?? '',
        answers: (json['answers'] as List?)?.map((item)=>
            AnswerModel.fromJson(item)).toList(),
      );

}