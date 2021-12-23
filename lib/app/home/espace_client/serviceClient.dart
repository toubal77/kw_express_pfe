import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home/espace_client/widget/build_espace_client.dart';
import 'package:kw_express_pfe/app/home/espace_client/widget/dialog_contact.dart';
import 'package:kw_express_pfe/app/home/espace_client/widget/dialog_new_resto.dart';

class ServiceClient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Espace Client',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 6.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 0.5,
                    offset: Offset(0.5, 0.5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await dialogContact(context);
                      },
                      child: BuildEspaceClient(
                        title: 'Contact Direct',
                        icon: Icon(
                          //     IconsApp.contact,
                          Icons.contact_page,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        TextEditingController _nameResto =
                            TextEditingController();
                        TextEditingController _numClient =
                            TextEditingController();
                        TextEditingController _addressResto =
                            TextEditingController();

                        dialogNewResto(
                            context, _nameResto, _numClient, _addressResto);
                      },
                      child: BuildEspaceClient(
                        title: 'Nouveau Restaurant',
                        icon: Icon(
                          //      IconsApp.resto,
                          Icons.restaurant,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: BuildEspaceClient(
                        title: 'Bug',
                        icon: Icon(
                          //               IconsApp.bug,
                          Icons.bug_report,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: BuildEspaceClient(
                        title: 'Reclamation',
                        icon: Icon(
                          // IconsApp.recla,
                          Icons.recommend_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: BuildEspaceClient(
                        title: 'Nouveau Restaurant',
                        icon: Icon(
                          //         IconsApp.sugg,
                          Icons.support_agent,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    'powerdBy',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'CedarvilleCursive-Regular',
                      color: Colors.red,
                    ),
                  ),
                  // Container(
                  //   width: 100,
                  //   height: 100,
                  //   child: SvgPicture.asset(kwSvg),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
