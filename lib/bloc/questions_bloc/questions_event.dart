import 'package:equatable/equatable.dart';

abstract class QuestionsEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchQuestionsEvent extends QuestionsEvent{}

class SubmitQuestionsAnswersEvent extends QuestionsEvent{}

class SelectAnswerEvent extends QuestionsEvent{
  final answer;

  SelectAnswerEvent({required this.answer});

  @override
  List<Object> get props => [answer];
}

class NextQuestionEvent extends QuestionsEvent{}

class PrevQuestionEvent extends QuestionsEvent{}
