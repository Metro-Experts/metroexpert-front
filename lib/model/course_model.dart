class CourseModel {
  final String id;
  final String title;
  final String description;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['_id'],
      title: json['nombreMateria'],
      description: json['description'],
    );
  }
}
