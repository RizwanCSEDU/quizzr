import 'package:quizzr/Models/CustomQuizDetails.dart';

class Participation
{
  late CustomQuizDetails quizDetails;
  late  int score;
  late int total;

  Participation(this.quizDetails,this.score,this.total);

  Participation.fromJson(Map<String,dynamic> json){
    quizDetails = CustomQuizDetails.fromJson(json['details']);
    score = json["score"];
    total = json["total"];
  }

  toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['details'] = this.quizDetails.toJson();
    data['score'] = this.score;
    data['total'] = this.total;
    return data;
  }
}