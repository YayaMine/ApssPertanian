import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Map<String, dynamic>> _currentCartItems;

  @override
  void initState() {
    super.initState();
    _currentCartItems =
        widget.cartItems
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
  }

  void _incrementQuantity(int index) {
    setState(() {
      _currentCartItems[index]['quantity']++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (_currentCartItems[index]['quantity'] > 1) {
        _currentCartItems[index]['quantity']--;
      } else {
        _currentCartItems.removeAt(index);
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _currentCartItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item dihapus dari keranjang.'),
        backgroundColor: Colors.red,
      ),
    );
  }

  double _calculateTotalPrice() {
    double total = 0.0;
    for (var item in _currentCartItems) {
      String priceString = item['price']
          .replaceAll('Rp ', '')
          .replaceAll('.', '');
      total += double.parse(priceString) * item['quantity'];
    }
    return total;
  }

  Future<void> _launchMidtransPayment() async {
    if (_currentCartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Keranjang Anda kosong. Tambahkan item sebelum checkout.',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final totalPrice = _calculateTotalPrice();
    const midtransPaymentUrl = 'https://midtrans.com/simulated-payment?amount=';

    final url = Uri.parse(
      '$midtransPaymentUrl${totalPrice.toStringAsFixed(0)}',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
      setState(() {
        _currentCartItems.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Tidak dapat meluncurkan URL pembayaran. Pastikan Anda memiliki browser.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    final appBarTitleSize = isTablet ? screenWidth * 0.035 : screenWidth * 0.05;
    final emptyCartTextSize =
        isTablet ? screenWidth * 0.03 : screenWidth * 0.04;
    final itemNameSize = isTablet ? screenWidth * 0.028 : screenWidth * 0.04;
    final itemPriceSize = isTablet ? screenWidth * 0.025 : screenWidth * 0.038;
    final quantityTextSize =
        isTablet ? screenWidth * 0.028 : screenWidth * 0.04;
    final quantityIconSize =
        isTablet ? screenWidth * 0.045 : screenWidth * 0.06;
    final deleteIconSize = isTablet ? screenWidth * 0.045 : screenWidth * 0.06;
    final totalTextSize = isTablet ? screenWidth * 0.035 : screenWidth * 0.05;
    final payButtonTextSize =
        isTablet ? screenWidth * 0.03 : screenWidth * 0.045;

    final listHorizontalPadding = screenWidth * (isTablet ? 0.04 : 0.05);
    final listVerticalPadding = screenHeight * (isTablet ? 0.015 : 0.02);
    final cardBottomMargin = screenHeight * (isTablet ? 0.01 : 0.015);
    final cardPadding = screenWidth * (isTablet ? 0.02 : 0.03);
    final imageWidth = screenWidth * (isTablet ? 0.12 : 0.18);
    final imageHeight = screenHeight * (isTablet ? 0.07 : 0.08);
    final imageErrorHeight = screenHeight * (isTablet ? 0.06 : 0.07);
    final itemHorizontalSpacing = screenWidth * (isTablet ? 0.03 : 0.04);
    final totalPadding = screenWidth * (isTablet ? 0.04 : 0.05);
    final totalButtonVerticalSpacing = screenHeight * (isTablet ? 0.015 : 0.02);
    final payButtonHeight = screenHeight * (isTablet ? 0.06 : 0.07);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Keranjang Belanja',
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
            Navigator.pop(context, _currentCartItems);
          },
        ),
      ),
      body:
          _currentCartItems.isEmpty
              ? Center(
                child: Text(
                  'Keranjang Anda kosong.',
                  style: GoogleFonts.roboto(
                    fontSize: emptyCartTextSize,
                    color: Colors.grey,
                  ),
                ),
              )
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: listHorizontalPadding,
                        vertical: listVerticalPadding,
                      ),
                      itemCount: _currentCartItems.length,
                      itemBuilder: (context, index) {
                        final item = _currentCartItems[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: cardBottomMargin),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(cardPadding),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    item['imagePath'],
                                    height: imageHeight,
                                    width: imageWidth,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: imageErrorHeight,
                                        width: imageWidth,
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
                                SizedBox(width: itemHorizontalSpacing),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item['name'],
                                        style: GoogleFonts.inter(
                                          fontSize: itemNameSize,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: screenHeight * 0.005),
                                      Text(
                                        item['price'],
                                        style: GoogleFonts.roboto(
                                          color: const Color(0xFF14A741),
                                          fontSize: itemPriceSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: itemHorizontalSpacing),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove_circle_outline,
                                            size: quantityIconSize,
                                            color: Colors.grey[600],
                                          ),
                                          onPressed:
                                              () => _decrementQuantity(index),
                                        ),
                                        Text(
                                          item['quantity'].toString(),
                                          style: GoogleFonts.roboto(
                                            fontSize: quantityTextSize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.add_circle_outline,
                                            size: quantityIconSize,
                                            color: Colors.grey[600],
                                          ),
                                          onPressed:
                                              () => _incrementQuantity(index),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: deleteIconSize,
                                      ),
                                      onPressed: () => _removeItem(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(totalPadding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: GoogleFonts.inter(
                                fontSize: totalTextSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rp ${_calculateTotalPrice().toStringAsFixed(0)}',
                              style: GoogleFonts.roboto(
                                fontSize: totalTextSize,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF14A741),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: totalButtonVerticalSpacing),
                        ElevatedButton(
                          onPressed: _launchMidtransPayment,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF14A741),
                            foregroundColor: Colors.white,
                            minimumSize: Size(double.infinity, payButtonHeight),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            'Bayar dengan Midtrans',
                            style: GoogleFonts.roboto(
                              fontSize: payButtonTextSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
