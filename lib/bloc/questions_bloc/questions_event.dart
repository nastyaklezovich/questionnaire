import 'package:equatable/equatable.dart';

abstract class QuestionsEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchQuestionsEvent extends QuestionsEvent{}