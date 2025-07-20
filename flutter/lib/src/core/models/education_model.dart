class EducationModel {
  final String id;
  final String userId;
  final String schoolName;
  final String standard;
  final int year;
  final DateTime createdAt;

  EducationModel({
    required this.id,
    required this.userId,
    required this.schoolName,
    required this.standard,
    required this.year,
    required this.createdAt,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: json['id'],
      userId: json['userId'],
      schoolName: json['schoolName'],
      standard: json['standard'],
      year: json['year'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'schoolName': schoolName,
      'standard': standard,
      'year': year,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
