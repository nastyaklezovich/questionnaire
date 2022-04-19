import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questioner/bloc/questions_bloc/questions_event.dart';
import 'package:questioner/bloc/questions_bloc/questions_state.dart';
import 'package:questioner/resources/api_repository.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final ApiRepository _apiRepository = ApiRepository();

  QuestionsBloc() : super(QuestionsInitial()) {
    on<FetchQuestionsEvent>((event, emit) async {
      emit(QuestionsLoading());
      final response = await _apiRepository.fetchQuestionsList();
      emit(QuestionsLoaded(response));
    });
    on<SubmitQuestionsAnswersEvent>((event, emit) async {
      await _apiRepository.submitAnswersToQuestions(event.results);
    });
  }

}