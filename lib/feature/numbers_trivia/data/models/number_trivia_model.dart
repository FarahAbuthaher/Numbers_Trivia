import 'package:trivia_numbers/feature/numbers_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({
    required String text,
    required int number,
  }) : super(
          text: text,
          number: number,
        );

  // turns map into NumberTriviaModel object
  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      text: json['text'],
      number: (json['number'] as num).toInt(),
    );
  }

  // Takes an object and turns it into a map
  Map<String, dynamic> toJson() {
    return {'text': text, 'number': number};
  }
}
