import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/auth/auth_service.dart';
import '../components/custom_button.dart';
import '../components/custom_text_feild.dart';

class LoginPage extends ConsumerWidget {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final void Function()? onTap;
  final bool is_recruiter;
  LoginPage({Key? key,required this.onTap, required this.is_recruiter}) : super(key: key);
  void login(BuildContext context,WidgetRef ref) async{
    final authService =  AuthService();
      try{
        await authService.signInWithEmailPassword(_emailController.text, _passwordController.text);
      }catch(e){
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message:
            e.toString(),


            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
  }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final color=Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: color.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.message,size: 60,color:color.primary,),
              SizedBox(height: 50,),
              Text("Welcome Back "+(is_recruiter?"Recuiter, ":"Applicant,")+ " you've been missed",style: TextStyle(
                color: color.primary,
                fontSize: 16
              ),),
              SizedBox(height: 25,),
              CustomTextField(text: "Email", pass: false, controller: _emailController,),
              SizedBox(height: 10,),
              CustomTextField(text: "Password", pass: true, controller: _passwordController,),
              SizedBox(height: 25,),
              CustomButton(text: "Login", onTap: ()=>login(context,ref)),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  is_recruiter?Text("Didn't made is yet? ",
                style: TextStyle(
                    color: color.primary
                ),):Text("Not a member? ",
                  style: TextStyle(
                    color: color.primary
                  ),),
                  GestureDetector(
                    onTap: onTap,
                    child: Text("Register Now",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color.primary
                    ),),
                  ),

                ],

              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
