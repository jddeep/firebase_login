import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';




class HomePage extends StatelessWidget {
  static String tag = 'home-page';
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  var gSignIn;
  String nicky;

  HomePage({Key key, this.gSignIn, this.nicky}): super(key: key);

  void _signOut(){
    if(gSignIn!=null) {
      gSignIn.signOut();
      Navigator.pop(scaffoldKey.currentContext);
      Navigator.pushReplacement(scaffoldKey.currentContext,
          MaterialPageRoute( builder: (BuildContext)=>new loginPage()
          )
        );
      print("User signed out");
    }else{
      Navigator.pop(scaffoldKey.currentContext);
        Navigator.pushReplacementNamed(scaffoldKey.currentContext, '/loginpage');
      print("User signed out");
    }

  }

  

  AssetImage _backImage(){

    if(nicky[0]=='j'){
      return new AssetImage('assets/hi_there.gif');
    }else{
      return new AssetImage('assets/hi_there.gif');
    }
  }


  @override
  Widget build(BuildContext context) {

    final jddeep = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
            radius: 72.0,
          backgroundColor: Colors.transparent,
          backgroundImage: _backImage(),

        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
          'Hi  $nicky !',
          style: TextStyle(fontSize: 30.0, color: Colors.white),
      ),
    );

    final message = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '#Tester by JD is a FireBase login and signUp application which creates a UserId and Database in FireBase for the application using their Google account or the Email Id provided.',

        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );

    final signoutbutton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),

      child: Material(

        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 50.0,

          onPressed: (){
            _signOut();
            Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context)=> new loginPage()
              )
             );
          },
          color: Colors.yellowAccent,
          child: Text('Sign OUT', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          splashColor: Colors.redAccent,

        ),
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ])
      ),
      child: Column(children: <Widget>[jddeep,welcome,message,
      new Padding(padding: EdgeInsets.only(top: 48.0)),signoutbutton
      ],

      ),
    );
    return Scaffold(
      key: scaffoldKey,
      body: body,
    );
  }

}
