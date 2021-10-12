part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTriviaForSpecificNumber extends NumberTriviaEvent{
  // used string because we're using text field in UI
  // no conversion in  UI layer, as in n  business logic in UI
  final String numberString;

  GetTriviaForSpecificNumber(this.numberString);

  @override
  List<Object> get props => [numberString];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent{}
