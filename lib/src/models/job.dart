class Job {
  final String id;
  final String title;
  final String company;

  Job({
    required this.id,
    required this.title,
    required this.company,
  });

  factory Job.fromJson(String id, Map<String, dynamic> json) => Job(
        id: id,
        title: json["title"],
        company: json["company"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "company": company,
      };
}
