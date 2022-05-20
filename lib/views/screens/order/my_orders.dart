import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Assistants/globals.dart';
import '../../../controllers/cart_controller.dart';
import 'order_summary.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final CartController cartController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartController.getMyOrders();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: myHexColor,
      child: SafeArea(child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black87,

        ),
      body: SingleChildScrollView(
        child: Obx(()=>Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // cartController.gotMyOrders.value ==true ?cartController.buildOrderItem():Container(),
             cartController.gotMyOrders.value ==true ? SizedBox(
                  height: screenSize.height -100,

                  child: buildOrdersList()):Container(child: Center(child: Text('No orders',style: TextStyle(fontSize: 22,color: Colors.grey[700]),)
               ,),),
           
            ],
          ),
        ),


      ),
      ),
      ),
    );
  }

  Widget buildOrdersList() {
    return CustomScrollView(
      key: const Key('a'),
      scrollDirection: Axis.vertical,
      slivers: [
        Obx(
              () => SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, indexA) {

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 0.7,
                        color: myHexColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 12),                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:screenSize.width *0.8-46,
                                      child: Text(
                                        'Order ${cartController.myOrders[indexA]['result']['id']}',maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[900],fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 3,),
                                    Text(
                                      'Placed On  ${DateFormat('yyyy-MM-dd  HH:mm :ss').format(DateTime.parse(cartController.myOrders[indexA]['result']['orderDate']))}',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () async{
                                  await cartController.getOneOrder(cartController.myOrders[indexA]['result']['id']);
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> OrderSummary(fromOrdersList: true,)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 12),
                                  child: Row(
                                    children: [
                                      Text(
                                        'View Details',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.blue[700],fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                          Divider(
                            thickness: 0.7,
                            height: 10,
                          ),

                          SizedBox(
                              height: screenSize.height *0.2,
                              width: screenSize.width,
                              child: _buildOrderProductsList(indexA))
                      ]),
                    ),
                  ),
                );
              },
              childCount: cartController.myOrders.length,
              semanticIndexOffset: 2,
            ),
          ),
        ),


      ],
    );
  }

  Widget _buildOrderProductsList(int indexA) {
    return CustomScrollView(
      key: const Key('b'),

      scrollDirection: Axis.horizontal,
      slivers: [
        Obx(
              () => SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var price = cartController.myOrders[indexA]['result']['prduct'][index]["price"] *
                        cartController.myOrders[indexA]['result']['prduct'][index]["offer"] /
                        100;
                return InkWell(
                  onTap: () {

                  },
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          ///to do
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: 80,
                                child: Image.network(
                                  "$baseURL/${cartController.myOrders[indexA]['result']['prduct'][index]['image']}",
                                  height: 122,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              height: screenSize.height *0.1+30,

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "${cartController.myOrders[indexA]['result']['prduct'][index]['product']}",
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),

                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.4 + 10,
                                    child: Row(
                                      children: [
                                        Text(
                                          "${cartController.myOrders[indexA]['result']['prduct'][index]["price"]} QAR".toUpperCase(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                              fontFamily: 'Montserrat-Arabic Regular',
                                              color: Colors.grey,
                                              fontSize: 13),
                                        ),
                                        const SizedBox(
                                          width: 7.0,
                                        ),
                                        Text(
                                          "Discount ${cartController.myOrders[indexA]['result']['prduct'][index]["offer"]}%",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'Montserrat-Arabic Regular',
                                              color: myHexColor3,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "${cartController.myOrders[indexA]['result']['prduct'][index]["price"] - price} QAR",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),

                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),



                    ],
                  ),
                );

              },
              childCount: cartController.myOrders[indexA]['result']['prduct'].length,
              semanticIndexOffset: 2,
            ),
          ),
        )
      ],
    );
  }

  Widget buildOrderItems(int indexA){
    print(indexA);
    return  SizedBox(
      width: 100,
      height: 100,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        physics: ScrollPhysics(),

        slivers: [
          Obx(
                () => SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {

                  return InkWell(
                    onTap: () {

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 0.7,
                            color: Colors.grey,
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child:Obx(()=>
                               Column(
                                children: [
                                  Text('${cartController.myOrdersDetails[3]['listProduct'][index]['product']}'),
                                  Text('${cartController.myOrdersDetails[3]['listProduct'][index]['color']}'),

                                ],
                              ),
                            )
                        ),
                      ),
                    ),
                  );
                },
                childCount: cartController.myOrdersDetails[indexA]['listProduct'].length,
                semanticIndexOffset: 2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
