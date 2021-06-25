
import 'package:quizzr/Models/Categories.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quizzr/Models/Quiz.dart';

class API
{

  Future<Categories> fetchCategories() async
  {
    try{
      http.Response response = await http.get(Uri.parse('https://opentdb.com/api_category.php'));

      if(response.statusCode == 200)
      {
        return Categories.fromJson(json.decode(response.body));
      }
      else
      {
        throw Exception('Failed to fetch Categories');
      }
    }
    catch(e){
      throw Exception('Failed to fetch Categories');
    }
  }



  Future<Quiz> fetchQuiz(int categoryID) async
  {
    try{
      http.Response response = await http.get(Uri.parse('https://opentdb.com/api.php?amount=5&category='+categoryID.toString()+'&difficulty=medium&type=multiple'));

      if(response.statusCode == 200)
      {
        return Quiz.fromJson(json.decode(response.body));
      }
      else
      {
        throw Exception('Failed to fetch Quiz');
      }
    }
    catch(e)
    {
      throw Exception('Failed to fetch Quiz');
    }
  }

  

}