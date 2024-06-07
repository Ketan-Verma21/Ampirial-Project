import 'package:flutter/material.dart';

class Offer {
  final String recruiterId;
  final String recruiterEmail;// ID of the recruiter who created the offer
  final String applicantName; // Name of the applicant
  final String position; // Position offered
  final String salary; // Salary offered
  final String status; // Status of the offer (accepted, rejected, pending)
  final String applicantEmail;
  final bool is_new;

  Offer( {
    required this.recruiterId,
    required this.recruiterEmail,
    required this.applicantName,
    required this.position,
    required this.salary,
    required this.status,
    required this.applicantEmail,
    required this.is_new
  });
}
