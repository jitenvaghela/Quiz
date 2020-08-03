import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'QuizJoin.dart';
import 'loading.dart';
class AvailQuiz extends StatefulWidget {
  @override
  AvailQuizState createState() => AvailQuizState();
}
class AvailQuizState extends State<AvailQuiz> {
  static String quizname='';
  Widget _buildListItem(BuildContext context,DocumentSnapshot qinfo)
  {
    return Container(
          color: Colors.cyan[100],
          margin: EdgeInsets.all(5.0),
          child:Card(
            margin: EdgeInsets.all(2.0),
                child: ListTile(
                  onTap: (){
                    setState(() {
                    quizname=qinfo.data['quizname']??'';
                    QuizJoinPageState.questionno=0;
                    QuizJoinPageState.total=0;    
                    });              
                     Navigator.push(context,
                      MaterialPageRoute(builder: (_) =>QuizJoinPage()));
                     
                  },
                  leading: CircleAvatar(backgroundColor: Colors.cyan,radius: 20,child: new  Text(qinfo.data['quizname'][0]??''.toUpperCase()),),
                  title:new Text(qinfo.data['quizname'??''],style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20.0),),
                  subtitle: new Text(qinfo.data['teachername']??''),
                  trailing: IconButton(icon: Icon(Icons.more_vert),iconSize: 30.0, onPressed: (){
                    showDialog(
                      context: context,
                      builder:(context)=> AlertDialog(
                        title: Text("Subject: "+qinfo['subjectname']),
                        content: Text("Topic: "+qinfo["topicname"]),
                      ));
                  }),
        )
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      QuizJoinPageState.questionno=0;
    });
    return Scaffold(
      appBar:AppBar(title: Text('Available Quiz'),leading: Icon(Icons.event_available),backgroundColor: Colors.cyan),
      body: StreamBuilder(
        stream: Firestore.instance.collection('quizinfo').snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData) return Loading();
          return ListView.builder(
            itemExtent: 80.0,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,index)=> _buildListItem(context,snapshot.data.documents[index]),
          );
        }
        )
      
    );
  }
  }