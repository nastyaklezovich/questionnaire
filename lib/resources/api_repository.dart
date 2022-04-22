import 'api_provider.dart';

class ApiRepository {
  final ApiProvider _apiProvider;

  ApiRepository(this._apiProvider);

  Future fetchQuestionsList() =>
      _apiProvider.fetchQuestionsList();

  Future submitAnswersToQuestions(answers) =>
      _apiProvider.submitAnswersToQuestions(answers);
}

class NetworkError extends Error {}