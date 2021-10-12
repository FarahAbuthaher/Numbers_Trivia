import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_numbers/feature/numbers_trivia/domain/usecases/get_specific_number_trivia.dart';
import 'package:trivia_numbers/feature/numbers_trivia/presentation/bloc/number_trivia_bloc.dart';

class TriviaControls extends StatefulWidget {

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  late String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TextField
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {addSpecific();},
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              // Search concrete button
              child: MaterialButton(
                child: Text('Search'),
                textTheme: ButtonTextTheme.primary,
                color: Theme.of(context).accentColor,
                onPressed: addSpecific,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              // Random button
              child: ElevatedButton(
                child: Text('get Random'),
                onPressed: addRandom,
              ),
            )
          ],
        )
      ],
    );
  }

  void addSpecific() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForSpecificNumber(inputStr));
  }

  void addRandom() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }
}
