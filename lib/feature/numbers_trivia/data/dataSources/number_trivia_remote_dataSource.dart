import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trivia_numbers/core/error/exception.dart';
import 'package:trivia_numbers/feature/numbers_trivia/data/models/number_trivia_model.dart';

// errors will be handled by exceptions unlike in Repo
// contract
abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getSpecificNumberTrivia(int number);

  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getSpecificNumberTrivia(int number) =>
      _getNumberTriviaData('http://numbersapi.com/$number?json');

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getNumberTriviaData('http://numbersapi.com/random?json');

  Future<NumberTriviaModel> _getNumberTriviaData(String url) async {
    final response = await client.get(Uri.parse(url));
    // headers: {'Content-Type': 'application/json'}
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
