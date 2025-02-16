import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logOut(){
    FirebaseAuth.instance.signOut();
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //drawer header
              DrawerHeader(child: Icon(Icons.person_2,
                color: Theme.of(context).colorScheme.inversePrimary,)
              ),

              SizedBox(height: 25,),

              // home tile
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: ListTile(leading: Icon(Icons.home,
                    color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text("H O M E"),
                  onTap: () => Navigator.pop(context),
                ),
              ),



              // profile tile
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: ListTile(leading: Icon(Icons.person,
                    color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text("P R O F İ L E"),
                  onTap: () {
                    // pop drawer
                    Navigator.pop(context);

                    // navigate to Profile page
                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),



              // users tile
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: ListTile(leading: Icon(Icons.group,
                    color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text("U S E R S"),
                  onTap: () {
                    // pop drawer
                    Navigator.pop(context);

                    // navigate to Profile page
                    Navigator.pushNamed(context, '/users_page');
                  },
                ),
              ),

            ],
          ),

          // logout tile
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: ListTile(leading: Icon(Icons.logout,
                color: Theme.of(context).colorScheme.inversePrimary),
              title: Text("L O G O U T"),
              onTap: () {
                Navigator.pop(context);

                logOut();
              },
            ),
          ),

        ],
      ),

    );
  }
}
