import 'package:flutter/material.dart';
import 'loading.dart';
import 'loginpage.dart';
import 'auth.dart';
class SignupPage extends StatefulWidget {
  @override
  SignupPageState createState() => SignupPageState();
}
class SignupPageState extends State<SignupPage> {
  final _signupformKey = GlobalKey<FormState>();
  final AuthService _auth =AuthService();
  static String username=" ";
  static String email=" ";
  static String name=" ";
  static String contactnum=" ";
  static String password=" ";
  bool loading=false;
  Future<dynamic> signupvalidation() async {
    if(_signupformKey.currentState.validate()){
      setState(()=>{loading=true});
        {
          _signupformKey.currentState.save();
        dynamic result = await _auth.signupwithemailandpassword(username,email, name, contactnum, password);
        if(result == null)
        { 
          setState(() {
            loading=false;
          });
           showDialog(
            context: context,
            builder:(context)=> AlertDialog(
            content: Text('Already register'),
            ));
        }
        else
        {
          setState(() {
            loading=false;
          });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>LoginPage()),
        );
      } 
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.black54,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/eduback.jpg"),
            fit: BoxFit.cover,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Form(
                key: _signupformKey,
                child: Theme(
                  data: new ThemeData(
                      brightness: Brightness.dark,
                      primarySwatch: Colors.teal,
                      inputDecorationTheme: new InputDecorationTheme(
                          labelStyle: new TextStyle(
                              color: Colors.teal, fontSize: 20.0
                          )
                      )
                  ),
                  child: SingleChildScrollView(
                                      child: Container(
                      padding: const EdgeInsets.all(40.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new TextFormField(
                            decoration: new InputDecoration(
                              hintText : "Username",
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter username';
                              }
                              return null;
                            },
                            onChanged: (val){
                              setState(() {
                               username=val;
                              });
                            },
                          ),
                          new TextFormField(
                            decoration: new InputDecoration(
                              hintText : "Email",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Email Id';
                              }
                              return null;
                            },
                            onChanged: (val){
                              setState(() {
                               email=val;
                              });
                            }
                          ),
                          new TextFormField(
                            decoration: new InputDecoration(
                              hintText : "Full Name",
                            ),
                    
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter full Name';
                              }
                              return null;
                            },
                            onChanged: (val){
                              setState(() {
                                name=val;
                              });
                            }
                          ),
                          new TextFormField(
                            decoration: new InputDecoration(
                              hintText : "Contact No.",
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty || value.length < 10 || value.length > 10) {
                                return 'Enter valid contact number';
                              }
                              return null;
                            },
                            onChanged: (val){
                              setState(() {
                                contactnum=val;
                              });
                            }
                          ),
                          new TextFormField(
                            decoration: new InputDecoration(
                              hintText : "Password",
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            
                            validator: (value) {
                              if (value.isEmpty || value.length < 6 || value.length > 8) {
                                return 'Enter minimum 6+ length password';
                              }
                              return null;
                            },
                            onChanged: (val){
                              setState(() {
                                password=val;
                              });
                            }
                          ),
                          new Padding(padding: const EdgeInsets.only(top: 20.0)),
                          new FlatButton(
                            child: new Text("Sign Up"),
                            color: Colors.cyan,
                            textColor: Colors.white70,
                            splashColor: Colors.redAccent,
                            onPressed: signupvalidation,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      )
    );
  }
}
