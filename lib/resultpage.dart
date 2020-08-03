import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'loading.dart';
class ResultPage extends StatefulWidget {
  @override
  ResultPageState createState() => ResultPageState();
}
class ResultPageState extends State<ResultPage> {
  String quizname;
  String qe;
  Widget _buildListItem(BuildContext context,DocumentSnapshot resultinfo)
  {
    return Container(
          color: Colors.cyan[100],
          margin: EdgeInsets.all(5.0),
          child:Card(
            margin: EdgeInsets.all(2.0),
                child: ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.cyan,radius: 20,child: new  Text(resultinfo.data['quizname'][0]??''.toUpperCase()),),
                  title:new Text(resultinfo.data['quizname']??'',style: TextStyle(fontWeight:FontWeight.w700,fontSize: 20.0),),
                  subtitle: new Text(resultinfo.data['email']??''),
                  trailing: Text(resultinfo['result'].toString()+" / "+resultinfo['lastqueno'],style: TextStyle(fontSize: 20.0)),
        )
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      backgroundColor: Colors.cyan[100],
      appBar:AppBar(title: Text('Result'),leading: Icon(Icons.find_in_page),backgroundColor: Colors.cyan),
      body: StreamBuilder(
        stream: Firestore.instance.collection('quizresult').orderBy('timestamp' , descending: true).snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData) return Loading();
          return ListView.builder(
            itemExtent: 80.0,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,index)=> _buildListItem(context,snapshot.data.documents[index]),
          );
        }
        ),
    );
  }
  }