class UserModel {
  String name;
  String description;
  String imagePost;
  String profilePic;
  bool isLiked;
  bool onDoubleTap;
  UserModel(
      {required this.description,
      required this.imagePost,
      required this.isLiked,
      required this.profilePic,
      required this.name,
      required this.onDoubleTap});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        description: json['description'],
        imagePost: json['imagePost'],
        isLiked: json['isLiked'],
        profilePic: json['profilePic'],
        onDoubleTap: json['onDoubleTap'],
        name: json['name']);
  }
}
