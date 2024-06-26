import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_portal/views/auth/components/custom_button.dart';
import 'package:recruit_portal/views/auth/components/custom_text_feild.dart';

import '../../../models/offer/offer.dart';

class DisplayOffer extends StatefulWidget {
  final Offer offer;
  final String docId;
  final bool is_recruiter;

  DisplayOffer({Key? key, required this.offer, required this.docId, required this.is_recruiter}) : super(key: key);

  @override
  State<DisplayOffer> createState() => _DisplayOfferState();
}

class _DisplayOfferState extends State<DisplayOffer> {
  final _firestore = FirebaseFirestore.instance;
  TextEditingController nameController =  TextEditingController();
  Future<void> setter(String status) async {

    await _firestore.collection("offers").doc(widget.docId).update({
      'status': status,
      'is_new': false,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.is_recruiter);
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "D E T A I L S",

        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:40,right: 16.0,left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(

                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShowTile(title: "Applicant Name", subtitle: widget.offer.applicantName, color: color),
                      ShowTile(title: "Applicant Email", subtitle: widget.offer.applicantEmail, color: color),
                      ShowTile(title: "Position", subtitle: widget.offer.position, color: color),
                      ShowTile(title: "Salary", subtitle: "₹"+widget.offer.salary, color: color),
                      ShowTile(title: "Recruiter Email", subtitle: widget.offer.recruiterEmail, color: color),
                    ],
                  ),
                ),

            ),
             SizedBox(height: 30),

             if(!widget.is_recruiter && widget.offer.is_new) Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          backgroundColor: Colors.transparent,

                          context: context,
                          builder: (_){
                            return Container(
                              height: MediaQuery.of(context).size.height*0.4,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                                color: color.tertiary,
                              ),
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("ENTER YOU NAME HERE (E-VERIFICATION)"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(text: "Enter you Name", pass: false, controller:nameController ,),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomButton(text: "Submit", onTap: ()=>setter('accepted'))
                                ],

                              ),

                            );
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),color: Colors.green
                      ),
                      child: const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 30.0,vertical: 20),
                        child: Text("A C C E P T",style: TextStyle(
                          color: Colors.white
                        ),),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>setter("rejected" ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),color: Colors.red
                      ),
                      child: const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 30.0,vertical: 20),
                        child: Text("R E J E C T",style: TextStyle(
                            color: Colors.white
                        ),),
                      ),
                    ),
                  )
                ],
              ),
            if(!widget.is_recruiter && !widget.offer.is_new) Center(child: Text("YOU HAVE "+widget.offer.status.toString().toUpperCase()+" THE OFFER")),
          ],
        ),
      ),
    );
  }
}

class ShowTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final ColorScheme color;

  const ShowTile({
    Key? key, required this.title, required this.subtitle, required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        tileColor: color.secondary,
        title: Text(title,style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        subtitle: Text(subtitle),
      ),
    );
  }
}
