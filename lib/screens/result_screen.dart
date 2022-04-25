import 'package:flutter/material.dart';

import '../assets/app_constants.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Constants.defaultHorizontalPadding,
                vertical: Constants.defaultVerticalPadding),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Answers sent successfully'),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () =>
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (route) => false),
                      child: const Text('Back'),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          minimumSize: const Size.fromHeight(40),
                          textStyle: const TextStyle(
                              fontSize: 16, color: Colors.black)),
                    ),
                  )
                ],
              ),
          )
        )
    );
  }
}
