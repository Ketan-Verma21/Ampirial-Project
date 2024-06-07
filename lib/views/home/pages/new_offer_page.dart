import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recruit_portal/models/auth/user_model.dart';
import 'package:recruit_portal/services/auth/auth_gate.dart';
import 'package:recruit_portal/views/auth/components/custom_button.dart';
import 'package:recruit_portal/views/auth/components/custom_text_feild.dart';

class NewOfferPage extends ConsumerWidget {
  final TextEditingController moneyController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  NewOfferPage({Key? key}) : super(key: key);

  Future<void> sendOffer(BuildContext context, UserModel userModel) async {
    var data = _firestore.collection("Users").where('email', isEqualTo: emailController.text);
    var querySnapshot = await data.get();

    if (querySnapshot.docs.isNotEmpty) {
      _firestore.collection("offers").doc().set({
        'recruiterId': userModel.uid,
        'recruiterEmail': userModel.email,
        'applicantName': nameController.text,
        'position': positionController.text,
        'salary': moneyController.text,
        'status': 'pending',
        'applicantEmail': emailController.text,
        'is_new':true
      });

      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Bingo!',
          message: "Offer Generated",
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      Navigator.pop(context);
    } else {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Oh Snap!',
          message: "The Credentials do not match",
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userModel = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "N E W  O F F E R",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(text: "Name", pass: false, controller: nameController),
            SizedBox(height: 15),
            CustomTextField(text: "Position", pass: false, controller: positionController),
            SizedBox(height: 15),
            CustomTextField(text: "Salary", pass: false, controller: moneyController),
            SizedBox(height: 15),
            CustomTextField(text: "Email", pass: false, controller: emailController),
            SizedBox(height: 25),
            CustomButton(
              text: "Send",
              onTap: () {
                if (userModel != null) {
                  sendOffer(context, userModel);
                } else {
                  final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Error',
                      message: "User not authenticated",
                      contentType: ContentType.failure,
                    ),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
