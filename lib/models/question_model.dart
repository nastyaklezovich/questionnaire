import 'answer_model.dart';

class QuestionsModel{
  List<QuestionModel>? questions;
  String? error;

  QuestionsModel({this.questions, this.error});

  QuestionsModel.withError(String errorMessage) {
    error = errorMessage;
  }

  QuestionsModel.fromJson(Map<String, dynamic> json){
    if (json['questions'] != null) {
      questions = [];
      json['questions'].forEach((item) {
        questions!.add(QuestionModel.fromJson(item));
      });
    }
  }
}

class QuestionModel{
  String? title;
  List<AnswerModel>? answers;

  QuestionModel({this.title, this.answers});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    if (json['answers'] != null) {
      answers = [];
      json['answers'].forEach((item) {
        answers!.add(AnswerModel.fromJson(item));
      });
    }
  }
}