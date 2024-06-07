import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:recruit_portal/models/offer/offer.dart';
import 'package:recruit_portal/views/home/pages/displayOffer.dart';
import '../../../services/auth/auth_gate.dart';
import '../components/custom_drawer.dart';
class ReceipientPage extends ConsumerWidget {
  const ReceipientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // final user = FirebaseAuth.instance.currentUser; // Get the current user from Firebase Authentication
    var ud=ref.watch(userProvider);
    final color=Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("A P P L I C A N T"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.grey,


        ),
        drawer: const CustomDrawer(),
        body: ud != null
            ? Padding(
          padding: const EdgeInsets.only(top:25.0,left:15,right:15),
          child: _buildOfferList(ud.email,color),
        )
            : Center(child: CircularProgressIndicator()),
    );
  }
  Widget _buildOfferList(String applicantEmail,ColorScheme color) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('offers').where('applicantEmail', isEqualTo: applicantEmail).snapshots(), // Listen to changes in offer collection for the current recruiter
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
                    child: const Text("There are no offers for you!"))
              ],),
          ); // Show message if there are no offers
        }

        return ListView.builder(
          itemCount: offers.length,
          itemBuilder: (context, index) {
            final offer = offers[index];
            bool status = offer['is_new'] ; // Get the status field from the offer document

            return ListTile(
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
              subtitle: Text("₹"+offer['salary']),
              trailing: _buildStatusWidget(status),
              onTap: () {
                // print(offer.id.toString());
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
                    docId: offer.id.toString(), is_recruiter: false,

                 )));
              },
            );
          },
        );
      },
    );
  }

  Widget _buildStatusWidget(bool status) {
    Color statusColor;
    IconData statusIcon;
    switch (status) {
      case true:
        return SizedBox(
          height: 30,
          width: 30,
          child: Lottie.asset("/lottie/fire.json"),
        );


      default:
        statusColor = Colors.grey;
        statusIcon = Icons.mark_email_read;
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
