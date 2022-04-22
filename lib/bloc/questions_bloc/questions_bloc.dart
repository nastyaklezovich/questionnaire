import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questioner/bloc/questions_bloc/questions_event.dart';
import 'package:questioner/bloc/questions_bloc/questions_state.dart';
import 'package:questioner/resources/api_repository.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final ApiRepository _apiRepository;

  QuestionsBloc(this._apiRepository) : super(QuestionsLoading()) {
    on<FetchQuestionsEvent>((event, emit) async {
      emit(QuestionsLoading());
      final response = await _apiRepository.fetchQuestionsList();
      if(response.error?.isNotEmpty == true) {
        emit(QuestionsError(response.error ?? ''));
      } else {
        emit(QuestionsLoaded(questions: response ?? [], step: 0, answers: []));
      }
    });
    on<NextQuestionEvent>((event, emit) {
      if(state is QuestionsLoaded) {
        emit((state as QuestionsLoaded).copyWith(
            step: (state as QuestionsLoaded).step + 1));
      }
    });
    on<PrevQuestionEvent>((event, emit) {
      if(state is QuestionsLoaded) {
        emit((state as QuestionsLoaded).copyWith(
            step: (state as QuestionsLoaded).step - 1));
      }
    });
    on<SubmitQuestionsAnswersEvent>((event, emit) async {
      if(state is QuestionsLoaded) {
        bool response = await _apiRepository.submitAnswersToQuestions(
            (state as QuestionsLoaded).answers);
        emit(response ? ResponsesSentSuccessfully() : ResponsesSendingError());
      }
    });
    on<SelectAnswerEvent>((event, emit){
      if(state is QuestionsLoaded){
        List<String> answers = (state as QuestionsLoaded).answers;
        int step = (state as QuestionsLoaded).step;
        String answer = event.answer;
        answers.asMap().containsKey(step)
            ? answers[step] = answer
            : answers.add(answer);
      }
    });
  }

}