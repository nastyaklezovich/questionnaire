import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:questioner/assets/app_constants.dart';
import 'package:questioner/models/question_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = Constants.baseUrl;

  Future fetchQuestionsList() async {
    try {
      final String response = await rootBundle.loadString('lib/assets/questions.json');
      var decodedResponse = json.decode(response);
      QuestionsModel map = QuestionsModel.fromJson(decodedResponse);
      return map.questions;
      // Response response = await _dio.get(_url);
      // return QuestionsModel.fromJson(response);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return QuestionsModel.withError("Data not found / Connection issue");
    }
  }

  Future submitAnswersToQuestions(answers) async {
    try{
      // Response response = await _dio.post(_url, data: answers);
      // return response.statusCode == 200;
      print(answers);
      return true;
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return false;
    }
  }
}