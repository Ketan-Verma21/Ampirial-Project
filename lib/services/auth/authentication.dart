import 'package:flutter/material.dart';

import '../../views/auth/pages/login_page.dart';
import '../../views/auth/pages/register_page.dart';
class Authentication extends StatefulWidget {
  final bool is_recruiter;
  const Authentication({Key? key, required this.is_recruiter}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showLogin=true;
  void togglePages(){
    setState(() {
      showLogin=!showLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLogin){
      return LoginPage(onTap: togglePages, is_recruiter: widget.is_recruiter,);
    }
    else{
      return RegisterPage(onTap:  togglePages,is_recruiter: widget.is_recruiter,);
    }
  }
}
