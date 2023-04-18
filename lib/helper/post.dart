class PostList {
  final String uuid, photo_url, captions;
  final int like, comment, views, unique_views;
  final String created_at;

  PostList(
      {required this.uuid,
      required this.photo_url,
      required this.captions,
      required this.like,
      required this.comment,
      required this.views,
      required this.unique_views,
      required this.created_at});

  factory PostList.fromjson(Map<String, dynamic> json){
    return PostList(
        uuid: json['uuid'],
        photo_url: json['photo_url'],
        captions: json['captions'],
        like: json['like'],
        comment: json['comment'],
        views: json['views'],
        unique_views: json['unique_views'],
        created_at: json['created_at'],
    );
  }
}
