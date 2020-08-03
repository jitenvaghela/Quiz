import 'package:cloud_firestore/cloud_firestore.dart';
import 'questions.dart';
import 'quizinfo.dart';
import 'result.dart';
class DatabaseService{
  String uid;
  DatabaseService({String uid})
  {
    this.uid=uid;
  }
  final CollectionReference datacollection=Firestore.instance.collection("data");
  Future updateUserData(String username,String email,String name,String contactnum,String password) async
  {
    return await datacollection.document(uid).setData({
      'username':username,
      'email':email,
      'name':name,
      'contactnum':contactnum,
      'password':password,
      'timestamp': DateTime.now(),
    });
  }
  final CollectionReference quiz1 =Firestore.instance.collection("questions");
   Future createquestions(String email,String subjectname,String topicname,String teachername,String qname,int questionno,String question,String option1,String option2,String option3,String option4,int ans) async{
    return await quiz1.document(qname+questionno.toString()).setData({
      'email': email,
      'subjectname':subjectname,
      'topicname':topicname,
      'teachername':teachername,
      'qname':qname,
      'questionnumber':questionno,
      'question':question,
      'option1':option1,
      'option2':option2,
      'option3':option3,
      'option4':option4,
      'ans':ans,
      'timestamp': DateTime.now(),
    });
  } 
  //questions from snapshot
  List<Question> _questionsfromsnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Question(
        questionnum: doc.data['questionnumber'] ?? 0,
        question: doc.data['question']??' ',
        option1: doc.data['option1']??' ',
        option2: doc.data['option2']??' ',
        option3: doc.data['option3']??' ',
        option4: doc.data['option4']??" ",
        ans: doc.data['ans']??0,
        
      );
    }).toList();
  }
   //get question stream
  Stream<List<Question>> get questions{
    return quiz1.snapshots()
    .map(_questionsfromsnapshot); 
  }
  CollectionReference quizinfo =Firestore.instance.collection("quizinfo");
  Future createquizinfo(String email,String qname,String subjectname,String topicname,String teachername) async{ 
    return await quizinfo.document(qname).setData({
      'email': email,
      'quizname':qname,
      'subjectname':subjectname,
      'topicname':topicname,
      'teachername':teachername,
      'timestamp': DateTime.now(),});    
  }
  //quizinfo from snapshot
  List<QuizInfo> _quizinfofromsnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return QuizInfo(
        qname: doc.data['quizname']??' ',
        subjectname: doc.data['subjectname']??' ',
        topicname: doc.data['topicname']??' ',
        teachername: doc.data['teachername']??' ',        
      );
    }).toList();
  }
     //get quizinfo  stream
  Stream<List<QuizInfo>> get quizsinfo{
    return quizinfo.snapshots()
    .map(_quizinfofromsnapshot); 
  }
  CollectionReference quizresult =Firestore.instance.collection("quizresult");
  Future createquizresult(String quizname,String email,int result,String lastqueno) async{
    return await quizresult.document(uid).setData({
      'quizname':quizname,
      'email': email,
      'result':result,
      'lastqueno':lastqueno,
      'timestamp': DateTime.now(),          
    });
  }
    //result from snapshot
  List<Result> _resultfromsnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Result(
        resultquizname: doc.data['quizname']??' ',
        resultemail: doc.data['email']??' ',
        result: doc.data['result']??0,
               
      );
    }).toList();
  }
     //get result stream
  Stream<List<Result>> get resultinfo{
    return quizresult.snapshots()
    .map(_resultfromsnapshot); 
  }
    CollectionReference feedbackdata =Firestore.instance.collection("feedback");
  Future feedbackcreate(String email,String name,String currentemail,String feedback) async{
    return await feedbackdata.document(uid).setData({
      'email':email,
      'name':name,
      'currentemail':currentemail,
      'feedback':feedback,
      'timestamp': DateTime.now(),          
    });
  }
}