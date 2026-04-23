import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'constants.dart';
import 'screens/home/home_screen.dart';
import 'screens/orderDetails/order_details_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/search/search_screen.dart';

/// ✅ FIX IMPORT (PAKAI package)
import 'package:foodly_ui/data/location_data.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _navitems = [
    {"icon": "assets/icons/home.svg", "title": "Home"},
    {"icon": "assets/icons/search.svg", "title": "Search"},
    {"icon": "assets/icons/order.svg", "title": "Orders"},
    {"icon": "assets/icons/profile.svg", "title": "Profile"},
  ];

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const OrderDetailsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// 🔥 APPBAR TAMBAHAN (TAMPILKAN ALAMAT)
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.location_on, size: 18),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                userAddress.isEmpty
                    ? "Pilih lokasi"
                    : userAddress,
                style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),

      body: _screens[_selectedIndex],

      bottomNavigationBar: CupertinoTabBar(
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        currentIndex: _selectedIndex,
        activeColor: primaryColor,
        inactiveColor: bodyTextColor,
        items: List.generate(
          _navitems.length,
          (index) => BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _navitems[index]["icon"],
              height: 30,
              width: 30,
              colorFilter: ColorFilter.mode(
                index == _selectedIndex ? primaryColor : bodyTextColor,
                BlendMode.srcIn,
              ),
            ),
            label: _navitems[index]["title"],
          ),
        ),
      ),
    );
  }
}