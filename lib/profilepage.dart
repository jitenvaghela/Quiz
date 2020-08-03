import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Feedbackpage.dart';
import 'loading.dart';
import 'loginpage.dart';
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        leading: Icon(Icons.account_box),
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(icon: Icon(Icons.feedback), onPressed:()=>{
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FeedBack()),
                )
          })
        ],
      ),
      body:ListView(
        children:[
          Container(
            height: MediaQuery.of(context).size.height/4,
            child: Profile()
          ),
          new Divider(indent: 20.0,endIndent: 20.0,thickness: 3.0),
          new Text('    My result',style: TextStyle(fontSize: MediaQuery.of(context).size.width/15.5,fontWeight: FontWeight.bold,color: Colors.black54)),
          new Divider(indent: 20.0,endIndent: 20.0,thickness: 3.0),
          Container(
            height: MediaQuery.of(context).size.height/3,
            child:ProfileResult()
          )
        ]
      )
    );
  }
}
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
    Widget _buildListItem(BuildContext context,DocumentSnapshot person)
  {
    return Container(
              height:  MediaQuery.of(context).size.height/5,
              width:  MediaQuery.of(context).size.width/2,
              margin: EdgeInsets.symmetric(vertical:30.0,horizontal: 20.0),
              decoration: BoxDecoration(
              color: Colors.cyan[300],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ) 
          ),
          child: Column(
            children: [
              new Row(
                children: [
                  new Padding(padding: EdgeInsets.symmetric(horizontal: 5,vertical:20.0)),
                  new Icon(Icons.account_circle,color:Colors.grey[300],),
                  new Padding(padding: EdgeInsets.only(left: 10.0)),
                  new Text(person['name'])
                ]
              ),
              new Row(
                children:[
                  new Padding(padding: EdgeInsets.symmetric(horizontal:5.0,vertical: 20.0)),
                  new Icon(Icons.mail_outline,color:Colors.grey[300],),
                  new Padding(padding: EdgeInsets.only(left: 10.0)),
                  new Text(person['email'])
                ]
              ),
              new Row(
                children: [
                  new Padding(padding: EdgeInsets.symmetric(horizontal:5.0,vertical: 20.0)),
                  new Icon(Icons.contact_phone,color:Colors.grey[300],),
                  new Padding(padding: EdgeInsets.only(left: 10.0)),
                  new Text(person['contactnum'])  
                ]
              ),
              new Row(
                children: [
                  new Padding(padding: EdgeInsets.symmetric(horizontal:5.0,vertical: 20.0)),
                  new Icon(Icons.lock_outline,color:Colors.grey[300],),
                  new Padding(padding: EdgeInsets.only(left: 10.0)),
                  new Text(person['password']),  
                ]
              ),
            ],
          ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(     
      body:StreamBuilder(
        stream: Firestore.instance.collection('data').where('email', isEqualTo:LoginPageState.email).snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData) return Loading();
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context,index)=> _buildListItem(context,snapshot.data.documents[index]),
          );
        }
        )
    );
  }
}
class ProfileResult extends StatefulWidget {
  @override
  _ProfileResultState createState() => _ProfileResultState();
}
class _ProfileResultState extends State<ProfileResult> {
    Widget _buildListItem(BuildContext context,DocumentSnapshot result)
  {
      return Container(
        height:  MediaQuery.of(context).size.height,
              width:  MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical:10.0,horizontal: 20.0),
              decoration: BoxDecoration(
              color: Colors.cyan,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ) 
          ),
          child:Card(
            margin: EdgeInsets.all(2.0),
                child: ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.cyan,radius: 20,child: new  Text(result.data['quizname'][0]??''.toUpperCase()),),
                  title:new Text(result.data['quizname']??'',style: TextStyle(fontWeight:FontWeight.w700,fontSize: 20.0),),
                  trailing: Text(result['result'].toString()+" / "+result['lastqueno'],style: TextStyle(fontSize: 20.0)),
        )
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: StreamBuilder(
          stream: Firestore.instance.collection('quizresult').where('email', isEqualTo:LoginPageState.email).snapshots(),
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