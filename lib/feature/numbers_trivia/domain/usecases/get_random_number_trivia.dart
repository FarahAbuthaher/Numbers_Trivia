import 'package:dartz/dartz.dart';
import 'package:trivia_numbers/core/error/failure.dart';
import 'package:trivia_numbers/core/usecase/usecase.dart';
import 'package:trivia_numbers/feature/numbers_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_numbers/feature/numbers_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

// added call so we could use the class as if it were merely a method (fake method)
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
