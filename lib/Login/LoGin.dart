import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email=TextEditingController();
    TextEditingController password=TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN",
          style: TextStyle(
              fontSize: 20,
              color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black12,),
      body: Column(
        children: [
          SizedBox(height: 100,),
          Text(" WELCOME !!",style: TextStyle(fontSize: 30,color: Colors.white),),SizedBox(height: 140,),
          Container(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text("Email"),
                SizedBox(height :5,),
                Container(
                  width: 400,
                  height: 60,
                  child: TextField(

                    controller: email,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(39),
                            borderSide: BorderSide(
                              color: Colors.white,
                            )
                      ),
                      hintText: "Enter your email",
                    ),
                  ),
                ),

                SizedBox(height:10),
                Text("Password"),
                SizedBox(height :5,),
                Container(
                  width: 400,
                  height: 60,
                  child: TextField(
                    controller: password,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                     border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(23),
                             borderSide: BorderSide(
                                 color: Colors.white,)),
                      hintText: "Enter your password",

                    ),
                  ),
                ),
                SizedBox(height:10),
                Container(
                  width: 400,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: (){},
                      child: Text("Login",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black),),style: ElevatedButton.styleFrom(backgroundColor: Colors.white),),
                )


            ],),
          ),
        ],
      ),
    );
  }
}
