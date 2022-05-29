
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qmarket/controllers/payment_controller.dart';
import 'package:qmarket/views/screens/wallet/wallet_screen.dart';

import '../../../Assistants/globals.dart';
import '../../../controllers/account_controller.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/register_controller.dart';
import '../../address/list_addresses.dart';
import '../../favorite_screen.dart';
import '../../widgets/new_button.dart';
import '../auth/register.dart';
import '../order/my_orders.dart';

class Account extends StatefulWidget {
  Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final accountController = Get.put(AccountController());
  final CartController cartController = Get.find();
  final PaymentController paymentController = Get.find();
  bool btnPressed =false;
  bool btnPressed2 =false;
  bool btnPressed3 =false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentController.getMyWallet();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // WELCOME
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: accountController.isLoggedIn.value == false ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 8.0,),
                    // WELCOME
                    Text(
                      "Welcome.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(56, 216, 218, 1.0),
                      ),
                    ),
                    SizedBox(height: 8.0,),
                    // JOIN US
                    Text(
                      "We'd like if you joined us, login & access all of app features",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54
                      ),
                    ),
                    SizedBox(height: 16.0,),
                    Center(
                      child: InkWell(
                        onTap: () {
                          // nav to login
                          Get.to(() => Register());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(17.5),
                                decoration: BoxDecoration(
                                    color: myHexColor2,
                                    shape: BoxShape.circle
                                ),
                                child: SvgPicture.asset(
                                  "${assetsIconDir}user.svg",
                                  width: 30,
                                ),
                              ),
                              SizedBox(height: 8.0,),
                              Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0,),

                  ],
                ) :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 8.0,),
                    Text(
                      "Welcome.",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(56, 216, 218, 1.0),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      accountController.username.value,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54
                      ),
                    ),
                    SizedBox(height: 16.0,),
                  ],
                ),
              ),
              SizedBox(height: 8,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38.0),
                child: NeuButton(onTap: (){
                  setState(() {
                    if(btnPressed == true){
                      btnPressed = false;
                    }else if(btnPressed == false){
                      btnPressed =true;
                      btnPressed2 =false;
                      btnPressed3 =false;

                    }
                  });
                  Future.delayed(200.milliseconds,(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyOrders()));
                    setState(() {
                      if(btnPressed == true){
                        btnPressed = false;
                      }else if(btnPressed == false){
                        btnPressed =true;
                        btnPressed2 =false;
                        btnPressed3 =false;

                      }
                    });
                  });


                },onTap2: (){
                  setState(() {
                    if(btnPressed2 == true){
                      btnPressed2 = false;
                    }else if(btnPressed2 == false){
                      btnPressed2 =true;
                      btnPressed =false;
                      btnPressed3 =false;

                    }
                  });
                  Future.delayed(200.milliseconds,(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WalletScreen()));
                    setState(() {
                      if(btnPressed2 == true){
                        btnPressed2 = false;
                      }else if(btnPressed2 == false){
                        btnPressed2 =true;
                        btnPressed =false;
                        btnPressed3 =false;

                      }
                    });
                  });


                }
                ,onTap3: (){
                    setState(() {
                      if(btnPressed3 == true){
                        btnPressed3 = false;
                      }else if(btnPressed3 == false){
                        btnPressed3 =true;
                        btnPressed2 =false;
                        btnPressed =false;

                      }
                    });
                    Future.delayed(200.milliseconds,(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FavoriteScreen()));
                      setState(() {
                        if(btnPressed3 == true){
                          btnPressed3 = false;
                        }else if(btnPressed3 == false){
                          btnPressed3 =true;
                          btnPressed2 =false;
                          btnPressed =false;

                        }
                      });
                    });


                  },btnPressed: btnPressed,btnPressed2: btnPressed2,btnPressed3: btnPressed3,),
              ),
              SizedBox(height: 14,),
              accountController.isLoggedIn.value != false ?
              Column(
                children: [
                  // MY ACCOUNT
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WalletScreen()));

                    },
                    child: Container(
                      height: 60,
                      color: Color.fromRGBO(245, 246, 248, 1.0),
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          "My Account",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),

                  buildOptionRow("Personal File", Icons.account_circle_outlined),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 64.0),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),

                  InkWell(
                      onTap: (){

                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ListAddresses(fromAccount: true,fromCart: false,)));
                      },
                      child: buildOptionRow("My Address", Icons.location_history)),
                ],
              ) :
              Container(),
              // APP SETTINGS
              Container(
                height: 60,
                color: Color.fromRGBO(245, 246, 248, 1.0),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                  child: Text(
                    "App Settings",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              buildOptionRow("Language", Icons.language),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 64.0),
                child: Divider(
                  thickness: 1,
                ),
              ),
              buildOptionRow("Notifications", Icons.notification_important_outlined),
              // CONTACT US
              Container(
                height: 60,
                color: Color.fromRGBO(245, 246, 248, 1.0),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                  child: Text(
                    "Contact Us",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              buildOptionRow("Help And Technical Support", Icons.contact_support_outlined),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 64.0),
                child: Divider(
                  thickness: 1,
                ),
              ),
              buildOptionRow("Terms Of Usage", Icons.event_note_outlined),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 64.0),
                child: Divider(
                  thickness: 1,
                ),
              ),
              buildOptionRow("Contact Us", Icons.call),
              accountController.isLoggedIn.value != false ?
              // LOGOUT
              Container(
                height: 70,
                color: Color.fromRGBO(245, 246, 248, 1.0),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                  onTap: () {
                    // TODO: logout
                    accountController.signOut();
                    Get.offAll(Register());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.close, color: Colors.red, size: 30,),
                      SizedBox(width: 16.0,),
                      Align(
                        alignment: Alignment.centerLeft, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text(
                          "Sign Out",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ):
              Container(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildOptionRow(String optionText, IconData optionIcon) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            optionIcon,
            size: 26,
            color: Colors.black54,
          ),
          SizedBox(width: 16,),
          Text(
            optionText,
            style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
                fontWeight: FontWeight.bold
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.black54,),
        ],
      ),
    );
  }
}