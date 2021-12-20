import 'dart:io';

import 'package:kw_express_pfe/app/models/carousel_slide.dart';
import 'package:kw_express_pfe/services/api_path.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:uuid/uuid.dart';

class CarouselSliderBloc {
  CarouselSliderBloc({
    required this.database,
    required this.currentUser,
  });

  final Database database;
  final Auth currentUser;
  final Uuid uuid = Uuid();
  Future<String> uploadProductProfileImage(File file, String carouselId) async {
    return database.uploadFile(
      path: APIPath.carouselSlidersFiles(
          currentUser.currentUser()!.uid, carouselId, uuid.v4()),
      filePath: file.path,
    );
  }

  Stream<List<CarouselSlideModel>> getCarouselSliders() {
    return database.streamCollection(
      path: 'carouselSlider',
      builder: (data, id) => CarouselSlideModel.fromMap(data, id),
      queryBuilder: (query) => query,
    );
  }

  Future<void> deleteCarouselSlider(CarouselSlideModel carouselSlider) async =>
      database.deleteDocument(
          path: APIPath.carouselSliderDocument(carouselSlider.id));

  Future<void> saveCarouselSliderInfo(CarouselSlideModel carouselSlider) async {
    await database.setData(
      path: APIPath.carouselSliderDocument(carouselSlider.id),
      data: carouselSlider.toMap(),
    );
  }
}
