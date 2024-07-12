class TodoModel {
  int? userId;
  String? id;
  String? title;
  String? description;
  String? timeStart;
  String? timeEnd;

  TodoModel({this.userId, this.id, this.title, this.description, this.timeStart, this.timeEnd});

  TodoModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    timeStart = json['timeStart'];
    timeEnd = json['timeEnd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['timeStart'] = this.timeStart;
    data['timeEnd'] = this.timeEnd;
    return data;
  }
}
