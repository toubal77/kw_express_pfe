import 'package:cloud_firestore/cloud_firestore.dart';

class CarouselSlideModel {
  CarouselSlideModel({
    required this.id,
    required this.pictureUrl,
    required this.createdBy,
    required this.createdAt,
  });
  final String id;
  final String pictureUrl;
  final String createdBy;
  final Timestamp createdAt;
  factory CarouselSlideModel.fromMap(
      Map<String, dynamic> data, String documentId) {
    final String id = documentId;

    final String pictureUrl = data['pictureUrl'] as String;
    final String createdBy = data['createdBy'] as String;
    final Timestamp createdAt =
        data['createdAt'] as Timestamp? ?? Timestamp.now();
    return CarouselSlideModel(
      id: id,
      pictureUrl: pictureUrl,
      createdBy: createdBy,
      createdAt: createdAt,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'pictureUrl': pictureUrl,
      'createdBy': createdBy,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
