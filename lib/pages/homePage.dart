import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/screens/homeScreen.dart';
import 'package:faroty_association_1/screens/settingsScreen.dart';
import 'package:faroty_association_1/screens/HistoriqueScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  int _pageIndex = 0;

  final items = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home_rounded,
      ),
      label: 'Accueil',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_tree_rounded),
      label: 'Historiques',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_rounded),
      label: 'Profil',
    ),
  ];

  final screens = [
    HomeScreen(),
    HistoriqueScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color(0xFFEFEFEF),
      bottomNavigationBar: Container(
        // color: Colors.green,
        height: 51,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: BottomNavigationBar(
            
            backgroundColor: Color.fromARGB(255, 226, 226, 226),
            type: BottomNavigationBarType.shifting,
            selectedIconTheme: IconThemeData(size: 25),
            unselectedIconTheme: IconThemeData(size: 15),
            selectedFontSize: 12,
            unselectedItemColor: Color.fromARGB(255, 20, 45, 99),
            selectedItemColor: Color.fromRGBO(0, 162, 255, 0.815),
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            items: items,
            currentIndex: _pageIndex,
            onTap: (index) {
              setState(() {
                _pageIndex = index;
              });
            },
          ),
        ),
      ),
      body: screens[_pageIndex],
    );
  }
}
