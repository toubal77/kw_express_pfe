import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kw_express_pfe/app/home_restaurent/new_menu/new_menu_form.dart';
import 'package:kw_express_pfe/app/home_restaurent/restaurent_bloc.dart';
import 'package:kw_express_pfe/app/models/menu_restaurent.dart';
import 'package:kw_express_pfe/app/models/types_menu.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/platform_exception_alert_dialog.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:kw_express_pfe/utils/logger.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class NewMenuScreen extends StatefulWidget {
  const NewMenuScreen({
    Key? key,
    this.menuResto,
  }) : super(key: key);
  final MenuRestaurent? menuResto;
  @override
  _NewMenuScreenState createState() => _NewMenuScreenState();
}

class _NewMenuScreenState extends State<NewMenuScreen> {
  late final PageController _pageController;
  late final RestaurentBloc bloc;
  MenuRestaurent? menuRestos;

  @override
  void initState() {
    _pageController = PageController();
    final User user = context.read<User>();
    final Database database = context.read<Database>();
    bloc = RestaurentBloc(
      database: database,
      currentUser: user,
    );

    super.initState();
  }

  void swipePage(int index) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> sendMenuRestoInfo() async {
    try {
      final ProgressDialog pd = ProgressDialog(context: context);

      final TypeMenu typeMenu = TypeMenu(
        id: '',
        name: menuRestos!.type,
      );
      await bloc.sendMenuRestoInfo(menuRestos!);
      bool check = await bloc.checkTypeMenu(menuRestos!.type);
      if (check) await bloc.sendTypeRestoInfo(typeMenu);
      Fluttertoast.showToast(
        msg: 'Les informations sont passée avec succès',
        toastLength: Toast.LENGTH_LONG,
      );
      pd.close();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } on Exception catch (e) {
      PlatformExceptionAlertDialog(exception: e).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return WillPopScope(
      onWillPop: () async {
        if (_pageController.hasClients) {
          if (_pageController.page == 0) {
            return true;
          } else {
            _pageController.previousPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        }
        return false;
      },
      child: SizedBox(
        height: SizeConfig.screenHeight,
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            NewMenuRestaurentForm(
              menuResto: widget.menuResto,
              onSaved: ({
                required MenuRestaurent? menuResto,
              }) async {
                try {
                  menuRestos = menuResto;

                  sendMenuRestoInfo();
                  swipePage(1);
                } on Exception catch (e) {
                  logger.severe('Error add new menu restaurent');
                  PlatformExceptionAlertDialog(exception: e).show(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
