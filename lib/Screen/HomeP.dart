import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Homep extends StatefulWidget {
  const Homep({super.key});

  @override
  State<Homep> createState() => _HomepState();
}

class _HomepState extends State<Homep> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  final List<Map<String, dynamic>> _banners = [
    {
      'title': 'Get 30% OFF !',
      'subtitle': 'Limited time offer. Shop now!',
      'backgroundColor': const Color(0xFF14A741),
      'buttonColor': const Color(0xFFFFF066),
      'imagePath': 'assets/images/sapi.png',
    },
    {
      'title': 'Summer Collection Sale!',
      'subtitle': 'New farm. Up to 50% off!',
      'backgroundColor': const Color(0xFF14A741),
      'buttonColor': const Color(0xFFFFF066),
      'imagePath': 'assets/images/image_846980.png',
    },
    {
      'title': 'Flash Deals Today!',
      'subtitle': 'Don\'t miss out on amazing discounts. farm',
      'backgroundColor': const Color(0xFF14A741),
      'buttonColor': const Color(0xFFFFF066),
      'imagePath': 'assets/images/image_846980.png',
    },
  ];
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
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    final welcomeTextSize = isTablet ? screenWidth * 0.02 : screenWidth * 0.035;
    final enjoyShoppingTextSize =
        isTablet ? screenWidth * 0.03 : screenWidth * 0.04;
    final searchHintTextSize =
        isTablet ? screenWidth * 0.03 : screenWidth * 0.035;
    final searchIconSize = isTablet ? screenWidth * 0.04 : screenWidth * 0.05;
    final bannerTitleSize =
        isTablet ? screenWidth * 0.035 : screenWidth * 0.045;
    final bannerSubtitleSize =
        isTablet ? screenWidth * 0.025 : screenWidth * 0.035;
    final featuredProductsTitleSize =
        isTablet ? screenWidth * 0.04 : screenWidth * 0.05;
    final productNameSize =
        isTablet ? screenWidth * 0.028 : screenWidth * 0.035;
    final productStockSize =
        isTablet ? screenWidth * 0.024 : screenWidth * 0.03;
    final productRatingSize =
        isTablet ? screenWidth * 0.024 : screenWidth * 0.03;
    final productPriceSize =
        isTablet ? screenWidth * 0.032 : screenWidth * 0.04;
    final productStarIconSize =
        isTablet ? screenWidth * 0.03 : screenWidth * 0.04;

    final appBarTopPadding = screenHeight * (isTablet ? 0.03 : 0.02);
    final horizontalPadding = screenWidth * (isTablet ? 0.06 : 0.08);
    final searchVerticalPadding = screenHeight * (isTablet ? 0.01 : 0.005);
    final searchHorizontalPadding = screenWidth * (isTablet ? 0.03 : 0.04);
    final bannerHeight = screenHeight * (isTablet ? 0.25 : 0.18);
    final bannerImageWidth = screenWidth * (isTablet ? 0.25 : 0.35);
    final bannerImageHeight = screenHeight * (isTablet ? 0.15 : 0.18);
    final indicatorContainerHeight = screenHeight * (isTablet ? 0.04 : 0.035);
    final indicatorContainerWidth = screenWidth * (isTablet ? 0.20 : 0.30);
    final indicatorDotHeight = screenHeight * (isTablet ? 0.012 : 0.008);
    final indicatorDotWidthActive = screenWidth * (isTablet ? 0.03 : 0.04);
    final indicatorDotWidthInactive = screenWidth * (isTablet ? 0.01 : 0.015);
    final productCardWidth = screenWidth * (isTablet ? 0.2 : 0.4);
    final productCardHeight = screenHeight * (isTablet ? 0.28 : 0.32);
    final productImageHeight = screenHeight * (isTablet ? 0.10 : 0.12);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Padding(
            padding: EdgeInsets.only(top: appBarTopPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Welcome Back',
                          style: GoogleFonts.roboto(
                            color: Colors.black.withOpacity(0.2),
                            fontSize: welcomeTextSize,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        SvgPicture.asset(
                          'assets/images/hand-shake-svgrepo-com (1).svg',
                          height: screenHeight * (isTablet ? 0.03 : 0.025),
                          width: screenWidth * (isTablet ? 0.04 : 0.05),
                        ),
                      ],
                    ),
                    Text(
                      'Enjoy shopping',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: enjoyShoppingTextSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.03),
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
                    hintText: 'Search...',
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
            SizedBox(height: screenHeight * 0.025),
            SizedBox(
              height: bannerHeight,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _banners.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final banner = _banners[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(
                        screenWidth * (isTablet ? 0.03 : 0.05),
                      ),
                      decoration: BoxDecoration(
                        color: banner['backgroundColor'],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: isTablet ? 3 : 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  banner['title'],
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: bannerTitleSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.008),
                                Text(
                                  banner['subtitle'],
                                  style: GoogleFonts.roboto(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: bannerSubtitleSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.025),
                          Expanded(
                            flex: isTablet ? 2 : 1,
                            child: Container(
                              width: bannerImageWidth,
                              height: bannerImageHeight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                banner['imagePath'],
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
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
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: screenHeight * (isTablet ? 0.02 : 0.015)),
            Center(
              child: Container(
                height: indicatorContainerHeight,
                width: indicatorContainerWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_banners.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * (isTablet ? 0.008 : 0.01),
                      ),
                      height: indicatorDotHeight,
                      width:
                          _currentPage == index
                              ? indicatorDotWidthActive
                              : indicatorDotWidthInactive,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index
                                ? const Color(0xFF14A741)
                                : Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                'Featured Products',
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: featuredProductsTitleSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 3 : 2,
                  childAspectRatio: isTablet ? 0.8 : 0.7,
                  crossAxisSpacing: screenWidth * 0.04,
                  mainAxisSpacing: screenHeight * 0.03,
                ),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  final bool isLiked = false;

                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                        fontSize: productRatingSize,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  product['price'],
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
            ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }
}
