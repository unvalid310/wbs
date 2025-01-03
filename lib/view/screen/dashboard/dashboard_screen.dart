// ignore_for_file: use_super_parameters, library_private_types_in_public_api, unused_field, prefer_final_fields, unused_element

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sizer/sizer.dart';
import 'package:wbs_app/utill/colors_resource.dart';
import 'package:wbs_app/view/screen/page/home/home_page.dart';
import 'package:wbs_app/view/screen/page/informasi/informasi_page.dart';
import 'package:wbs_app/view/screen/page/laporan/list_laporan_page.dart';
import 'package:wbs_app/view/screen/page/laporan/tambah_laporan_page.dart';
import 'package:wbs_app/view/screen/page/profil/profil_page.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  const DashboardScreen({Key? key, required this.pageIndex}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  late PersistentTabController _controller;
  int _selectedIndex = 0;
  late bool _hideNavBar;
  final List<ScrollController> _scrollControllers = [
    ScrollController(),
    ScrollController(),
  ];

  NavBarStyle _navBarStyle = NavBarStyle.style12;

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.pageIndex;
    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      const HomePage(),
      const ListLaporanPage(),
      const TambahLaporanPage(),
      const InformasiPage(),
      const ProfilPage(),
    ];
  }

  @override
  void dispose() {
    for (final element in _scrollControllers) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0XFF85B4EE),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          items: [
            _barItem(Icons.home_rounded, '', 0),
            _barItem(Icons.list_rounded, '', 1),
            _barItem(Icons.add_circle_outline_rounded, '', 2),
            _barItem(Icons.info_outline_rounded, '', 3),
            _barItem(Icons.person_rounded, '', 4)
          ],
          onTap: (int index) {
            _setPage(index);
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.all(1.h),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index == _pageIndex ? Colors.white : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: index == _pageIndex
              ? Theme.of(context).primaryColor
              : ColorsResource.textColor,
          size: 19.sp,
        ),
      ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
