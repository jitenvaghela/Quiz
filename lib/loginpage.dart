import 'package:flutter/material.dart';
import 'Homepage.dart';
import 'loading.dart';
import 'signup.dart';
import 'auth.dart';
class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}
class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth =AuthService();
  bool loading=false;
  static String email='';
  static String password='';
  Future loginvalidation() async {
    if(_formKey.currentState.validate()){
      setState(() {
        loading=true;
      });
        dynamic result = await _auth.signinwithemailandpassword(email,password);
        if(result == null)
        {
          setState(() {
            loading=false;
            showDialog(
            context: context,
            builder:(context)=> AlertDialog(
            content: Text(AuthService.error.substring(18,38)),
            ));
          });
        }
        else
        {
          setState(() {
            loading=false;
          });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>HomePage()),
        );
      }
           }
           return null;
  }
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;
  @override
  void initState(){
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 500)
    );
    _iconAnimation=new CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.bounceOut
    );
    _iconAnimation.addListener(()=>this.setState((){}));
    _iconAnimationController.forward();
  }
  
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
              new Image(
                image: new AssetImage("assets/quizicon.png"),
                height:_iconAnimation.value * 100,
                width: _iconAnimation.value * 100,
                fit: BoxFit.fill,
                ),
              new Form(
                key: _formKey,
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
                              hintText : "Email",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter Email Id';
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
                              hintText : "Password",
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            validator: (value) => value.length < 6 ? 'Enter a 6+ character or number ' :  null ,
                            onChanged: (val){
                              setState(() {
                                password=val;
                              });
                            }
                          ),
                          new Padding(padding: const EdgeInsets.only(top: 20.0)),
                          new FlatButton(
                            onPressed: loginvalidation,
                            child: new Text("Login"),
                            color: Colors.cyan,
                            textColor: Colors.white70,
                            splashColor: Colors.redAccent,
                          ),
                          new FlatButton(
                            onPressed: ()=>{
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupPage()),
                            )
                            },
                            child: new Text("Sign Up"),
                            color: Colors.cyan,
                            textColor: Colors.white70,
                            splashColor: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ), 
    );
  }
}