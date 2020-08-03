import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'loginpage.dart';
import 'AvailQuiz.dart';
import 'Homepage.dart';
import 'database.dart';
import 'loading.dart';
class QuizJoinPage extends StatefulWidget {
  @override
  QuizJoinPageState createState() => QuizJoinPageState();
}
class QuizJoinPageState extends State<QuizJoinPage> { 
  final DatabaseService _quizresult =new DatabaseService();
  static int questionno=0;
  static int numberofque=1001;
  static int total=0;
  String quizname;
  int ansofque;
  int ans;
  static String lastqueno;
  static int queans;
  bool loading=false;
  Widget _buildListItem(BuildContext context,DocumentSnapshot que)
  {
      queans=ansofque;
      ans=que['ans'];
      lastqueno=que.data['questionnumber'].toString();
       return Container(
        margin: EdgeInsets.all(10.0),
        color: Colors.cyan[100],
        child:Card(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top:5.0)),
            Row(
              children:[
                Padding(padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0)),
                Text("Question: "+que.data['questionnumber'].toString(),style:TextStyle(fontSize:20.0,fontWeight: FontWeight.bold)),
              ]
            ),
             Divider(indent: 7.0,endIndent:15.0,color: Colors.black,height: 2.0,thickness:2.0),
             Padding(padding: EdgeInsets.only(top:5.0)),
            Row(
              children:[
                Padding(padding: EdgeInsets.only(left: 15.0)),
                 Text('Q:'+que['question'],style:TextStyle(fontSize:25.0,fontWeight: FontWeight.w500)),
              ]
            ),
            Divider(indent: 7.0,endIndent:15.0,color: Colors.black,height: 2.0),
             Row(
              children:[
                Radio(value: 1,activeColor: Colors.cyan, groupValue: ansofque, onChanged:(int value)=>{setState((){ansofque=value;})}),
                Text(que['option1'],style:TextStyle(fontSize:20.0)),
              ]
            ),
            Divider(indent: 7.0,endIndent:15.0,color: Colors.black,height: 2.0),
             Row(
              children:[
                Radio(value: 2, activeColor: Colors.cyan,groupValue: ansofque, onChanged:(int value)=>{setState((){ansofque=value;})}),
                 Text(que['option2'],style:TextStyle(fontSize:20.0)),
              ]
            ),
            Divider(indent: 7.0,endIndent:15.0,color: Colors.black,height: 2.0),
             Row(
              children:[
                Radio(value: 3,activeColor: Colors.cyan, groupValue: ansofque, onChanged:(int value)=>{setState((){ansofque=value;})}),
                 Text(que['option3'],style:TextStyle(fontSize:20.0)),
              ]
            ),
            Divider(indent: 7.0,endIndent:15.0,color: Colors.black,height: 2.0),
             Row(
              children:[
                Radio(value: 4, activeColor: Colors.cyan,groupValue: ansofque, onChanged:(int value)=>{setState((){ansofque=value;})}),
                 Text(que['option4'],style:TextStyle(fontSize:20.0)),
              ]
            ),
            Divider(indent: 0.0,endIndent:0.0,color: Colors.black,height: 2.0),
            Row(
              children:[
                Padding(padding: EdgeInsets.only(left:15)),
                 Text('*Press',style:TextStyle(fontSize:15.0,color: Colors.red)),
                 Icon(Icons.navigate_next),
                 Text('to next question',style:TextStyle(fontSize:15.0,color: Colors.red)),
              ]
            ),
            
          ],),
        )
      );
  }

  @override
  Widget build(BuildContext context){
    if(questionno < numberofque)
    {
    return loading? Loading() : WillPopScope(
      onWillPop: _backpress,
                child: Scaffold(
              appBar:AppBar(
                title: Text('Questions'),
                leading: Icon(Icons.event_available),
                backgroundColor: Colors.cyan,
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.navigate_next), onPressed: (){
                      questionno+=1;
                      if(ansofque==null)
                      {
                          showDialog(
                          context: context,
                          builder: (context) => new AlertDialog(
                          title: new Text("Give answer"),
                        ),);
                      }
                      else{
                      if(ansofque==ans){total+=1;}
                      print(total);
                      Navigator.push(context,
                        MaterialPageRoute(builder: (_) =>QuizJoinPage()));
                      }
                      })
                  ],),
                body: StreamBuilder(
                stream: Firestore.instance.collection('questions').where('qname',isEqualTo: AvailQuizState.quizname ).orderBy('questionnumber',descending:false).snapshots(),
                builder: (context,snapshot){
                  if(!snapshot.hasData) return Loading();
                  numberofque=snapshot.data.documents.length;
                  return ListView.builder(
                    itemCount: 1 ?? 0,
                    itemBuilder: (context,index)=> _buildListItem(context,snapshot.data.documents[questionno]),
                  );
                }
                )
            ),
          );
          }
          else{
            setState(() {
              questionno=0;
            });
            return loading ? Loading(): WillPopScope(
              onWillPop: _onbackpress,
                            child: Scaffold(
                      backgroundColor: Colors.cyan,
                      body: GestureDetector(
                        onTap:resultcreate,
                        child:Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(vertical:30.0,horizontal: 20.0),
                              decoration: BoxDecoration(
                              color: Colors.cyan[100],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ) 
                          ),
                          child:Container(
                          margin: EdgeInsets.symmetric(vertical:30.0,horizontal: 20.0),
                              decoration: BoxDecoration(
                              color: Colors.cyan[100],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ) 
                          ),
                          child: new Text('No questions',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.black45)),
                        ) 
                        )
                      ),
                  ),
                    );
                  }
                  }
        Future<bool> _onbackpress() async {
        return await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            content: new Text("You can't go back" ),
          ),);
        }
      Future<dynamic> resultcreate()async{
        setState(() {
          loading=true;
        });
        dynamic result = await _quizresult.createquizresult(AvailQuizState.quizname,LoginPageState.email,total,lastqueno);
        if(result==null)
        {
          loading=false;
        Navigator.push(context,
        MaterialPageRoute(builder: (_) =>HomePage()));
        showDialog(
        context: context,
        builder:(context)=> AlertDialog(
        content: Text("Result available at RESULT PAGE")));
        }}
        Future<bool> _backpress() {
        return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            content: new Text("You can't go back" ),
          ),);
        }
}
