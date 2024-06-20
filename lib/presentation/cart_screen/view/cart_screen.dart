import 'package:flutter/material.dart';
import 'package:hypermarket_user/core/constants/color.dart';
import 'package:hypermarket_user/presentation/cart_screen/controller/cart_screen_controller.dart';
import 'package:hypermarket_user/presentation/cart_screen/view/widgets/custom_cart_card.dart';
//import 'package:hypermarket_user/presentation/product_details_screen/view/product_details_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<CartScreenController>(context, listen: false)
          .getCartItems();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartScreenController>(context);
    return Scaffold(
      backgroundColor: ColorConstant.primaryGreen,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 20,
                        ),
                      ),
                    ),
                    Text(
                      "Cart",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: const Color.fromARGB(255, 255, 255, 255)),
                    ),
                    InkWell(
                      child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 218, 179, 25),
                          child: Text(
                            cartProvider.cartitemList.length.toString(),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                        MediaQuery.of(context).size.width, 100.0)),
                color: Colors.white,
              ),
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: cartProvider.cartitemList.isEmpty
                    ? Center(
                        child: Text("Cart Empty"),
                      )
                    : cartProvider.cartitemListLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.separated(
                            itemCount: cartProvider.cartitemList.length,
                            itemBuilder: (context, index) => CustomCartItem(
                                  image: cartProvider
                                          .cartitemList[index].product?.image ??
                                      '',
                                  price: cartProvider
                                          .cartitemList[index].product?.price ??
                                      '',
                                  category: cartProvider.cartitemList[index]
                                          .product?.category ??
                                      '',
                                  name: cartProvider
                                          .cartitemList[index].product?.name ??
                                      '',
                                  inx: index,
                                  delete: () async {
                                    await Provider.of<CartScreenController>(
                                            context,
                                            listen: false)
                                        .deleteCartItem(
                                            id: cartProvider.cartitemList[index]
                                                    .product?.id
                                                    .toString() ??
                                                "");
                                  },
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                )),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
