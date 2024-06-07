import 'package:flutter/material.dart';
import 'package:recruit_portal/services/auth/auth_gate.dart';
import 'package:recruit_portal/views/auth/components/custom_button.dart';
class Selection extends StatelessWidget {
  const Selection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color=Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: color.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(Icons.person,size: 60,color:color.primary,),
            SizedBox(height: 50,),
            Text("Identify Yourself",style: TextStyle(
                color: color.primary,
                fontSize: 16
            ),),
            SizedBox(height: 25,),
            SizedBox(

              child: CustomButton(
                text: 'Recruiter',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthGate(is_recruiter: true,)));
                },

              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              // width: 100,
              child: CustomButton(
                text: 'Applicant',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthGate(is_recruiter: false,)));
                },

              ),
            )
          ],
        ),
    );
  }
}
