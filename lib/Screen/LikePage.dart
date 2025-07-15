import 'package:appspertanian/helpers/database_helper.dart';
import 'package:appspertanian/models/liked_product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<LikedProduct> _likedProducts = [];

  @override
  void initState() {
    super.initState();
    _loadLikedProducts();
  }

  Future<void> _loadLikedProducts() async {
    final likedProducts = await _dbHelper.getLikedProducts();
    setState(() {
      _likedProducts = likedProducts;
    });
  }

  void _unlikeProduct(String productName) async {
    await _dbHelper.deleteLikedProductByName(productName);
    _loadLikedProducts();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$productName dihapus dari daftar suka.'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    final appBarTitleSize = isTablet ? screenWidth * 0.035 : screenWidth * 0.05;
    final emptyMessageSize = isTablet ? screenWidth * 0.03 : screenWidth * 0.04;
    final productNameSize =
        isTablet ? screenWidth * 0.028 : screenWidth * 0.035;
    final productPriceSize = isTablet ? screenWidth * 0.03 : screenWidth * 0.04;
    final unlikeIconSize = isTablet ? screenWidth * 0.035 : screenWidth * 0.05;

    final gridHorizontalPadding = screenWidth * (isTablet ? 0.06 : 0.08);
    final gridVerticalPadding = screenHeight * (isTablet ? 0.015 : 0.02);
    final productImageHeight = screenHeight * (isTablet ? 0.12 : 0.09);
    final imageErrorHeight = screenHeight * (isTablet ? 0.10 : 0.08);
    final unlikeIconTop = screenHeight * (isTablet ? 0.01 : 0.015);
    final unlikeIconRight = screenWidth * (isTablet ? 0.015 : 0.025);
    final unlikeIconPadding = screenWidth * (isTablet ? 0.008 : 0.012);
    final cardContentPadding = screenWidth * (isTablet ? 0.015 : 0.025);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Produk Disukai',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: appBarTitleSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: screenWidth * (isTablet ? 0.045 : 0.06),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:
          _likedProducts.isEmpty
              ? Center(
                child: Text(
                  'Belum ada produk yang disukai.',
                  style: GoogleFonts.roboto(
                    fontSize: emptyMessageSize,
                    color: Colors.grey,
                  ),
                ),
              )
              : GridView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: gridHorizontalPadding,
                  vertical: gridVerticalPadding,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 3 : 2,
                  crossAxisSpacing: screenWidth * (isTablet ? 0.03 : 0.05),
                  mainAxisSpacing: screenHeight * (isTablet ? 0.025 : 0.025),
                  childAspectRatio: isTablet ? 0.8 : 0.7,
                ),
                itemCount: _likedProducts.length,
                itemBuilder: (context, index) {
                  final product = _likedProducts[index];
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
                                product.imagePath,
                                height: productImageHeight,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: imageErrorHeight,
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
                              top: unlikeIconTop,
                              right: unlikeIconRight,
                              child: GestureDetector(
                                onTap: () => _unlikeProduct(product.name),
                                child: Container(
                                  padding: EdgeInsets.all(unlikeIconPadding),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: unlikeIconSize,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(cardContentPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.name,
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontSize: productNameSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  product.price,
                                  style: GoogleFonts.roboto(
                                    color: const Color(0xFF14A741),
                                    fontSize: productPriceSize,
                                    fontWeight: FontWeight.bold,
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
    );
  }
}
