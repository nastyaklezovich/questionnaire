import 'api_provider.dart';

class ApiRepository {
  final _apiProvider = ApiProvider();

  Future fetchQuestionsList() =>
      _apiProvider.fetchQuestionsList();

  Future submitAnswersToQuestions(answers) =>
      _apiProvider.submitAnswersToQuestions(answers);
}

class NetworkError extends Error {}