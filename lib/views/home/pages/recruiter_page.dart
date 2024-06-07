import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recruit_portal/services/auth/auth_gate.dart';
import 'package:recruit_portal/views/home/pages/displayOffer.dart';
import '../../../models/offer/offer.dart';
import '../components/custom_drawer.dart';
import 'new_offer_page.dart';

class RecruiterPage extends ConsumerWidget {
  const RecruiterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser; // Get the current user from Firebase Authentication
    var ud=ref.watch(userProvider);
    final color=Theme.of(context).colorScheme;
    return ud==null?Scaffold(
      body: Center(
        child: SizedBox(
          width: 100,
            height: 100,
            child: Lottie.asset("/lottie/plane.json")),
      ),
    ):Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text("R E C R U I T E R"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      drawer: const CustomDrawer(),
      body: user != null
          ? Padding(
            padding: const EdgeInsets.only(top:25.0,left:15,right:15),
            child: _buildOfferList(user.uid,color),
          )
          : Center(child: CircularProgressIndicator()), // Show loading indicator if user is not yet authenticated
      floatingActionButton: FloatingActionButton(
        tooltip: "Create a new Offer",
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => NewOfferPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildOfferList(String recruiterId,ColorScheme color) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('offers').where('recruiterId', isEqualTo: recruiterId).snapshots(), // Listen to changes in offer collection for the current recruiter
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Show loading indicator while data is being fetched
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Show error message if there's an error
        }

        final offers = snapshot.data!.docs; // Extract documents from the snapshot
        if (offers.isEmpty) {
          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeIn(
                    child: SizedBox(
                      width:200,
                      height: 200,
                      child: Lottie.asset("/lottie/1.json",
                          animate: offers.isNotEmpty? false:true),
                    ),
                  ),
                  FadeInUp(
                      from: 30,
                      child: const Text("There are no offers, Create new!"))
                ],),
          ); // Show message if there are no offers
        }

        return ListView.builder(
          itemCount: offers.length,
          itemBuilder: (context, index) {
            final offer = offers[index];
            final status = offer['status'] as String; // Get the status field from the offer document

            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ListTile(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>DisplayOffer(
                      offer: Offer(
                          recruiterId: offer['recruiterId'],
                          recruiterEmail: offer['recruiterEmail'],
                          applicantName: offer['applicantName'],
                          position: offer['position'],
                          salary: offer['salary'],
                          status: offer['status'],
                          applicantEmail: offer['applicantEmail'],
                          is_new: offer['is_new']),
                      docId: offer.id.toString(),
                      is_recruiter: true)));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Icon(Icons.person,color: color.inversePrimary,),
                ),
                tileColor: color.secondary,
                hoverColor: color.tertiary,
                title: Text(offer['position']),
                subtitle: Text(offer['applicantName']),
                trailing: _buildStatusWidget(status),

              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStatusWidget(String status) {
    Color statusColor;
    IconData statusIcon;
    switch (status) {
      case 'accepted':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle_outline;
        break;
      case 'rejected':
        statusColor = Colors.red;
        statusIcon = Icons.cancel_outlined;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.pending_outlined;
    }

    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        statusIcon,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}


