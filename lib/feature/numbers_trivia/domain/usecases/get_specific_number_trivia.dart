import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:trivia_numbers/core/error/failure.dart';
import 'package:trivia_numbers/core/usecase/usecase.dart';
import 'package:trivia_numbers/feature/numbers_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_numbers/feature/numbers_trivia/domain/repositories/number_trivia_repository.dart';

// in use case we create classes to use the business objects (i.e business logic);

class GetSpecificNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;
  GetSpecificNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params)
  async {
    return await repository.getSpecificNumberTrivia(params.number);
  }
}

// no real logic, just getting data from Repo

class Params extends Equatable{
  final int number;

  Params({required this.number});

  @override
  List<Object> get props => [number];
}