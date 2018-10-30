import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'signup_page.dart';

class loginPage extends StatefulWidget {
  static String tag = 'login-page';


  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  
  String _email;
  String _password;
  final mycontroller = TextEditingController();

  GoogleSignIn gSign = new GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  void initState() {
    super.initState();
    mycontroller.addListener(_createNick);
  }


  @override
  void dispose() {
    mycontroller.removeListener(_createNick);
    mycontroller.dispose();
    super.dispose();
  }



  bool _validate() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
  
    final logo = new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,

       child: new Image.asset('assets/firebase_image.png',
         fit:BoxFit.cover,
         width: 60.0,
         height: 100.0,

         gaplessPlayback: true,),

      ),
    );

    final NoAccount = FlatButton(
      child: Text(
        'Don\'t have an account?',
        style: TextStyle(color: Colors.black),

      ),
      onPressed: () {},
    );

    final okbtn = FloatingActionButton(
       child: Text('OK',style: TextStyle( color: Colors.black), textAlign: TextAlign.center,),
       onPressed: (){
          Navigator.pop(context);
          Navigator.push(context,
           MaterialPageRoute(builder: (BuildContext context)=>new SignupPage()
           )
           );
       },
        backgroundColor: Colors.green,
      
    );

    final GoogleBtn = Padding(
       padding: EdgeInsets.only( top: 1.0),
       child: Material( 
         borderRadius: BorderRadius.circular(100.0),
          shadowColor: Colors.black54,
           elevation: 7.0,
               child: MaterialButton(   
             child: Row(
                children: <Widget>[
                   Text('Log IN with :        ', style: TextStyle( color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                   Image(
                      image: AssetImage('assets/google_image.png'),
                       height: 60.0,
                        width: 40.0,
                   )
                ],
                 mainAxisAlignment: MainAxisAlignment.center,
             ),
        minWidth: 200.0,
         height: 50.0,
     color: Colors.white,
      splashColor: Colors.green,
       onPressed: (){
           gSign.signIn().then((result){
              result.authentication.then((googleKey){
                 _auth.signInWithGoogle(
                    idToken: googleKey.idToken,
                     accessToken: googleKey.accessToken,
                 ).then((signedinUser){
                    print('signed in as ${signedinUser.displayName}');
                     Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context)=>new HomePage( gSignIn: gSign, nicky: signedinUser.displayName,)
                      )
                     );
                 }).catchError((e){
                    print((e));
                 }).catchError((e){
                    print((e));
                 }).catchError((e){
                    print((e));
                 });
              });
           });

          
       },
         
     ),
       ),
    );
     
       
    

    final SignUpBtn = Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.red.shade200,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 50.0,

          onPressed: (){
              Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context)=>new SignupPage()
               )
               );
          },
          color: Colors.redAccent,
          child: Text('Sign Up', style: TextStyle(color: Colors.white)),
          splashColor: Colors.green,

        ),
      ),
    );


    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 50.0,

          onPressed: (){
            _validate();
             if(_validate() == true){
            _auth.signInWithEmailAndPassword(
               email: _email,
                password: _password,
            ).then((FirebaseUser user){
              print(('${user.displayName}'));
              Navigator.push(context,
      new MaterialPageRoute(builder: (BuildContext context)=>new HomePage(gSignIn: null,nicky: _createNick())
      )
              );
            }).catchError((e){
                showDialog( context: context, child: 
                  new AlertDialog(
                     title: Text('Sorry, No such Account', style: TextStyle( color: Colors.black),),
                      content: Text('Either Password is wrong or kindly Sign Up for a new account and then Log IN'),
                       actions: <Widget>[
                           okbtn
                       ],
                  )
                 );
              print((e));
            });
             
             }
          },
          
          color: Colors.lightBlueAccent,
          child: Text('Log IN', style: TextStyle(color: Colors.white)),
          splashColor: Colors.green,

        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
        
      ),
      onPressed: () {},
    );

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 32.0),
            new Text(
              'Already have an account?',
              style: TextStyle(color: Colors.black,),
              textAlign: TextAlign.center,

            ),
            SizedBox(height: 7.0,),
             GoogleBtn,

            new Form(
              key: formKey,

                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new TextFormField(
                        decoration: new InputDecoration(

                          hintText: 'Email',
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) =>
                            !val.contains('@') ? 'Invalid Email' : null,
                        onSaved: (val) => _email = val,
                        controller: mycontroller,
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 30.0)),
                      new TextFormField(
                        decoration: new InputDecoration(

                          hintText: "Password",
                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        validator: (val) =>
                            val.length < 6 ? 'Password too short' : null,
                        onSaved: (val) => _password = val,
                      ),
                      SizedBox(height: 20.0),
                      loginButton,
                      forgotLabel,
                      SizedBox(height: 10.0,),
                      NoAccount,

                      SignUpBtn,

                    ],
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }

  String _createNick(){

    String abc = mycontroller.text;
    String nick="";
    for(int i=0;abc[i]!='@';i++){
      nick=nick+abc[i];
    }

    return nick;

  }
}
