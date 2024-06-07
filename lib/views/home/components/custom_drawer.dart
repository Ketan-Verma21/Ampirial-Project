import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:feedback/feedback.dart';
import '../../../services/auth/auth_service.dart';
import '../../settings/pages/setting_page.dart';
class CustomDrawer extends ConsumerStatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  void logout() {
    final _authService =AuthService();
    _authService.signOut();
  }
  void submitFeedback(BuildContext context){
    BetterFeedback.of(context).show((UserFeedback feedback)async {
    });}
  @override
  Widget build(BuildContext context) {
    final color=Theme.of(context).colorScheme;
    return Drawer(
      backgroundColor: color.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(child: Center(
                child: Icon(Icons.message,color: color.primary,size: 40,),
              )),
               Padding(
                padding:  EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text("H O M E"),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
               Padding(
                padding:  EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text("S E T T I N G S"),
                  leading: Icon(Icons.settings),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingPage()));
                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text("R E P O R T"),
                  leading: Icon(Icons.bug_report_outlined),
                  onTap: (){
                    submitFeedback(context);
                  },
                ),
              ),
            ],
          ),
           Padding(
            padding:  EdgeInsets.only(left: 25.0,bottom: 25),
            child: ListTile(
              title: Text("L O G O U T"),
              leading: Icon(Icons.logout),
              onTap:logout,
            ),
          )
        ],
      ),
    );
  }
}
