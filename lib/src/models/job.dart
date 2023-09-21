import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  final String id;
  final String title;
  final String company;
  DateTime? createdAt;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.createdAt,
  });

  factory Job.fromJson(String id, Map<String, dynamic> json) => Job(
        id: id,
        title: json["title"],
        company: json["company"],
        createdAt: (json["createdAt"] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "company": company,
        "createdAt": createdAt,
      };
}
