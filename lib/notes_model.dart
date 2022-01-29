class Notes{
  int? id;
  String? title;
  String? content;

  Notes({this.id, this.title, this.content});

  toMap() => {
    'id' : id,
    'title' : title,
    'content' : content,
  };

  Notes.fromMap(Map<String, dynamic> notes)
      :   id = notes["id"],
        title = notes["title"],
        content = notes["content"];

  @override
  String toString() {
    return 'Notes{id: $id, title: $title, content: $content}';
  }

}