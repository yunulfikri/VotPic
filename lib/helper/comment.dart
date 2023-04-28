import 'package:timeago/timeago.dart' as timeago;
class CommentList{
  final String name, comment, time;
  CommentList({
    required this.name,
    required this.comment,
    required this.time
  });
  factory CommentList.fromjson(Map<String, dynamic> json){
    DateTime timeparse = DateTime.parse(json['created_at']);
    return CommentList(
        name: json['name'],
        comment: json['comment'],
        time: timeago.format(timeparse).toString()
    );
  }
}