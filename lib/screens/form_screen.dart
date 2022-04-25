import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questioner/assets/app_constants.dart';
import 'package:questioner/bloc/questions_bloc/questions_bloc.dart';
import 'package:questioner/bloc/questions_bloc/questions_event.dart';
import 'package:questioner/bloc/questions_bloc/questions_state.dart';

import '../models/question_model.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  QuestionsBloc? _questionsBloc;

  @override
  void initState() {
    _questionsBloc = context.read();
    _questionsBloc?.add(FetchQuestionsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Constants.defaultHorizontalPadding,
                vertical: Constants.defaultVerticalPadding),
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
                  "As an added security step please provide answers to the additional questions below",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 40,),
                _buildQuestionsList(),
              ],
            ),
          )
      ),
    );
  }

  Widget _buildQuestionsList() {
    return BlocConsumer<QuestionsBloc, QuestionsState>(
      listener: (context, state) {
        if (state is ResponsesSentSuccessfully) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/result', (route) => false);
        } else if (state is ResponsesSendingError) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Incremented"),
            duration: Duration(milliseconds: 300),),);
        }
      },
      builder: (context, state) {
        if (state is QuestionsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is QuestionsLoaded) {
          return Expanded(
            child: Column(
              children: [
                _buildQuestion(
                    question: state.questions.questions![state.step],
                    currentQuestionIndex: state.step + 1,
                    questionsNumber: state.questions.questions!.length,
                    answers: state.answers
                ),
                const Spacer(),
                _buildNextBtn(
                    max: state.questions.questions!.length - 1,
                    step: state.step,
                    answers: state.answers
                ),
                const SizedBox(height: 10),
                _buildBackBtn(step: state.step)
              ],
            ),
          );
        } else if (state is QuestionsError) {
          return Text(state.error);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildQuestion({QuestionModel? question, int? currentQuestionIndex,
    int? questionsNumber, List? answers}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Question ${currentQuestionIndex.toString()} of ${questionsNumber
                  .toString()}',
              style: const TextStyle(color: Colors.grey, fontSize: 12)
          ),
          const SizedBox(height: 10),
          Text(question!.title!),
          const SizedBox(height: 10),
          _buildAnswersRadioList(
              question.answers, answers, currentQuestionIndex),
        ],
      );

  Widget _buildAnswersRadioList(answersList, answers, currentQuestionIndex) =>
      SizedBox(
        height: 200,
        child: ListView.builder(
            itemCount: answersList.length,
            itemBuilder: (BuildContext context, int index) {
              return _checkListItem(
                  answersList: answersList,
                  answerNumber: index,
                  answers: answers,
                  currentQuestionIndex: currentQuestionIndex
              );
            }),
      );

  Widget _checkListItem({required List answersList, required int answerNumber,
    required List answers, required int currentQuestionIndex}) =>
       Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: RadioListTile(
            dense: true,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            title: Text(answersList[answerNumber].title!),
            value: answerNumber,
            groupValue: answers.isEmpty
                ? -1
                : answers.asMap().containsKey(currentQuestionIndex - 1)
                ? answers[currentQuestionIndex - 1] : -1,
            onChanged: (value) {
              _questionsBloc!.add(SelectAnswerEvent(answer: value));
            }
        ),
      );

  Widget _buildNextBtn({max, step, answers}) =>
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isAnsweredQuestion(step: step, answers: answers)
              ? () => _openNextQuestion(max: max, step: step)
              : null,
          child: Text(step != max ? 'Next' : 'Send'),
          style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue[800],
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              minimumSize: const Size.fromHeight(40),
              textStyle: const TextStyle(fontSize: 16)),
        ),
      );

  Widget _buildBackBtn({step}) =>
      SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () => _openPreviousQuestion(step: step),
          child: const Text('Back'),
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              minimumSize: const Size.fromHeight(40),
              textStyle: const TextStyle(fontSize: 16, color: Colors.black)),
        ),
      );

  _openNextQuestion({max, step}) {
    _questionsBloc?.add(
        step != max
            ? NextQuestionEvent()
            : SubmitQuestionsAnswersEvent()
    );
  }

  _openPreviousQuestion({step}) {
    step != 0
        ? _questionsBloc?.add(PrevQuestionEvent())
        : Navigator.pop(context);
  }

  bool _isAnsweredQuestion({required answers, required step}) =>
      answers.asMap().containsKey(step);
}