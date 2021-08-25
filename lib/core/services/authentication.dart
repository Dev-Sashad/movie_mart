import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_mart/utils/baseModel/baseModel.dart';
import 'package:movie_mart/utils/constants/helpers.dart';
import 'package:movie_mart/utils/constants/locator.dart';
import 'package:movie_mart/utils/dialogeManager/dialogService.dart';
import 'package:movie_mart/utils/router/navigationService.dart';
import 'package:movie_mart/utils/router/routeNames.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ProgressService _progressService = locator<ProgressService>();
  
  final auth = FirebaseAuth.instance;
  //final User user = FirebaseAuth.instance.currentUser;

  //signup User
  signUp(String email, String password, String bussinessName) {
     _progressService.loadingDialog();
  checkSession().then((value) async {
    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          User user = FirebaseAuth.instance.currentUser;
      user
          .updateProfile(displayName: bussinessName)
          .then((value) => user.sendEmailVerification());
      String userIdentity = user.uid;
      _progressService.dialogComplete(response);
      print('Signed up user: $userIdentity');
     _progressService.showDialog(
              title: "SignUp Successful",
              description: "verfication mail has been to this email").then((value){
                 _navigationService.navigateTo(SignInPageRoute);
              } );
       

    }).catchError((msg) {
      if (msg.code == 'weak-password') {
       _progressService.dialogComplete(response);
        print('The password provided is too weak');
        return _progressService.showDialog(
            title:'',
            description: "The password provided is too weak");
      } else if (msg.code == 'email-already-in-use') {
        _progressService.dialogComplete(response);
        print('user already exist');
        return _progressService.showDialog(
          title:'',
          description: "user already exist");
      }
    });
  }
  );
  }


//SignIn User
  login(String email, String password) {
     _progressService.loadingDialog();
  checkSession().then((value) async {
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
      if (error.code == 'user-not-found') {
        _progressService.dialogComplete(response);
        print('No user found for this email');
        _progressService.showDialog(
          title:'',
          description: "user does not exist");
      } else if (error.code == 'wrong-password') {
        _progressService.dialogComplete(response);
        print('Wrong password');
       _progressService.showDialog(
            title:'',
            description: "Wrong password ");
      }
    }).then((user) async {
      print('$value');
        User user = FirebaseAuth.instance.currentUser;
      if (!user.emailVerified) {
        _progressService.dialogComplete(response);
        await user.sendEmailVerification().then((value) {
          // FirebaseAuth.instance.signOut();
          return _progressService.showDialog(
              title: "account not verified",
              description: "verfication mail has been to this email");
        });
      } else {
        _progressService.dialogComplete(response);
        auth.authStateChanges().listen((user) async {
          String userIdentity = user.uid.toString();
          String userName = user.displayName.toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userIdentity', userIdentity);
          prefs.setString('password', password);
          prefs.setString('userName', userName);
        });
          _navigationService.navigateReplacementTo(HomePageRoute);
        
      }
    });
  }
  );
  }

//Forgot password
  forgotpassword(String email) {
    _progressService.loadingDialog();
  checkSession().then((value) async {
    await auth.sendPasswordResetEmail(email: email).catchError((error){
      print(error);
       return _progressService.showDialog(
              title: "",
              description: "invalid");
    });
    _progressService.dialogComplete(response);
    return _progressService.showDialog(
        title: "", description: "password successfully changed");
  }
  );
  }

  getUserId() {
    User user = FirebaseAuth.instance.currentUser;
    var id = user.uid;
    return id;
  }

   getCurrentUser() async {
      FirebaseAuth.instance.authStateChanges().listen((user) async {
          print(user.uid.toString());
          String userIdentity = user.uid.toString();
          String userName = user.displayName.toString();
          String userEmail = user.email.toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userIdentity', userIdentity);
          prefs.setString('userEmail', userEmail);
          prefs.setString('userName', userName);
        return user.uid;
       });   
  }

  resetpassword(String oldPassword, String newPassword) {
     _progressService.loadingDialog();
  checkSession().then((value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String getoldPassword = prefs.getString('password');
    if (getoldPassword != oldPassword) {
      _progressService.dialogComplete(response);
      return _progressService.showDialog(
          title: "", description: "wrong old password");
    } else {
      User user = FirebaseAuth.instance.currentUser;
      await user.updatePassword(newPassword).then((value) {
        _progressService.dialogComplete(response);
        prefs.setString('password', newPassword);
        notifyListeners();
        return _progressService.showDialog(
            title: "", description: "password successfully changed");
      }).catchError((error){
      print(error);
       return _progressService.showDialog(
              title: "",
              description: "invalid");
    });
    }
  }
  );
  }

  signout() {
    return auth.signOut();
  }
}
