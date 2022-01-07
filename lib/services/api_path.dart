// ignore: avoid_classes_with_only_static_members
class APIPath {
  static String newRestoDocument(String uid) => 'newResto/$uid/';
  static String newRestoCollection() => 'newResto';

  static String bugDocument(String uid) => 'bug/$uid/';
  static String bugCollection() => 'bug/';

  static String userDocument(String uid) => 'users/$uid/';
  static String usersCollection() => 'users/';

  static String savedProductsCollection(String uid) =>
      'users/$uid/savedProducts';
  static String menuRestoDocument(String uid, String menuRestoid) =>
      'users/$uid/menuResto/$menuRestoid/';
  static String menuTypeDocument(String uid, String typeMenuid) =>
      'users/$uid/typesMenu/$typeMenuid/';
  static String productsCollection() => 'products/';
  static String menuRestoCollection(String uid) => 'users/$uid/menuResto/';
  static String typesMenuCollection(String uid) => 'users/$uid/typesMenu/';
  static String savedProductDocument(String userId) =>
      'users/$userId/savedProducts/savedProducts';

  static String carouselSliderDocument(String carouselSliderId) =>
      'carouselSlider/$carouselSliderId';

  static String orderDocument(String uid) => 'orders/$uid';
  static String orderCollection() => 'orders';
  // files
  static String userProfilePicture(String uid, String photoId) =>
      'users/$uid/profile_picutres/$photoId';
  static String userCouvPicture(String uid, String photoId) =>
      'users/$uid/couv_picutres/$photoId';

  static String carouselSlidersFiles(
    String userId,
    String carsouselSliderId,
    String photoId,
  ) =>
      'carsouselSlider/user_$userId/carsouselSlider_$carsouselSliderId/$photoId';
}
