import 'package:firebase_auth/firebase_auth.dart';
import 'database.dart';
import 'user.dart';
class AuthService {
  static String error;
  final FirebaseAuth _auth =FirebaseAuth.instance;
  User _userFromFirebaseUser(FirebaseUser user){
      return user != null ? User(uid: user.uid) : null ;
  }
   Future signinwithemailandpassword(String email,String password) async{
    try{
      AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e)
    {
      error=e.toString();
      return null;
    }
  }
  Stream<User> get user{
    return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
  }
  Future signupwithemailandpassword(String username,String email,String name,String contactnum,String password) async {
    try{
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      await DatabaseService(uid: user.uid).updateUserData(username, email, name, contactnum, password);
      return _userFromFirebaseUser(user);
    }
    catch(e)
    {
      return null;
    }
  }
}