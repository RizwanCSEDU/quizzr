import 'dart:core';
class NonExistentQuiz implements Exception{
  @override
  String toString()=>"Quiz doesn't exist";
}