class Participant
{
  late String id;
  late String email;
  late int score;
  late int total;

  Participant({required this.id,required this.email,required this.score,required this.total});

  Participant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    score = json['score'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['score'] = this.score;
    data['total'] = this.total;
    return data;
  }

}