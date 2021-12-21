import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/services/api_path.dart';
import 'package:kw_express_pfe/services/database.dart';

class ModeratorsBloc {
  final Database database;

  ModeratorsBloc({required this.database});

  Stream<List<User>> getModeratorsList() {
    return database.streamCollection(
      path: APIPath.usersCollection(),
//      queryBuilder: (query) => query.where('isModerator', isEqualTo: true),
      builder: (data, id) => User.fromMap(data, id),
    );
  }

  Future<void> makeUserMod(User miniUser, {required bool isMod}) async {
    return database.updateData(
        path: APIPath.userDocument(miniUser.id), data: {'isModerator': isMod});
  }
}
