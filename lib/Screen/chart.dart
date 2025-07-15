import 'package:appspertanian/Screen/LikePage.dart';
import 'package:appspertanian/Screen/cart_page.dart';
import 'package:appspertanian/helpers/database_helper.dart';
import 'package:appspertanian/models/liked_product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

final List<Map<String, dynamic>> _products = [
  {
    'name': 'Bibit Padi Unggul',
    'price': 'Rp 50.000',
    'stocks': 25,
    'rating': 4.8,
    'reviews': 150,
    'imagePath': 'assets/images/pakan1.webp',
  },
  {
    'name': 'Pupuk Organik Cair',
    'price': 'Rp 75.000',
    'stocks': 30,
    'rating': 4.7,
    'reviews': 180,
    'imagePath': 'assets/images/pakan2.jpeg',
  },
  {
    'name': 'Traktor Mini',
    'price': 'Rp 15.000.000',
    'stocks': 5,
    'rating': 4.8,
    'reviews': 95,
    'imagePath': 'assets/images/pakan3.jpg',
  },
  {
    'name': 'Pestisida Alami',
    'price': 'Rp 45.000',
    'stocks': 40,
    'rating': 4.6,
    'reviews': 110,
    'imagePath': 'assets/images/image_83f920_product4.png',
  },
  {
    'name': 'Pestisida Alami',
    'price': 'Rp 45.000',
    'stocks': 40,
    'rating': 4.6,
    'reviews': 110,
    'imagePath': 'assets/images/pakan2.jpeg',
  },
  {
    'name': 'Pestisida Alami',
    'price': 'Rp 45.000',
    'stocks': 40,
    'rating': 4.6,
    'reviews': 110,
    'imagePath': 'assets/images/pakan3.jpg',
  },
];

class _ChartState extends State<Chart> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Set<String> _likedProductNames = {};
  List<Map<String, dynamic>> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadLikedProducts();
  }

  Future<void> _loadLikedProducts() async {
    final likedProducts = await _dbHelper.getLikedProducts();
    setState(() {
      _likedProductNames = likedProducts.map((p) => p.name).toSet();
    });
  }

  void _toggleLike(Map<String, dynamic> product) async {
    final likedProduct = LikedProduct(
      name: product['name'],
      price: product['price'],
      imagePath: product['imagePath'],
    );

    if (_likedProductNames.contains(product['name'])) {
      await _dbHelper.deleteLikedProductByName(product['name']);
    } else {
      await _dbHelper.insertLikedProduct(likedProduct);
    }
    _loadLikedProducts();
  }

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      final existingItemIndex = _cartItems.indexWhere(
        (item) => item['name'] == product['name'],
      );
      if (existingItemIndex != -1) {
        _cartItems[existingItemIndex]['quantity']++;
      } else {
        _cartItems.add({...product, 'quantity': 1});
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} ditambahkan ke keranjang.'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    final searchHintTextSize =
        isTablet ? screenWidth * 0.025 : screenWidth * 0.035;
    final searchIconSize = isTablet ? screenWidth * 0.035 : screenWidth * 0.05;
    final featuredProductsTitleSize =
        isTablet ? screenWidth * 0.038 : screenWidth * 0.05;
    final topIconSize = isTablet ? screenWidth * 0.045 : screenWidth * 0.06;
    final productNameSize =
        isTablet ? screenWidth * 0.028 : screenWidth * 0.035;
    final productStockSize =
        isTablet ? screenWidth * 0.022 : screenWidth * 0.03;
    final productRatingTextSize =
        isTablet ? screenWidth * 0.022 : screenWidth * 0.03;
    final productPriceSize = isTablet ? screenWidth * 0.03 : screenWidth * 0.04;
    final productStarIconSize =
        isTablet ? screenWidth * 0.03 : screenWidth * 0.04;
    final addBtnTextSize = isTablet ? screenWidth * 0.03 : screenWidth * 0.035;
    final cartCountTextSize =
        isTablet ? screenWidth * 0.02 : screenWidth * 0.025;

    final topPadding = screenHeight * (isTablet ? 0.03 : 0.04);
    final horizontalPadding = screenWidth * (isTablet ? 0.06 : 0.08);
    final searchVerticalPadding = screenHeight * (isTablet ? 0.01 : 0.005);
    final searchHorizontalPadding = screenWidth * (isTablet ? 0.03 : 0.04);
    final productCardHorizontalPadding =
        screenWidth * (isTablet ? 0.03 : 0.025);
    final productImageHeight = screenHeight * (isTablet ? 0.12 : 0.09);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: searchHorizontalPadding,
                  vertical: searchVerticalPadding,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search products...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: searchIconSize,
                    ),
                    hintStyle: GoogleFonts.roboto(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: searchHintTextSize,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * (isTablet ? 0.03 : 0.03)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Products',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: featuredProductsTitleSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: topIconSize,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LikePage(),
                            ),
                          );
                        },
                      ),
                      Stack(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.black,
                              size: topIconSize,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          CartPage(cartItems: _cartItems),
                                ),
                              ).then((_) => setState(() {}));
                            },
                          ),
                          if (_cartItems.isNotEmpty)
                            Positioned(
                              right: screenWidth * (isTablet ? 0.005 : 0.008),
                              top: screenHeight * (isTablet ? 0.005 : 0.008),
                              child: Container(
                                padding: EdgeInsets.all(
                                  screenWidth * (isTablet ? 0.006 : 0.008),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                constraints: BoxConstraints(
                                  minWidth:
                                      screenWidth * (isTablet ? 0.03 : 0.04),
                                  minHeight:
                                      screenWidth * (isTablet ? 0.03 : 0.04),
                                ),
                                child: Text(
                                  _cartItems
                                      .fold(
                                        0,
                                        (sum, item) =>
                                            sum + item['quantity'] as int,
                                      )
                                      .toString(),
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: cartCountTextSize,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 3 : 2,
                  crossAxisSpacing: screenWidth * (isTablet ? 0.03 : 0.05),
                  mainAxisSpacing: screenHeight * (isTablet ? 0.025 : 0.025),
                  childAspectRatio: isTablet ? 0.75 : 0.65,
                ),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  final isLiked = _likedProductNames.contains(product['name']);
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              child: Image.asset(
                                product['imagePath'],
                                height: productImageHeight,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: productImageHeight,
                                    width: double.infinity,
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: screenHeight * (isTablet ? 0.01 : 0.015),
                              right: screenWidth * (isTablet ? 0.015 : 0.025),
                              child: GestureDetector(
                                onTap: () => _toggleLike(product),
                                child: Container(
                                  padding: EdgeInsets.all(
                                    screenWidth * (isTablet ? 0.008 : 0.012),
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isLiked ? Colors.red : Colors.red,
                                    size:
                                        screenWidth * (isTablet ? 0.035 : 0.05),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(
                              screenWidth * (isTablet ? 0.015 : 0.025),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product['name'],
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontSize: productNameSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${product['stocks']} Stocks Left',
                                  style: GoogleFonts.roboto(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: productStockSize,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: productStarIconSize,
                                    ),
                                    SizedBox(width: screenWidth * 0.01),
                                    Text(
                                      '${product['rating']} (${product['reviews']})',
                                      style: GoogleFonts.roboto(
                                        color: Colors.black.withOpacity(0.7),
                                        fontSize: productRatingTextSize,
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () => _addToCart(product),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF14A741),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            screenWidth *
                                            (isTablet ? 0.015 : 0.02),
                                        vertical:
                                            screenHeight *
                                            (isTablet ? 0.008 : 0.005),
                                      ),
                                      minimumSize: Size(
                                        screenWidth * (isTablet ? 0.1 : 0.15),
                                        screenHeight *
                                            (isTablet ? 0.025 : 0.03),
                                      ),
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'Add',
                                        style: GoogleFonts.roboto(
                                          fontSize: addBtnTextSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
