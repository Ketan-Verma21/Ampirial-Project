

class UserModel {
  final String uid;
  final String name;
  final String email;
  final bool isRecruiter;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.isRecruiter,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'uid': uid,
  //     'name': name,
  //     'email': email,
  //     'is_recruiter': isRecruiter,
  //   };
  // }
  //
  // factory UserModel.fromMap(Map<String, dynamic> map) {
  //   return UserModel(
  //     uid: map['uid'] ?? '',
  //     name: map['name'] ?? '',
  //     email: map['email'] ?? '',
  //     isRecruiter: map['is_recruiter'] ?? false,
  //   );
  // }
  //
  // String toJson() => json.encode(toMap());
  //
  // factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
  //
  // UserModel copyWith({
  //   String? uid,
  //   String? name,
  //   String? email,
  //   bool? isRecruiter,
  // }) {
  //   return UserModel(
  //     uid: uid ?? this.uid,
  //     name: name ?? this.name,
  //     email: email ?? this.email,
  //     isRecruiter: isRecruiter ?? this.isRecruiter,
  //   );
  // }
}
