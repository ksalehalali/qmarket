import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../Assistants/assistantMethods.dart';
import '../../Assistants/globals.dart';
import '../../controllers/address_location_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/product_controller.dart';
import 'auth/register.dart';
import 'categories/categories_screen.dart';
import 'offers_screen.dart';
import 'order/Cart.dart';
import 'home/account.dart';
import 'home/home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AddressController addressController = Get.find();
  final cartController = Get.put(CartController());

  final List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const OffersScreen(),
    const Cart(),
    Account(),
  ];
  final ProductsController productController = Get.find();

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();
  int? currentTp = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    productController.getProductsByCatHome(
        '0c348ba7-1873-425e-8e49-97e0ec8ceebe', 'recommended');
    productController.getProductsByCatHome(
        'd115a1f7-2407-4446-9caa-dc9744e5bfa8', 'latest');
    productController.getProductsByCatHome(
        'a7c777ed-cb81-46f3-bd6b-7667842d7819', 'offers');
    addressController.getMyAddresses();
    productController.getMyFav();
    cartController.getMyOrders();
  }

  @override
  Widget build(BuildContext context) {
    print(Get.size.height);
    print(Get.size.width);

    return Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        bottomNavigationBar: NavigationBar(
            height: 55.0,
            backgroundColor: Colors.white,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            selectedIndex: currentTp!,
            onDestinationSelected: (index) {
              setState(() {
                currentScreen = screens[index];
                currentTp = index;
              });
            },
            animationDuration: const Duration(milliseconds: 1),
            destinations: [
              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold))),
                  child: NavigationDestination(
                    icon: SvgPicture.asset('assets/icons/home-fill.svg',
                        color: Colors.grey[600],
                        height: 22.00,
                        width: 22.0,
                        semanticsLabel: 'A red up arrow'),
                    label: 'Home',
                    selectedIcon: SvgPicture.asset('assets/icons/home-fill.svg',
                        height: 24.00,
                        width: 24.0,
                        color: myHexColor3,
                        semanticsLabel: 'A red up arrow'),
                  )),
              NavigationBarTheme(
                  data: NavigationBarThemeData(
                    indicatorColor: Colors.grey.shade200,
                    labelTextStyle: MaterialStateProperty.all(
                      const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                  child: NavigationDestination(
                    icon: SvgPicture.asset(
                        'assets/icons/categories-outline.svg',
                        color: Colors.grey[600],
                        height: 22.00,
                        width: 22.0,
                        semanticsLabel: 'A red up arrow'),
                    label: 'Categories',
                    selectedIcon: SvgPicture.asset(//assets/icons/categories-fill.svg
                        'assets/icons/categories-outline.svg',
                        color: myHexColor3,
                        height: 24.00,
                        width: 24.0,
                        semanticsLabel: 'A red up arrow'),
                  )),
              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold))),
                  child: NavigationDestination(
                    icon: SvgPicture.asset('assets/icons/offers-outline.svg',
                        color: Colors.grey[600],
                        height: 22.00,
                        width: 22.0,
                        semanticsLabel: 'A red up arrow'),
                    label: 'Clearance',
                    selectedIcon: SvgPicture.asset(//assets/icons/offers-fill.svg
                        'assets/icons/offers-outline.svg',
                        color: myHexColor3,
                        height: 24.00,
                        width: 24.0,
                        semanticsLabel: 'A red up arrow'),
                  )),
              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold))),
                  child: NavigationDestination(
                    icon: SvgPicture.asset('assets/icons/cart-outline.svg',
                        color: Colors.grey[600],
                        height: 22.00,
                        width: 22.0,
                        semanticsLabel: 'A red up arrow'),
                    label: 'Cart',
                    selectedIcon: SvgPicture.asset(//assets/icons/cart-fill.svg
                        'assets/icons/cart-outline.svg',
                        height: 24.00,
                        width: 24.0,
                        color: myHexColor3,
                        semanticsLabel: 'A red up arrow'),
                  )),
              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold))),
                  child: NavigationDestination(
                    icon: SvgPicture.asset('assets/icons/account-outline.svg',
                        height: 22.00,
                        width: 22.0,
                        color: Colors.grey[600],
                        semanticsLabel: 'A red up arrow'),
                    label: 'My Account',
                    selectedIcon: SvgPicture.asset( //assets/icons/account-fill.svg
                        'assets/icons/account-outline.svg',
                        height: 24.00,
                        width: 24.0,
                        color: myHexColor3,
                        semanticsLabel: 'A red up arrow'),
                  )),
            ]));
  }
}
