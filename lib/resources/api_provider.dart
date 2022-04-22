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
      Future.delayed(const Duration(seconds:2));
      final String response = await rootBundle.loadString('lib/assets/questions.json');
      final decodedResponse = json.decode(response);
      return QuestionsModelList.fromJson(decodedResponse);
      // Response response = await _dio.get(_url);
      // return QuestionsModel.fromJson(response);
    } catch (error, stacktrace) {
      debugPrint("Exception occured: $error stackTrace: $stacktrace");
      return QuestionsModelList(error: "Data not found / Connection issue");
    }
  }

  Future submitAnswersToQuestions(answers) async {
    try{
      // Response response = await _dio.post(_url, data: answers);
      // return response.statusCode == 200;
      answers.forEach((item) => debugPrint(item));
      return true;
    } catch (error, stacktrace) {
      debugPrint("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }
}