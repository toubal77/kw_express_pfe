import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kw_express_pfe/app/models/menu_restaurent.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';
import 'package:kw_express_pfe/app/models/types_menu.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/services/api_path.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:uuid/uuid.dart';

class RestaurentBloc {
  RestaurentBloc({
    required this.database,
    required this.currentUser,
  });

  final Database database;
  final User currentUser;
  final Uuid uuid = Uuid();

  Future<String> uploadProfilePicture(File file) async {
    return database.uploadFile(
      path: APIPath.userProfilePicture(currentUser.id, uuid.v4()),
      filePath: file.path,
    );
  }

  Future<String> uploadCouvPicture(File file) async {
    return database.uploadFile(
      path: APIPath.userCouvPicture(currentUser.id, uuid.v4()),
      filePath: file.path,
    );
  }

  Future<void> saveRestaurentInfo(Restaurent restaurent) async {
    String restoId;
    if (restaurent.id == '') {
      restoId = uuid.v4();
    } else {
      restoId = restaurent.id;
    }
    final Restaurent restaurentt = Restaurent(
      id: restoId,
      type: 2,
      remise: restaurent.remise,
      name: restaurent.name,
      bio: restaurent.bio,
      timeOpen: restaurent.timeOpen,
      mapAdress: restaurent.mapAdress,
      dure: restaurent.dure,
      phoneNumber: restaurent.phoneNumber,
      couvPicture: restaurent.couvPicture,
      profilePicture: restaurent.profilePicture,
      adress: restaurent.address,
      createdBy: restaurent.createdBy,
      isModerator: false,
      isApproved: false,
      wilaya: restaurent.wilaya,
    );
    await database.setData(
      path: APIPath.userDocument(restaurent.createdBy),
      data: restaurentt.toMap(),
      merge: false,
    );
  }

  Stream<Restaurent?> getMyResto() {
    return database.streamDocument(
      path: APIPath.userDocument(currentUser.id),
      builder: (data, documentId) => Restaurent.fromMap(data, documentId),
    );
  }

  Stream<List<MenuRestaurent>> getMenuResto() {
    return database.streamCollection(
      path: APIPath.menuRestoCollection(currentUser.id),
      builder: (data, documentId) => MenuRestaurent.fromMap(data, documentId),
    );
  }

  Stream<List<TypeMenu>> getTypesMenu() {
    return database.streamCollection(
      path: APIPath.typesMenuCollection(currentUser.id),
      builder: (data, documentId) => TypeMenu.fromMap(data, documentId),
    );
  }

  Future<bool> checkTypeMenu(String type) async {
    late bool check;
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.id)
        .collection('typesMenu')
        .get();
    check =
        snapshot.docs.where((element) => element['name'] == type).length == 0
            ? true
            : false;

    return check;
  }

  Future<void> sendMenuRestoInfo(MenuRestaurent menuResto) async {
    String menuRestoId;
    if (menuResto.id == '') {
      menuRestoId = uuid.v4();
    } else {
      menuRestoId = menuResto.id;
    }
    await database.setData(
      path: APIPath.menuRestoDocument(currentUser.id, menuRestoId),
      data: menuResto.toMap(),
      merge: false,
    );
  }

  Future<void> deleteProduct(MenuRestaurent product) async =>
      database.deleteDocument(
        path: APIPath.menuRestoDocument(currentUser.id, product.id),
      );
  Future<void> sendTypeRestoInfo(TypeMenu typeMenu) async {
    final Uuid uuid = Uuid();
    String typeMenuId = uuid.v4();
    await database.setData(
      path: APIPath.menuTypeDocument(currentUser.id, typeMenuId),
      data: typeMenu.toMap(),
      merge: false,
    );
  }

  Future<void> makeRemise(int remise) async {
    final Restaurent restaurentt = Restaurent(
      id: currentUser.id,
      type: 2,
      remise: remise,
      name: currentUser.name,
      bio: currentUser.bio,
      timeOpen: currentUser.timeOpen,
      mapAdress: currentUser.mapAdress,
      dure: currentUser.dure,
      phoneNumber: currentUser.phoneNumber,
      couvPicture: currentUser.couvPicture,
      profilePicture: currentUser.profilePicture,
      adress: currentUser.address,
      createdBy: currentUser.createdBy,
      isModerator: false,
      isApproved: currentUser.isApproved,
      wilaya: currentUser.wilaya,
    );
    await database.setData(
      path: APIPath.userDocument(currentUser.id),
      data: restaurentt.toMap(),
      merge: false,
    );
  }

  Future<void> desctiveResto() {
    return database.updateData(
      path: APIPath.userDocument(currentUser.id),
      data: {
        'isApproved': false,
      },
    );
  }

  Future<void> sendRequest() async {
    if (currentUser.isApproved) {
      Fluttertoast.showToast(
        msg: 'Votre restaurent est deja active',
        toastLength: Toast.LENGTH_LONG,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'votre demande est envoye avec succès',
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}
