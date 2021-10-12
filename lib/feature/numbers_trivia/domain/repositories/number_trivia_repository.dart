import 'package:dartz/dartz.dart';
import 'package:trivia_numbers/core/error/failure.dart';
import 'package:trivia_numbers/feature/numbers_trivia/domain/entities/number_trivia.dart';

// Contract Repository, meaning this where we DEFINE what the repo will do
abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getSpecificNumberTrivia(int number);

  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
