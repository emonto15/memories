class Question {
  final String question;
  final List<String> options;
  final String answer;
  bool hasImage;
  String imageRoute;

  Question(this.question, this.options, this.answer, this.hasImage, this.imageRoute);
}