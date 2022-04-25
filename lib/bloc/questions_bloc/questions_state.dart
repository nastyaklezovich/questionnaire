import 'package:equatable/equatable.dart';

import '../../models/question_model.dart';

abstract class QuestionsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class QuestionsLoading extends QuestionsState {}

class QuestionsLoaded extends QuestionsState {
  final QuestionsModelList questions;
  final int step;
  final List<int> answers;

  QuestionsLoaded({required this.questions, required this.step,
    required this.answers});

  QuestionsLoaded copyWith({
    QuestionsModelList? questions,
    int? step,
    List<int>? answers
  }) {
    return QuestionsLoaded(
        questions: questions ?? this.questions,
        step: step ?? this.step,
        answers: answers ?? this.answers);
  }

  @override
  List<Object> get props => [questions, step, answers];
}

class ResponsesSentSuccessfully extends QuestionsState{}

class ResponsesSendingError extends QuestionsState{}

class QuestionsError extends QuestionsState {
  final String error;
  QuestionsError(this.error);

  @override
  List<Object> get props => [error];
}

