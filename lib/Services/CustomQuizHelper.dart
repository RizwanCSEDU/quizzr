import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizzr/Exceptions/NonExistentQuiz.dart';
import 'package:quizzr/Models/CustomQuizDetails.dart';
import 'package:quizzr/Models/Participant.dart';
import 'package:quizzr/Models/Participation.dart';
import 'package:quizzr/Models/Quiz.dart';

class CustomQuizHelper {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future updateParticipation(
      CustomQuizDetails quizDetails, int score, int total) async {
    List<String> ids = [];
    ids = quizDetails.id.split("quizzr");
    try {
      User? user = _auth.currentUser;
      var batch = _store.batch();
      batch.update(
          _store.collection(ids[0].toString()).doc(ids[1] + "participants"), {
        "participants": FieldValue.arrayUnion([
          Participant(
                  id: user!.uid.toString(),
                  email: user.email.toString(),
                  score: score,
                  total: total)
              .toJson()
        ])
      });
      batch.update(_store.collection(user.uid).doc("participation"), {
        "participation": FieldValue.arrayUnion(
            [Participation(quizDetails, score, total).toJson()])
      });
      await batch.commit();
    } catch (e) {
      Exception("Error");
    }
  }

  Future<List<Participant>> getParticipants(String id) async {
    List<String> ids = [];
    ids = id.split("quizzr");
    try {
      DocumentSnapshot doc = await _store
          .collection(ids[0].toString())
          .doc(ids[1].toString() + "participants")
          .get();
      Map<String, dynamic> data = new Map<String, dynamic>();
      data = doc.data() as Map<String, dynamic>;
      List<Participant> participants = [];
      data["participants"].forEach((v) {
        participants.add(Participant.fromJson(v));
      });
      return participants;
    } catch (e) {
      throw Exception("Error getting participants");
    }
  }

  Future<List<Participation>> getParticipation() async {
    try {
      User? user = _auth.currentUser;
      DocumentSnapshot doc =
          await _store.collection(user!.uid).doc("participation").get();
      Map<String, dynamic> data = new Map<String, dynamic>();
      data = doc.data() as Map<String, dynamic>;
      List<Participation> participationList = [];
      data["participation"].forEach((v) {
        participationList.add(Participation.fromJson(v));
      });
      return participationList;
    } catch (e) {
      throw Exception("Error");
    }
  }

  Future<dynamic> checkParticipation(String id) async {
    List<String> ids = [];
    ids = id.split("quizzr");
    if (ids.length < 2) {
      throw NonExistentQuiz();
    }
    try {
      User? user = _auth.currentUser;
      DocumentSnapshot doc = await _store
          .collection(ids[0].toString())
          .doc(ids[1].toString() + "participants")
          .get()
          .timeout(Duration(seconds: 5), onTimeout: () {
        throw Exception("Timed out");
      });

      if (doc.exists) {
        Map<String, dynamic> data = new Map<String, dynamic>();
        data = doc.data() as Map<String, dynamic>;
        Participant participant;
        dynamic result = false;
        data["participants"].forEach((v) {
          participant = Participant.fromJson(v);
          if (participant.id == user!.uid) {
            result = participant;
          }
        });
        return result;
      } else {
        throw NonExistentQuiz();
      }
    } on NonExistentQuiz catch (exception) {
      throw exception;
    } catch (e) {
      throw Exception("Error");
    }
  }

  Future<Quiz> getQuiz(String id) async {
    List<String> ids = [];
    ids = id.split("quizzr");
    if (ids.length < 2) {
      throw NonExistentQuiz();
    }
    try {
      DocumentSnapshot doc = await _store
          .collection(ids[0].toString())
          .doc(ids[1].toString())
          .get()
          .timeout(Duration(seconds: 5), onTimeout: () {
        throw Exception("Timed out");
      });
      if (doc.exists) {
        Map<String, dynamic> data = new Map<String, dynamic>();
        data = doc.data() as Map<String, dynamic>;
        return Quiz.fromJson(data);
      } else {
        throw NonExistentQuiz();
      }
    } on NonExistentQuiz catch (exception) {
      throw exception;
    } catch (e) {
      throw Exception("Error");
    }
  }

  Future<CustomQuizDetails> getQuizDetails(String id) async {
    List<String> ids = [];
    ids = id.split("quizzr");
    if (ids.length < 2) {
      throw NonExistentQuiz();
    }
    try {
      DocumentSnapshot doc = await _store
          .collection(ids[0].toString())
          .doc(ids[1].toString() + "details")
          .get();
      if (doc.exists) {
        Map<String, dynamic> data = new Map<String, dynamic>();
        data = doc.data() as Map<String, dynamic>;
        return CustomQuizDetails.fromJson(data);
      } else {
        throw NonExistentQuiz();
      }
    } on NonExistentQuiz catch (exception) {
      throw exception;
    } catch (e) {
      throw Exception("Error");
    }
  }

  Future<List<CustomQuizDetails>> getListOfCreatedQuiz() async {
    try {
      User? user = _auth.currentUser;
      List<CustomQuizDetails> listOfCustomQuiz = [];
      await _store
          .collection(user!.uid)
          .doc("quizzes")
          .get()
          .then((DocumentSnapshot doc) {
        if (doc.exists) {
          Map<String, dynamic> data = new Map<String, dynamic>();
          data = doc.data() as Map<String, dynamic>;
          data["quizzes"].forEach((v) {
            listOfCustomQuiz.add(CustomQuizDetails.fromJson(v));
          });
        }
      });
      return listOfCustomQuiz;
    } catch (e) {
      throw Exception("Error");
    }
  }

  Future createQuiz(CustomQuizDetails details, Quiz quiz) async {
    try {
      User? user = _auth.currentUser;

      DocumentReference reference = _store.collection(user!.uid).doc();

      details.id = user.uid.toString() + "quizzr" + reference.id.toString();
      
      var batch = _store.batch();
      
      batch.set(reference, quiz.toJson());
      batch.update(_store.collection(user.uid).doc("quizzes"), {"quizzes": FieldValue.arrayUnion([details.toJson()])});
      batch.set(_store.collection(user.uid).doc(reference.id.toString() + "participants"),{"participants": []});
      batch.set(_store.collection(user.uid).doc(reference.id.toString() + "details"),details.toJson());
      await batch.commit().timeout(Duration(seconds: 8),onTimeout:(){
        throw Exception();
      });
    } catch (e) {
      throw Exception("Error creating quiz");
    }
  }

  Future deleteQuiz(CustomQuizDetails details) async {
    List<String> ids = [];
    ids = details.id.split("quizzr");
    try {
      var batch = _store.batch();
      batch.update(_store.collection(ids[0].toString()).doc("quizzes"), {
        "quizzes": FieldValue.arrayRemove([details.toJson()])
      });
      batch.delete(_store
          .collection(ids[0].toString())
          .doc(ids[1].toString() + "participants"));
      batch.delete(_store
          .collection(ids[0].toString())
          .doc(ids[1].toString() + "details"));
      batch.delete(_store.collection(ids[0].toString()).doc(ids[1].toString()));
      await batch.commit().timeout(Duration(seconds: 10), onTimeout: () {
        throw Exception();
      });
    } catch (e) {
      print(e);
      throw Exception("Error Deleting");
    }
  }
}
