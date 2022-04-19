import 'package:flutter/material.dart';
import 'package:questioner/assets/app_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Constants.defaultHorizontalPadding,
                vertical: Constants.defaultVerticalPadding),
            child: Column(
              children: <Widget>[
                const Text(
                  'We are having trouble finding your information.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Image(
                    width: 100,
                    height: 100,
                    image: NetworkImage(
                        'https://pics.freeicons.io/uploads/icons/png/12583467711582994875-512.png'),
                  ),),
                const Text(
                  "That's ok though! We'll use another method to verify your identity. "
                      "Tap Continue below to complete your form",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const Spacer(),
                _continueBtn(),
                const SizedBox(height: 50,)
              ],
            ),
          )
      ),
    );
  }

  Widget _continueBtn() =>
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/form'),
          child: const Text('Continue'),
          style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue[800],
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              minimumSize: const Size.fromHeight(40),
              textStyle: const TextStyle(
                  fontSize: 16)),
        ),
      );
}