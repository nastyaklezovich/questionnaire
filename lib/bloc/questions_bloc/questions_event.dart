import 'package:equatable/equatable.dart';

abstract class QuestionsEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchQuestionsEvent extends QuestionsEvent{}

// class SubmitQuestionsAnswersEvent extends QuestionsEvent{
//   final List results;
//   SubmitQuestionsAnswersEvent(this.results);
// }