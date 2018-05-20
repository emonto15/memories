class Question {
  final String question;
  final List<dynamic> options;
  final String answer;
  bool hasImage;
  String imageRoute;
  bool isSequence;
  final List<dynamic> secuencia;
  final int area;
  final int subarea;
  Question(this.question, this.options, this.answer,
      this.hasImage, this.imageRoute, this.isSequence, this.secuencia, this.area,this.subarea);
}