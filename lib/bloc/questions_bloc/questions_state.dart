import 'package:equatable/equatable.dart';

import '../../models/question_model.dart';

abstract class QuestionsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class QuestionsInitial extends QuestionsState {}

class QuestionsLoading extends QuestionsState {}

class QuestionsLoaded extends QuestionsState {
  final List<QuestionModel> questions;
  QuestionsLoaded(this.questions);

  @override
  List<Object> get props => [questions];
}

class QuestionsError extends QuestionsState {
  final String error;
  QuestionsError(this.error);

  @override
  List<Object> get props => [error];
}
