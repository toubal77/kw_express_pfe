import 'dart:io';

import 'package:kw_express_pfe/app/models/carousel_slider.dart';
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

  Future<void> saveCarouselSliderInfo(CarouselSlider carouselSlider) async {
    await database.setData(
      path: APIPath.carouselSliderDocument(carouselSlider.id),
      data: carouselSlider.toMap(),
    );
  }
}
