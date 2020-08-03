import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:flutter/material.dart';
import 'profilepage.dart';
import 'loginpage.dart';
import 'AvailQuiz.dart';
import 'Quiz.dart';
import 'aboutpage.dart';
import 'Feedbackpage.dart';
import 'loading.dart';
import 'resultpage.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  bool loading=false;
  int _currentIndex=0;
  checkstatus() async{
    setState(() {
      loading=true;
    });
    DataConnectionStatus status= await checkintenet();
    if(status==DataConnectionStatus.connected){
      setState(() {
        loading=false;
        Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) =>QuizPage()),
                );
      });
    } 
    else
    {
      setState(() {
        loading=false;
    showDialog(
      context: context,
      builder:(context)=> AlertDialog(
        title: Text("No Internet"),
        content: Text("check internet connection"),
      ));
      });
    }
  }
 checkintenet() async {
  var listener = DataConnectionChecker().onStatusChange.listen((status) { });
  await Future.delayed(Duration(seconds: 5));
  await listener.cancel();
  return await DataConnectionChecker().connectionStatus;
  }
  @override 
  Widget build(BuildContext context) {
    return  WillPopScope(
          onWillPop:()async{
            MoveToBackground.moveTaskToBack();
            return false;},
          child: loading ? Loading() : Scaffold(
          appBar: AppBar(
            title: Text("Learn with QUIZ"),
            backgroundColor: Colors.cyan,
            ), 
          drawer: Drawer(
            child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(decoration: BoxDecoration(color: Colors.cyan),
                  accountName: Text(''),
                  accountEmail: Text(LoginPageState.email,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black54)),
                  currentAccountPicture: new CircleAvatar(
                    backgroundColor: Colors.cyan[100],
                    child: new Text(LoginPageState.email[0],style: TextStyle(fontSize: 40.0,color: Colors.black54)),
                  ),
                ),
                new ListTile(
                  title:new Text('Add Quiz'),
                  trailing: new Icon(Icons.add_to_photos),
                  onTap: () => {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>CreateQuizForm()),
                  )
                  },
                ),
                new Divider(indent: 5.0,endIndent: 5.0,height: 1.0,),
                new ListTile(
                  title:new Text('Available Quiz'),
                  trailing: new Icon(Icons.event_available),
                  onTap: () => {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>AvailQuiz()),
                  )
                  },
                ),
                new Divider(indent: 5.0,endIndent: 5.0,height: 1.0,),
                new ListTile(
                  title:new Text('Feedback'),
                  trailing: new Icon(Icons.feedback),
                  onTap: ()=>{Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FeedBack()),
                  )},
                ),
                new Divider(indent: 5.0,endIndent: 5.0,height: 1.0,),
                new ListTile(
                  title:new Text('About us'),
                  trailing: new Icon(Icons.android),
                  onTap:  ()=>{Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>AboutPage()),
                  )},
                ),
                new Divider(indent: 5.0,endIndent: 5.0,height: 1.0,),
              ],
            ),
          ),
          body: Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0) ,
                height: MediaQuery.of(context).size.height/3.5,
                width: MediaQuery.of(context).size.width,
                color: Colors.cyan),
              new ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              new Padding(padding: const EdgeInsets.only(top: 140.0)),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                  height: 250.0,
                  child:ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        width:  MediaQuery.of(context).size.height / 2.4,
                        child: Card(
                            child:Wrap(
                              children: <Widget>[
                                new Image(
                                  image: new AssetImage("assets/quiz.jpg"),
                                  height:190,
                                  width: 380,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            )
                        ),
                      ),
                      Container(
                        width: 392.0,
                        child: Card(
                            child:Wrap(
                              children: <Widget>[
                                new Image(
                                  image: new AssetImage("assets/qt.png"),
                                  height:245,
                                  width: 380,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            )
                        ),
                      ),
                      GestureDetector(onTap: ()=>{},
                        child:new Container(
                          width: 392.0,
                          child: Card(
                              child:Wrap(
                                children: <Widget>[
                                  new Image(
                                  image: new AssetImage("assets/ltaq.jpg"),
                                  height:250,
                                  width: 385,
                                  fit: BoxFit.fill,
                                ),
                                ],
                              )
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              new Divider(indent: 20.0,endIndent: 20.0,thickness: 3.0),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                  height: MediaQuery.of(context).size.height/3.5,
                  child:ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      GestureDetector(onTap: ()=>{
                        showDialog(
                          context: context,
                          builder:(context)=> AlertDialog(
                            title: Text("Play With quiz!!!!"),
                            content: Text("Click below on  '+'  icon. "),
                        ))
                      } ,
                      child: Container(
                        width: MediaQuery.of(context).size.width/1.15,
                        child: Card(
                          color: Colors.cyan[200],
                            child:Wrap(
                              children: <Widget>[
                                new Image(
                                  image: new AssetImage("assets/tte.jpg"),
                                  height:MediaQuery.of(context).size.height / 3.6,
                                  width: MediaQuery.of(context).size.width / 1.15,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            )
                        ),
                      ),),
                      new VerticalDivider(indent: 5.0,endIndent: 5.0,thickness: 2.0,),
                      GestureDetector(
                        onTap: ()=>{Navigator.push(context,
                          MaterialPageRoute(builder: (_) =>FeedBack()))},
                        child:new Container(
                          height:MediaQuery.of(context).size.height / 3.6,
                                  width: MediaQuery.of(context).size.width / 1.15,
                          child: Card(
                            color: Colors.cyan[200],
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text("Please Give your",style: TextStyle(fontSize:MediaQuery.of(context).size.width/12.5,fontWeight: FontWeight.bold,color: Colors.pink[200])),
                                  new Text('Valuable feedback',style: TextStyle(fontSize: MediaQuery.of(context).size.width/12.5,fontWeight: FontWeight.bold,color: Colors.lightBlueAccent)),
                                  new Text('Click Me :)',style: TextStyle(fontSize: MediaQuery.of(context).size.width/12.5,fontWeight: FontWeight.bold,color: Colors.black45)),
                                ],
                              )
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              ],
          ),
          Container(
                margin: EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0) ,
                height:  MediaQuery.of(context).size.height/5.5,
                width: MediaQuery.of(context).size.width,
                color: Colors.cyan,
                child:new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     new Image(
                                    image: new AssetImage("assets/ale.png"),
                                    height: MediaQuery.of(context).size.height/2.5,
                                    width: MediaQuery.of(context).size.width/2.5,
                                    fit: BoxFit.fill),
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Text('"Once you stop',style: TextStyle(fontSize: MediaQuery.of(context).size.width/15,fontWeight: FontWeight.bold,color: Colors.black45)),
                          new Text("learning, you",style: TextStyle(fontSize:  MediaQuery.of(context).size.width/15,fontWeight: FontWeight.bold,color: Colors.black45)),
                          new Text('start dying"',style: TextStyle(fontSize:  MediaQuery.of(context).size.width/15,fontWeight: FontWeight.bold,color: Colors.black45)),
                        new Text("~Albert Eistein",style: TextStyle(fontSize: 20.0,)),  
                      ],
                      )
                  ],
                )
                ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.cyan,
            currentIndex: _currentIndex,
            onTap: (int index){
              setState(() {
                _currentIndex=index;
              });
              if(_currentIndex==1)
              {
                checkstatus();
                 _currentIndex=0;
              }
             else if(_currentIndex==2)
              {
                Navigator.push(context,
                MaterialPageRoute(builder: (_) => AvailQuiz()));
                _currentIndex=0;
              }
              else if(_currentIndex==3)
              {
                Navigator.push(context,
                MaterialPageRoute(builder: (_) => ResultPage()));
                _currentIndex=0;
              }
              else if(_currentIndex==4)
              {
                Navigator.push(context,
                MaterialPageRoute(builder: (_) => ProfilePage()));
                _currentIndex=0;
              }

            },
          items: 
          [
         BottomNavigationBarItem(
           icon: new Icon(Icons.home),
           title: new Text('Home'),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.edit),
           title: new Text('Create'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.add_box),
           title: Text('Join')
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.assignment),
           title: new Text('Result'),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.person),
           title: new Text('Profile'),
         ),
       ],),          
       )
    ) ;
  }
}