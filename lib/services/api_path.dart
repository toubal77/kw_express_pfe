class APIPath {
  static String userDocument(String uid) => 'users/$uid/';
  static String usersCollection() => 'users/';

  static String savedProductsCollection(String uid) =>
      'users/$uid/savedProducts';
  static String productDocument(String productId) => 'products/$productId';
  static String productsCollection() => 'products/';
  static String savedProductDocument(String userId) =>
      'users/$userId/savedProducts/savedProducts';

  // files
  static String userProfilePicture(String uid, String photoId) =>
      'users/$uid/profile_picutres/$photoId';

  static String productsFiles(
          String userId, String productId, String photoId) =>
      'products/user_$userId/product_$productId/$photoId';
}
