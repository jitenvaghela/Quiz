import 'package:flutter/material.dart';
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About us"),backgroundColor: Colors.cyan,),
      body: Stack(
        children:[
          new Column(
            children:[
              new Container(
              margin: EdgeInsets.symmetric(vertical:30.0,horizontal: 20.0),
              height: 180.0,
              width: 390.0,
              decoration: BoxDecoration(
              color: Colors.cyan,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ) 
          ),
          child: new Column(
            children:[
              new Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Padding(padding: EdgeInsets.symmetric(vertical:15.0)),
                new Text('Features',style: TextStyle(fontSize: 23.0,fontWeight: FontWeight.bold,color: Colors.grey[200])),
                ],),
              new Divider(indent: 15.0,endIndent: 15.0,thickness: 2.0,height: 5.0,color: Colors.black45),
              new Row(
                children:[
                  new Padding(padding: EdgeInsets.symmetric(vertical:15.0,horizontal:5.0)),
                  new Icon(Icons.arrow_right,size: 35.0,),
                  new Text("Play QUIZ",style: TextStyle(fontSize: 20.0,color: Colors.black54)),
                ]),
                new Row(
                children:[
                  new Padding(padding: EdgeInsets.symmetric(vertical:15.0,horizontal:5.0)),
                  new Icon(Icons.arrow_right,size: 35.0,),
                  new Text("No instructor needed",style: TextStyle(fontSize: 20.0,color: Colors.black54)),
                ]),
                new Row(
                children:[
                  new Padding(padding: EdgeInsets.symmetric(vertical:15.0,horizontal:5.0)),
                  new Icon(Icons.arrow_right,size: 35.0,),
                  new Text("Quiz results insight in audience",style: TextStyle(fontSize: 20.0,color: Colors.black54)),
                ]),
                new Row(
                children:[
                  new Padding(padding: EdgeInsets.symmetric(vertical:15.0,horizontal:5.0)),
                  new Icon(Icons.arrow_right,size: 35.0,),
                  new Text("Improve knowledge",style: TextStyle(fontSize: 20.0,color: Colors.black54)),
                ]),
              ]
          ),
          ),
              new Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
              height: 251.0,
              width: 390.0,
              decoration: BoxDecoration(
              color: Colors.cyan,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
              Radius.circular(25.0)
            ) 
          ),
          child: new Column(
            children:[
              new Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Padding(padding: EdgeInsets.symmetric(vertical:15.0)),
                new Text('Developer Contact',style: TextStyle(fontSize: 23.0,fontWeight: FontWeight.bold,color: Colors.grey[200])),
                ],),
              new Divider(indent: 15.0,endIndent: 15.0,thickness: 2.0,height: 5.0,color: Colors.black45),
              new ListTile(
                title:Text('Email'),
                subtitle: Text('quizhelp123@gmail.com'),
                leading: new Icon(Icons.mail_outline,size: 35.0),
              ),
              new Divider(indent: 15.0,endIndent: 15.0,thickness: 1.0,height: 0.0,color: Colors.black38),
              new ListTile(
                title:Text('Address'),
                subtitle: Text('Gujarat, India'),
                leading: new Icon(Icons.location_on,size: 35.0),
              ),
              new Divider(indent: 15.0,endIndent: 15.0,thickness: 1.0,height: 0.0,color: Colors.black38),
              new ListTile(
                title:Text('Privacy Policy'),
                subtitle: Text('-'),
                leading: new Icon(Icons.verified_user,size: 35.0),
              ),
          ]
          ),
          ),
              new Container(
              margin: EdgeInsets.symmetric(vertical:30.0,horizontal: 20.0),
              height: 90.0,
              width: 390.0,
              decoration: BoxDecoration(
              color: Colors.cyan,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ) 
          ),
          child: new Column(
            children:[
              new Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Padding(padding: EdgeInsets.symmetric(vertical:15.0)),
                new Text('App info',style: TextStyle(fontSize: 23.0,fontWeight: FontWeight.bold,color: Colors.grey[200])),
                ],),
              new Divider(indent: 15.0,endIndent: 15.0,thickness: 2.0,height: 5.0,color: Colors.black45),
              new Row(
                children:[
                  new Padding(padding: EdgeInsets.symmetric(vertical:15.0,horizontal:5.0)),
                  new Icon(Icons.chevron_right,size: 35.00,color: Colors.black54,),
                  new Text("Version",style: TextStyle(fontSize: 20.0,color: Colors.black54)),
                  new Padding(padding: EdgeInsets.only(left:210)),
                  new Text("1.0",style: TextStyle(fontSize: 20.0,color: Colors.black87)),
                ]),
              ]
          ),
          ),
            ]
          )
        ]
      ),
      
    );
  }
}