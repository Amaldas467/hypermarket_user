import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hypermarket_user/app_config/app_config.dart';
import 'package:hypermarket_user/core/constants/color.dart';
import 'package:hypermarket_user/presentation/cart_screen/view/cart_screen.dart';
import 'package:hypermarket_user/presentation/category_screen/controller/category_screen_controller.dart';
import 'package:hypermarket_user/presentation/category_screen/view/widgets/popular_items_widgets.dart';
import 'package:hypermarket_user/presentation/product_screen/view/product_List_screen.dart';
import 'package:hypermarket_user/presentation/category_search_screen/view/search_screen.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<CategoryScreenController>(context, listen: false)
          .getCategoryList();
      await Provider.of<CategoryScreenController>(context, listen: false)
          .getFavorateList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryScreenController>(context);
    final favorateProvider = Provider.of<CategoryScreenController>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: ColorConstant.primaryGreen,
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Hi Buddy!",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Welcome Back",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 30,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            IconButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CartScreen(),
                                    )),
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 25,
                                ))
                          ],
                        )
                      ],
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => CartScreen(),
                    //       ),
                    //     );
                    //   },
                    //   child: CircleAvatar(
                    //     radius: 25,
                    //     child: Icon(Icons.shopping_cart),
                    //   ),
                    // )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // Text(
                //   "Current Location :  ${_locationMessage}",
                //   style: TextStyle(color: Color.fromARGB(255, 190, 214, 11)),
                // ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(),
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Search...",
                        ),
                        Icon(Icons.search)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          CarouselSlider(
            items: [
              Image.asset("assets/2.png"),
              Image.asset("assets/3.png"),
              Image.asset("assets/4.png"),
            ],
            options: CarouselOptions(
                enlargeFactor: 4,
                autoPlay: true,
                viewportFraction: 1,
                enlargeCenterPage: true),
          ),
          SizedBox(
            height: 15,
          ),
          favorateProvider.favorateList.length <= 0
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Suggestions for you...",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
          SizedBox(
            height: 15,
          ),
          favorateProvider.favorateList.length <= 0
              ? SizedBox()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 130,
                  child: Center(
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => PopularItemcard(
                              image:
                                  favorateProvider.favorateList[index].image ??
                                      "",
                              qty: favorateProvider.favorateList[index].quantity
                                  .toString(),
                              price:
                                  favorateProvider.favorateList[index].price ??
                                      "",
                              index: index,
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 15,
                            ),
                        itemCount: favorateProvider.favorateList.length),
                  ),
                ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      " Categories",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                categoryProvider.isCategoryLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : GridView.builder(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: categoryProvider.categoryScreenList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            mainAxisExtent: 140),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductListScreen(
                                  produtid: categoryProvider
                                      .categoryScreenList[index].id
                                      .toString(),
                                ),
                              ),
                            );
                            print(
                                "${categoryProvider.categoryScreenList[index].name}");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      height: 100,
                                      width: double.infinity,
                                      child: Image.network(
                                        AppConfig.mediaUrl +
                                            categoryProvider
                                                .categoryScreenList[index]
                                                .image!,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  categoryProvider
                                          .categoryScreenList[index].name ??
                                      "",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
