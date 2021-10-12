
import 'package:dartz/dartz.dart';
import 'package:trivia_numbers/core/error/failure.dart';

class InputConverter{
  Either<Failure, int> stringToUnsignedInteger(String strNum){
    try {
      final integer = int.parse(strNum);
      if(integer < 0) throw FormatException();
      return Right(integer);
    }
    on FormatException {return Left(InvalidInputFailure());}
  }
}

class InvalidInputFailure extends Failure {}