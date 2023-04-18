import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:ruangbawah/screens/post_image.dart';
import 'dart:io';
import 'package:ruangbawah/screens/post_text.dart';
import 'charts.dart';
import 'discover.dart';
import 'package:ruangbawah/components/icons.dart';
import 'package:ruangbawah/screens/profile_page.dart';
import 'package:ruangbawah/components/svg_asset.dart';
import 'package:get/get.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DiscoverPage(),
    ChartsPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButtonLocation: ExpandableFab.location,

      floatingActionButton:  ExpandableFab(
        backgroundColor: const Color(0xff4A80F0),
        foregroundColor: const Color(0xff313131),
        fanAngle: 60,
        overlayStyle: ExpandableFabOverlayStyle(
          color: Colors.black87
        ),

        child: const Icon(Icons.add, color: Colors.white,),

        children: [
          FloatingActionButton(
            tooltip: "What u think?",
            onPressed: () {
              Get.to(() => PostTextScreen(), transition: Transition.downToUp);
            },
            child: const Icon(Icons.abc, color: Colors.white,),
          ),
          FloatingActionButton(
            onPressed: () async{

              File _image;
              var pickedfile = await ImagePicker().pickImage(source: ImageSource.gallery);
              // final XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
              if(pickedfile != null){
                _image = File(pickedfile.path);
                Get.to(()=> PostImageScreen(images: _image), transition: Transition.rightToLeft);
              }else{
                Get.back();
              }
            },
            tooltip: "Have a Photos?",
            child: const Icon(Icons.add_a_photo_outlined, color: Colors.white,),
          ),

        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          enableFeedback: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const SvgAsset(assetName: AssetName.discover),
              label: '',
              tooltip: 'Discover',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff4A80F0).withOpacity(0.3),
                        offset: const Offset(0, 4),
                        blurRadius: 20),
                  ],
                ),
                child: const SvgAsset(
                    assetName: AssetName.discover, color: Color(0xff4A80F0)),
              ),
            ),
            BottomNavigationBarItem(
              icon: const SvgAsset(assetName: AssetName.chart),
              label: '',
              tooltip: 'Charts',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff4A80F0).withOpacity(0.3),
                        offset: const Offset(0, 4),
                        blurRadius: 20),
                  ],
                ),
                child: const SvgAsset(
                  assetName: AssetName.chart,
                  color: Color(0xff4A80F0),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: const SvgAsset(assetName: AssetName.profile),
              label: '',
              tooltip: 'Profile',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff4A80F0).withOpacity(0.3),
                        offset: const Offset(0, 4),
                        blurRadius: 20),
                  ],
                ),
                child: const SvgAsset(
                  assetName: AssetName.profile,
                  color: Color(0xff4A80F0),
                ),
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
          backgroundColor: const Color(0xff1C2031),
        ),
      ),
    );
  }
}
