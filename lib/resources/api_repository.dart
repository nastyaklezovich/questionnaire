import 'api_provider.dart';

class ApiRepository {
  final _apiProvider = ApiProvider();

  Future fetchQuestionsList() =>
      _apiProvider.fetchQuestionsList();

  Future postAnswersToQuestions(answers) =>
      _apiProvider.postAnswersToQuestions(answers);
}

class NetworkError extends Error {}