import 'package:finkart/features/orders/views/orders_graph_screen.dart';
import 'package:finkart/features/orders/views/orders_screen.dart';
import 'package:finkart/features/profile/views/profile_screen.dart';
import 'package:finkart/features/shared/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EntryScreen extends StatefulWidget {
  final int index;
  const EntryScreen({Key? key, this.index = 0}) : super(key: key);

  @override
  State<EntryScreen> createState() => _EntryState();
}

class _EntryState extends State<EntryScreen> {
  late int _selectedIndex;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    OrdersScreen(),
    OrdersGraphScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Disables the back button
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
          elevation: 0,
          onTap: navigateBottomBar,
          unselectedItemColor: lightGreyColor,
          selectedItemColor: primaryColor,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          items: [
            BottomNavigationBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(bottom: 6, top: 10),
                    child: Icon(
                      Icons.label_outline_sharp,
                      color:
                          _selectedIndex == 0 ? primaryColor : lightGreyColor,
                    )),
                label: 'Orders'),
            BottomNavigationBarItem(
                icon: Padding(
                    padding: const EdgeInsets.only(bottom: 6, top: 10),
                    child: Icon(
                      Icons.insert_chart_outlined,
                      color:
                          _selectedIndex == 1 ? primaryColor : lightGreyColor,
                    )),
                label: 'Chart'),
            BottomNavigationBarItem(
                icon: Padding(
                    padding: const EdgeInsets.only(bottom: 6, top: 10),
                    child: Icon(
                      Icons.person,
                      color:
                          _selectedIndex == 2 ? primaryColor : lightGreyColor,
                    )),
                label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
