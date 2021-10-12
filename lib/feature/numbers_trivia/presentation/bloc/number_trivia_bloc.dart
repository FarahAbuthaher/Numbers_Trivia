import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:trivia_numbers/core/error/failure.dart';
import 'package:trivia_numbers/core/usecase/usecase.dart';
import 'package:trivia_numbers/core/util/input_converter.dart';
import 'package:trivia_numbers/feature/numbers_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_numbers/feature/numbers_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:trivia_numbers/feature/numbers_trivia/domain/usecases/get_specific_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetSpecificNumberTrivia getSpecificNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {required this.getSpecificNumberTrivia,
      required this.getRandomNumberTrivia,
      required this.inputConverter,})
      : super(Empty());

  @override
  Stream<NumberTriviaState> mapEventToState(NumberTriviaEvent event) async* {
    if (event is GetTriviaForSpecificNumber) {
      // will either return of type Failure or int
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);
      yield* inputEither.fold(
          // left side if type Failure
          (failure) async* {
        yield Error(INVALID_INPUT_FAILURE_MESSAGE);
      },
          //right side if type int
          (integer) async* {
        yield Loading();
        final failureOrTrivia =
            await getSpecificNumberTrivia(Params(number: integer));
        yield* _eitherLoadedOrErrorState(failureOrTrivia);
      });
    } else if (event is GetTriviaForRandomNumber) {
      yield Loading();
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
      Either<Failure, NumberTrivia> either) async* {
    yield either.fold(
      (failure) => Error(_mapFailureToMessage(failure)),
      (trivia) => Loaded(trivia: trivia),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
