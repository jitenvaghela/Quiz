import 'package:flutter/material.dart';
import 'loading.dart';
import 'loginpage.dart';
import 'database.dart';
import 'Homepage.dart';
class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final _feedbackformKey = GlobalKey<FormState>();
  final DatabaseService _feedbackdata= DatabaseService();
  String fname=" ";
  String fmail=" ";
  String fidea=" ";
  bool loading=false;
  Future<dynamic> feedbackvalidation() async {
          if(_feedbackformKey.currentState.validate()){
            setState(() {
              loading=true;
            });
            _feedbackformKey.currentState.save();
            dynamic result= await _feedbackdata.feedbackcreate(LoginPageState.email,fname, fmail, fidea);
            if(result==null)
            {
              setState(() {
                loading=false;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HomePage()));
                showDialog(
                 context: context,
                builder:(context)=> AlertDialog(
                title: Text("Thank you"),
                content: Text("For your feedback")));             
            }
      }
  }
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
          appBar: AppBar(
            title: Text('Feedback'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back), onPressed: ()=>{Navigator.pop(context)}
          ),
          backgroundColor: Colors.cyan,
          ),
          body:SingleChildScrollView(
                      child: new Stack(
             children: <Widget>[
               new Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:[
                   new Form(
                     key: _feedbackformKey,
               child: new Container(
              color: Colors.cyan[50],
              margin: EdgeInsets.symmetric(vertical: 40.0,horizontal: 40.0),
              height: 420.0,
              width: 380.0,
              padding: const EdgeInsets.all(10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    new TextFormField(
                            decoration: new InputDecoration(
                              labelText: "Name",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan
                            )
                            ), 
                          ),
                          keyboardType: TextInputType.text,
                          validator: (String value) {
                          if (value.isEmpty) {
                          return 'Enter your name';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        fname = value;
                      }
                    ),
                    new Padding(padding: const EdgeInsets.only(top:20.0)),
                    new TextFormField(
                            decoration: new InputDecoration(
                              labelText: "Email",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan
                            )
                            ), 
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (String value) {
                          if (value.isEmpty) {
                          return 'Enter your Email';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        fmail = value;
                      }
                    ),
                    new Padding(padding: const EdgeInsets.only(top:20.0)),
                    new TextFormField(
                            maxLines: 5,
                            decoration: new InputDecoration(
                              labelText: "Describe your feedback",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan
                            )
                            ), 
                          ),
                          keyboardType: TextInputType.text,
                          validator: (String value) {
                          if (value.isEmpty) {
                          return 'Please share your Feedback!!!';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        fidea = value;
                      }
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 20.0) ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new FlatButton(
                            child: new Text("Submit"),
                            color: Colors.cyan,
                            textColor: Colors.white70,
                            splashColor: Colors.redAccent,
                            onPressed: feedbackvalidation,
                          ),
                      ]
                    )
                    ]
                )
                )
            ),
                 ]),
               
             ]
             ),
          ),
    );
  }
}