// ignore: avoid_classes_with_only_static_members
class APIPath {
  static String userDocument(String uid) => 'users/$uid/';
  static String usersCollection() => 'users/';

  static String savedProductsCollection(String uid) =>
      'users/$uid/savedProducts';
  static String productDocument(String productId) => 'products/$productId';
  static String productsCollection() => 'products/';
  static String savedProductDocument(String userId) =>
      'users/$userId/savedProducts/savedProducts';

  static String carouselSliderDocument(String carouselSliderId) =>
      'carouselSlider/$carouselSliderId';
  // files
  static String userProfilePicture(String uid, String photoId) =>
      'users/$uid/profile_picutres/$photoId';

  static String carouselSlidersFiles(
    String userId,
    String carsouselSliderId,
    String photoId,
  ) =>
      'carsouselSlider/user_$userId/carsouselSlider_$carsouselSliderId/$photoId';
}
