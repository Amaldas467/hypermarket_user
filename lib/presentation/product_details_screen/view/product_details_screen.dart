import 'package:flutter/material.dart';
import 'package:hypermarket_user/app_config/app_config.dart';

import 'package:hypermarket_user/core/constants/color.dart';
import 'package:hypermarket_user/presentation/bottom_nav_screen/view/bottom_nav_screen.dart';

import 'package:hypermarket_user/presentation/payment_screen/view/payment_screen.dart';
import 'package:hypermarket_user/presentation/product_details_screen/controller/product_details_screen_controller.dart';

import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String id;
  const ProductDetailsScreen({super.key, required this.id});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<ProductDetailsScreenController>(context, listen: false)
          .getProductDetailsScreenList(id: widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("this is the id passing the product screen : ${widget.id}");
    final productProvider =
        Provider.of<ProductDetailsScreenController>(context);
    Provider.of<ProductDetailsScreenController>(context, listen: false)
        .calculateTotalPrice(
            prices: Provider.of<ProductDetailsScreenController>(context)
                    .productData
                    ?.price ??
                '');

    String image = productProvider.productData?.image ?? "";
    int qty = productProvider.productData!.quantity ?? 0;
    return Scaffold(
      backgroundColor: ColorConstant.primaryGreen,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavScreen(),
                            ));
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 20,
                        ),
                      ),
                    ),
                    Text(
                      "Product Details",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: productProvider.getProductLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                height: 280,
                                width: MediaQuery.of(context).size.width * .75,
                                child: Image.network(
                                  AppConfig.mediaUrl + image,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  productProvider.productData?.price ?? "",
                                  style: TextStyle(
                                      height: 1.7,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              productProvider.productData?.name ?? "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              productProvider.productData?.description ?? "",
                              style: TextStyle(
                                height: 1.7,
                                fontSize: 14,
                              ),
                              maxLines: 8,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                qty == 0
                                    ? Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.red,
                                        ),
                                        child: Text(
                                          "Out of Stock",
                                          style: TextStyle(color: Colors.white),
                                        ))
                                    : Text("$qty Available"),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.light,
                                      color: Colors.purple,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Fast Devivery Available",
                                      style: TextStyle(
                                        height: 1.7,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100],
                              ),
                              height: 60,
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.sizeOf(context).width / 2,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              productProvider.quantity > 1
                                                  ? Provider.of<
                                                              ProductDetailsScreenController>(
                                                          context,
                                                          listen: false)
                                                      .decrementQuantity()
                                                  : productProvider.quantity;
                                            },
                                            child: Container(
                                              child: Center(
                                                child: Icon(Icons.remove),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Center(
                                                child: Text(productProvider
                                                    .quantity
                                                    .toString())),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Provider.of<ProductDetailsScreenController>(
                                                      context,
                                                      listen: false)
                                                  .incrementQuantity();
                                            },
                                            child: Container(
                                              child: Center(
                                                child: Icon(Icons.add),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: qty != 0
                                          ? () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content:
                                                      Text('Product Added'),
                                                ),
                                              );
                                              Provider.of<ProductDetailsScreenController>(
                                                      context,
                                                      listen: false)
                                                  .addtocart(id: widget.id);
                                            }
                                          : () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text('Out of Stock'),
                                                ),
                                              );
                                            },
                                      child: Container(
                                        color: Colors.amber,
                                        child: Center(
                                          child: Text("Add to Cart"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Total amount :  "),
                                Consumer(
                                  builder: (context, value, child) => Text(
                                    Provider.of<ProductDetailsScreenController>(
                                            context)
                                        .totalProdPrice
                                        .toString(),
                                    style: TextStyle(
                                        height: 1.7,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: qty != 0
                  ? () async {
                      await Provider.of<ProductDetailsScreenController>(context,
                              listen: false)
                          .purchase(
                              pro_id: int.parse(widget.id),
                              quantity: productProvider.quantity);
                      await Provider.of<ProductDetailsScreenController>(context,
                              listen: false)
                          .resetQuantity();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaymentPage()),
                      );
                    }
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Out of Stock'),
                        ),
                      );
                    },
              child: Container(
                height: 60,
                color: Colors.amber,
                child: Center(
                  child: Text("Buy Now"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
