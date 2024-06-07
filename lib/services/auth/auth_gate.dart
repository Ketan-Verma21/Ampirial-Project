import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:recruit_portal/services/auth/selection.dart';
import 'package:recruit_portal/views/home/pages/receipient_page.dart';
import 'package:recruit_portal/views/home/pages/recruiter_page.dart';
import 'authentication.dart';
import '../../../models/auth/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthGate extends ConsumerStatefulWidget {
  final bool is_recruiter;
  const AuthGate({Key? key, required this.is_recruiter}) : super(key: key);

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  void showSnackbar(BuildContext context, SnackBar snackBar) {
    Future.delayed(Duration.zero, () {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(child: Lottie.asset("/lottie/classic.json")),
            );
          } else if (snapshot.hasData) {
            User? user = snapshot.data;
            if (user != null) {
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(user.uid)
                    .get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                        child: Lottie.asset("/lottie/classic.json"),
                      ),
                    );
                  } else if (userSnapshot.hasData) {
                    var userData = userSnapshot.data;
                    if (userData != null) {
                      bool isRecruiter = userData['is_recruiter'];
                      Future(() { ref.read(userProvider.notifier).update((state) => UserModel(
                        uid: user.uid,
                        name: userData['name'],
                        email: userData['email'],
                        isRecruiter: isRecruiter,
                      ));});

                      if (isRecruiter == false && widget.is_recruiter == false) {
                        return ReceipientPage(); // Show ReceipientPage if is_recruiter is false
                      } else if (isRecruiter == true && widget.is_recruiter == true) {
                        return RecruiterPage(); // Show RecruiterPage if is_recruiter is true
                      } else {
                        bool x = widget.is_recruiter;
                        final snackBar = SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'On Snap!',
                            message: "You are " + (!x ? "a Recruiter" : "not a Recruiter"),
                            contentType: ContentType.failure,
                          ),
                        );
                        showSnackbar(context, snackBar);

                        return Selection();
                      }
                    }
                  }
                  return Authentication(is_recruiter: widget.is_recruiter,); // Fallback to Authentication page if something goes wrong
                },
              );
            }
          }
          return Authentication(is_recruiter: widget.is_recruiter,);
        },
      ),
    );
  }
}
