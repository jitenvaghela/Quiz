import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'loginpage.dart';
import 'Homepage.dart';
import 'loading.dart';
import 'database.dart';
bool loading=false;
class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}
class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: Text("Let's Create QUIZ"),
        backgroundColor: Colors.cyan,),
        body:CreateQuizForm(),
    );
  }
}
class CreateQuizForm extends StatefulWidget {
  @override
  CreateQuizFormState createState() => CreateQuizFormState();
}
class CreateQuizFormState extends State<CreateQuizForm> {
    final _quizformKey = GlobalKey<FormState>();
    final DatabaseService _quizdata =new DatabaseService();
    static String qname;
    static String subjectname;
    static String topicname;
    static String teachername;
   Future<dynamic> qformvalidation() async{
      if(_quizformKey.currentState.validate()){
        setState(() {
          loading=true;
        });
        dynamic result = await _quizdata.createquizinfo(LoginPageState.email,qname,subjectname,topicname,teachername);
          if(result==null)
          {
          setState(() {loading=false;
          _QuestionPageState.qno=1;});
          Navigator.push(context,
          MaterialPageRoute(builder: (_) => QuestionPage()));
          }                                  
      }
    }
    
  @override
  Widget build(BuildContext context) {
    return loading ?Loading(): Scaffold (
      body: SingleChildScrollView(
        child:Stack(
        children:[
          new Container(
              margin: EdgeInsets.only(top:40.0,bottom:150.0,right: 10.0,left: 10.0),
              decoration: BoxDecoration(
              color: Colors.cyan,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
              Radius.circular(25.0)
            ) 
          ),
          child: new Form(
            key: _quizformKey,
            child: Column(
              children: <Widget>[
                Padding (padding: EdgeInsets.only(top:20.0),),
                new Text("Create quiz form",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.white)),
                new Container(
                margin: EdgeInsets.only(top:15.0,bottom:10.0,right: 10.0,left: 10.0),
                height: 389.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                  Radius.circular(25.0)
                ) 
          ),
                padding: const EdgeInsets.only(top: 15.0,bottom: 10,left: 10,right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      new TextFormField(
                              decoration: new InputDecoration(
                                labelText: " Quiz Name",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan
                              )
                              ), 
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                            if (value.isEmpty) {
                            return 'Enter quiz name';
                          }
                          return null;
                        },
                        onChanged: (value){
                                setState(() {
                                  qname=value;
                                });
                              }
                      ),
                      new Padding(padding: const EdgeInsets.only(top:5.0)),
                      new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Subject Name",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan
                              )
                              ), 
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                            if (value.isEmpty) {
                            return 'Enter subject name';
                          }
                          return null;
                        },
                        onChanged: (value){
                                setState(() {
                                  subjectname=value;
                                });
                              }
                      ),
                      new Padding(padding: const EdgeInsets.only(top:5.0)),
                      new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Topic Name",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan
                              )
                              ), 
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                            if (value.isEmpty) {
                            return 'Enter Topic name';
                          }
                          return null;
                        },
                        onChanged: (value){
                                setState(() {
                                  topicname=value;
                                });
                              }
                      ),
                      new Padding(padding: const EdgeInsets.only(top:5.0)),
                      new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Teacher name",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan
                              )
                              ), 
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                            if (value.isEmpty) {
                            return 'Enter teacher name';
                          }
                          return null;
                        },
                        onChanged: (value){
                                setState(() {
                                  teachername=value;
                                });
                              }
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 5.0) ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new FlatButton(
                              child: new Text("Submit"),
                              color: Colors.cyan,
                              textColor: Colors.white70,
                              splashColor: Colors.redAccent,
                              onPressed: qformvalidation,
                            ),
                        ]
                      )
                      ]
                  )
                  ),
              ],
            )
          ),
          ),
          ]
      ),
      ),
    );
  }
}
class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}
class _QuestionPageState extends State<QuestionPage> {
  final _formKey1 = GlobalKey<FormState>();
  final DatabaseService _data =new DatabaseService();
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  static int qno=1;
  bool loading=false;
  int ansque=1;

  Future<dynamic> questionvalidation() async{
      if(_formKey1.currentState.validate()){
        setState(() {loading=true;});
          dynamic result = await _data.createquestions(
            LoginPageState.email,
            CreateQuizFormState.subjectname,
            CreateQuizFormState.topicname,
            CreateQuizFormState.teachername,
            CreateQuizFormState.qname,
            qno, question, option1, option2, option3, option4,ansque);
          if(result==null)
          {
          setState(() {loading=false;});
          Navigator.push(context,
          MaterialPageRoute(builder: (_) => QuestionPage()));
          }
          qno+=1;
      }
    }
    Future<dynamic> questionvalidation1() async{
      if(_formKey1.currentState.validate()){
        setState(() {loading=true;});
          _formKey1.currentState.save();
          
          dynamic result = await _data.createquestions(LoginPageState.email,
            CreateQuizFormState.subjectname,
            CreateQuizFormState.topicname,
            CreateQuizFormState.teachername,
            CreateQuizFormState.qname,
            qno, question, option1, option2, option3, option4,ansque);
          if(result==null)
          {
          setState(() {loading=false;});
          Navigator.push(context,
          MaterialPageRoute(builder: (_) => HomePage()));
          showDialog(
            context: context,
            builder:(context)=> AlertDialog(
            content: Text("Successfully create QUIZ"),
            ));
          }      }
    }
  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Question"+" $qno"),
        leading:IconButton(icon: Icon(Icons.arrow_back), onPressed: ()=>{
          if(qno==1)
          {
            Navigator.pop(context)
          }
          else{setState((){qno-=1;})}
          }
          )
      ),
      body: SingleChildScrollView(
              child: new Form(
          key: _formKey1,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
                  new TextFormField(
                            decoration: new InputDecoration(
                              hintText: "Enter Question",
                              labelText: "Question",
                              contentPadding: new EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.white))
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter Question';
                              }
                              return null;
                            },
                            onChanged: (val){
                              setState(() {
                                question=val;
                              });
                            }
                          ),
                          new Padding(padding: const EdgeInsets.only(top: 20.0,left: 10.0,right: 10.0)),
                          new TextFormField(
                            decoration: new InputDecoration(
                              hintText: "Enter option1",
                              labelText: "Option1",
                              contentPadding: new EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.white,width: 10.0))
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter option1';
                              }
                              return null;
                            },
                            onChanged: (val){
                              setState(() {
                                option1=val;
                              });
                            }
                          ),
                          new Padding(padding: const EdgeInsets.only(top: 20.0,left: 10.0,right: 10.0)),
                          new TextFormField(
                            decoration: new InputDecoration(
                              hintText: "Enter option2",
                              labelText: "Option2",
                              contentPadding: new EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.white))
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter option2';
                              }
                              return null;
                            },
                            onChanged: (val){
                              setState(() {
                                option2=val;
                              });
                            }
                          ),
                          new Padding(padding: const EdgeInsets.only(top: 20.0,left: 10.0,right: 10.0)),
                          new TextFormField(
                            decoration: new InputDecoration(
                              hintText: "Enter option3",
                              labelText: "Option3",
                              contentPadding: new EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.white))
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter option3';
                              }
                              return null;
                            },
                            onChanged: (val){
                              setState(() {
                                option3=val;
                              });
                            }
                          ),
                          new Padding(padding: const EdgeInsets.only(top: 20.0,left: 10.0,right: 10.0)),
                          new TextFormField(
                            decoration: new InputDecoration(
                              hintText: "Enter option4",
                              labelText: "Option4",
                              contentPadding: new EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.black))
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter option4';
                              }
                              return null;
                            },
                            onChanged: (val){
                              setState(() {
                                option4=val;
                              });
                            }
                          ),
                        new Padding(padding: const EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0)),
                        Divider(indent: 0.0,endIndent:0.0,color: Colors.black,height: 2.0),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              new Radio(
                              activeColor: Colors.cyan,
                              value: 1,
                              groupValue: ansque,
                              onChanged:(int value){
                                setState(() {
                                  ansque=value;
                                });
                              }
                            ),
                            new Text("A",style: TextStyle(fontSize:18.0,fontWeight: FontWeight.bold),),
                            new Padding(padding: EdgeInsets.only(left:40.0)),
                            new Radio(
                              activeColor: Colors.cyan,
                              value: 2,
                              groupValue: ansque,
                              onChanged:(int value){
                                setState(() {
                                  ansque=value;
                                });
                              }
                            ),
                            new Text("B",style: TextStyle(fontSize:18.0,fontWeight: FontWeight.bold),),
                            new Padding(padding: EdgeInsets.only(left:40.0)),
                            new Radio(
                              activeColor: Colors.cyan,
                              value: 3,
                              groupValue: ansque,
                              onChanged:(int value){
                                setState(() {
                                  ansque=value;
                                });
                              }
                            ),
                            new Text("C",style: TextStyle(fontSize:18.0,fontWeight: FontWeight.bold),),
                            new Padding(padding: EdgeInsets.only(left:40.0)),
                            new Radio(
                              activeColor: Colors.cyan,
                              value: 4,
                              groupValue: ansque,
                              onChanged:(int value){
                                setState(() {
                                  ansque=value;
                                });
                              }
                            ),
                            new Text("D",style: TextStyle(fontSize:18.0,fontWeight: FontWeight.bold),),
                          ],),
                          Divider(indent: 0.0,endIndent:0.0,color: Colors.black,height: 2.0),
                         new Row(children:[
                           Padding(padding: EdgeInsets.only(left: 5.0)),
                           new Text("*Add question press",style: TextStyle(fontSize:15.0,color: Colors.red),),
                           Icon(Icons.add),                           
                         ]),
                         Divider(indent: 0.0,endIndent:0.0,color: Colors.black,height: 2.0),
                         new Row(children:[
                           Padding(padding: EdgeInsets.only(left: 5.0)),
                           new Text("*Last question press",style: TextStyle(fontSize:15.0,color: Colors.red),),
                           Icon(Icons.done),                           
                         ]),
                         Divider(indent: 0.0,endIndent:0.0,color: Colors.black,height: 2.0),
                          new Row(
                            children: <Widget>[
                            new Padding(padding: const EdgeInsets.only(top: 20.0,left: 80.0)),
                            new FlatButton  (
                            onPressed:  questionvalidation,
                            child:new Icon(Icons.add),
                            color: Colors.cyan,
                            textColor: Colors.white70,
                            splashColor: Colors.redAccent,
                          ),
                          new Padding(padding: const EdgeInsets.only(top: 20.0,left: 50.0,right: 10.0)),
                          new FlatButton(
                            onPressed: questionvalidation1,
                            child:new Icon(Icons.done),
                            color: Colors.cyan,
                            textColor: Colors.white70,
                            splashColor: Colors.redAccent,
                          ),
                            ],
                          ),
            ],
        ),
          ),
          ),
      ),
    );
  }
}