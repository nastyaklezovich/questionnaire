import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questioner/assets/app_constants.dart';
import 'package:questioner/bloc/questions_bloc/questions_bloc.dart';
import 'package:questioner/bloc/questions_bloc/questions_event.dart';
import 'package:questioner/bloc/questions_bloc/questions_state.dart';
import 'package:questioner/models/answer_model.dart';

import '../models/question_model.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final List _results = [];
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Constants.defaultHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "We need to verify it's you",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(height: 10,),
                const Text(
                  "That's ok though! We'll use another method to verify your identity. "
                      "Tap Continue below to complete your form",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10,),
                _buildQuestionsList(),
              ],
            ),
          )
      ),
    );
  }

  Widget _buildQuestionsList() {
    return BlocProvider(
        create: (_) => QuestionsBloc()..add(FetchQuestionsEvent()),
        child: BlocBuilder<QuestionsBloc, QuestionsState>(
          builder: (context, state) {
            if (state is QuestionsInitial) {
              return const Text('initial');
            } else if (state is QuestionsLoading) {
              return const Center(child: CircularProgressIndicator(),);
            } else if (state is QuestionsLoaded) {
              return Column(
                children: [
                  _buildQuestion(
                      question: state.questions[_currentStep],
                      index: _currentStep + 1,
                      questionsNumber: state.questions.length
                  ),
                  _buildNextBtn(maxNumber: state.questions.length - 1,  bloc: BlocProvider.of<QuestionsBloc>(context)),
                  const SizedBox(height: 20,),
                  _buildBackBtn()
                ],
              );
            } else if (state is QuestionsError) {
              return const Text('error');
            } else {
              return Container();
            }
          },
        ),
    );
  }

  Widget _buildQuestion({QuestionModel? question, int? index, int? questionsNumber}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Question ${index.toString()} of ${questionsNumber.toString()}',
          style: const TextStyle(color: Colors.grey, fontSize: 12),),
        const SizedBox(height: 10,),
        Text(question!.title!),
        const SizedBox(height: 10,),
        _buildAnswersRadioList(question.answers, index),
      ],
    );

  Widget _buildAnswersRadioList(answers, questionIndex) =>
      SizedBox(
        height: 250,
        child: ListView.builder(
            itemCount: answers.length,
            itemBuilder: (BuildContext context, int index) {
              return _checkListItem(answers, index, questionIndex - 1);
            }),
      );

  Widget _checkListItem(List<AnswerModel> answers, int index, int questionIndex) =>
      RadioListTile(
          title: Text(answers[index].title!),
          value: index,
          groupValue: _results.asMap().containsKey(questionIndex) ? _results[questionIndex] : -1,
          onChanged: (value) {
            setState(() {
              if(_results.asMap().containsKey(questionIndex)){
                _results[questionIndex] = value;
              } else {
                _results.add(value);
              }
            });
          }
      );

  Widget _buildNextBtn({maxNumber, bloc}) =>
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isAnsweredQuestion() ? () => _continue(maxNumber) : null,
          child: const Text('Next'),
          style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue[800],
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              minimumSize: const Size.fromHeight(40),
              textStyle: const TextStyle(
                  fontSize: 16)),
        ),
      );

  Widget _buildBackBtn() =>
      SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () => _cancel(),
          child: const Text('Back'),
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              minimumSize: const Size.fromHeight(40),
              textStyle: const TextStyle(fontSize: 16, color: Colors.black)),
        ),
      );

  _continue(maxNumber){
    if(_currentStep < maxNumber){
      setState(() {
        _currentStep += 1;
      });
    }
  }

  _cancel(){
    if(_currentStep == 0){
      Navigator.pop(context);
    } else {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  _submitAnswers(bloc){
    bloc.add(SubmitQuestionsAnswersEvent(_results));
  }

  bool _isAnsweredQuestion() => _results.asMap().containsKey(_currentStep);
}