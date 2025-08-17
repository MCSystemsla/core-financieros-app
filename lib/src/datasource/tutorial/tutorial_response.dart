import 'dart:convert';

TutorialResponse tutorialResponseFromJson(String str) =>
    TutorialResponse.fromJson(json.decode(str));

class TutorialResponse {
  final List<Tutorial> tutoriales;

  TutorialResponse({
    required this.tutoriales,
  });

  factory TutorialResponse.fromJson(Map<String, dynamic> json) =>
      TutorialResponse(
        tutoriales: List<Tutorial>.from(
            json['tutoriales'].map((x) => Tutorial.fromJson(x))),
      );
}

class Tutorial {
  final String title;
  final String description;
  final String url;

  Tutorial({
    required this.title,
    required this.description,
    required this.url,
  });

  factory Tutorial.fromJson(Map<String, dynamic> json) => Tutorial(
        title: json['title'],
        description: json['description'],
        url: json['url'],
      );
}
