import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: Center(  
          child: Column(   
             mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,           
            children: <Widget>[  
              Image.asset('assets/images/mafdss.png'),  
              const CircularProgressIndicator()
            ],  
          ),  
        )
    );
  }
  
}

