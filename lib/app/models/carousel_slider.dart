import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kw_express_pfe/app/models/mini_user.dart';

class CarouselSlider {
  CarouselSlider({
    required this.id,
    required this.pictureUrl,
    required this.createdBy,
    required this.createdAt,
  });
  final String id;
  final String pictureUrl;
  final String createdBy;
  final Timestamp createdAt;
  factory CarouselSlider.fromMap(Map<String, dynamic> data, String documentId) {
    final String id = documentId;

    final String pictureUrl = data['pictureUrl'] as String;
    final String createdBy = data['createdBy'] as String;
    final Timestamp createdAt =
        data['createdAt'] as Timestamp? ?? Timestamp.now();
    return CarouselSlider(
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
