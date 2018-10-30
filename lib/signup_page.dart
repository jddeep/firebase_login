import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/usermanagement.dart';
import 'home_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  String _email;
  String _password;

  final mycontroller2 = new TextEditingController();
  final formKey = new GlobalKey<FormState>();

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
 void dispose(){
    super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
         padding: EdgeInsets.all(25.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
                      new Form( 
                         key: formKey,
                         child: new Container(
                           child: Column(
                              children: <Widget>[
                      TextFormField(
                         
                  decoration: InputDecoration(hintText: 'Email',
                  labelText: "Enter Email ID",
                   labelStyle:  TextStyle( color: Colors.blue, fontSize: 26.0)),
                  controller: mycontroller2,
                  keyboardType: TextInputType.emailAddress,
                          validator: (val) => !val.contains('@')?'Invalid Email':null,
                          onSaved: (val) => _email = val,
                  
                    
                  ),
              SizedBox(height: 15.0),
                     TextFormField(
                         
                  decoration: InputDecoration(hintText: 'Password',
                  labelText: "Enter Password",
                   labelStyle:  TextStyle( color: Colors.blue, fontSize: 26.0)),
                   obscureText: true,
                  keyboardType: TextInputType.text,
                          validator: (val) => val.length<6?'Password too short':null,
                          onSaved: (val) => _password = val,
                  
                    
                  ),
           
                              ],
                           ),
                         ),
                      ),
              SizedBox(height: 40.0),
              MaterialButton(
                 minWidth: 200.0,
                  height: 50.0,
                child: Text('SignUp'),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: () {
                   _validate();
                    if(_validate() == true){
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                     email: _email,
                      password: _password
                  ).then((signedInUser){
                     UserManagement().storeNewUser(signedInUser, context);
                      Navigator.pop(context);
                       Navigator.push(context,
      new MaterialPageRoute(builder: (BuildContext context)=>new HomePage(gSignIn: null,nicky: _createNick2())

      )
      );
                  }
                  ).catchError((e){
                    print(e);
                  }
                  );
                    }
                },
              ),
                      
           ],
         ),
        ) ,
        )

      
    );
  }

  
    String _createNick2(){

    String abc = mycontroller2.text;
    String nick="";
    for(int i=0;abc[i]!='@';i++){
      nick=nick+abc[i];
    }

    return nick;

  }

}