

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/routes.dart';
import '../../view/rounded_img.dart';

class MainPageNew extends HookConsumerWidget {
  const MainPageNew({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    ref.read(driverProvider.future);
    final user = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/Logo.png'),
        actions: const [
          FaIcon(
            FontAwesomeIcons.bell,
            size: 24,
            color: Colors.black,
          ),
          SizedBox(width: 16,),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: FaIcon(
              FontAwesomeIcons.bars,
              size: 25,
              color: Colors.black,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context)
                .size
                .height, // Make sure the scrollable area has a minimum height
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Chào Bạn Đã Đến Với NeighborHub",
                      style: TextStyle(
                        color: Color(0xFFCC2C70),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        "xin chào, ${user.value?.username ?? "Bạn".toUpperCase()}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to the Booking Car screen when tapped
                            context.pushNamed(Routes.destinationPick);
                          },
                          child: Column(
                            children: [
                              _buildCircleIcon('images/cars.png'),
                              const Text(
                                "Ô tô",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(Routes.destinationPick);
                          },
                          child: Column(
                            children: [
                              _buildCircleIcon('images/bike.png'),
                              const Text("Xe máy",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(Routes.destinationPick);
                          },
                          child: Column(
                            children: [
                              _buildCircleIcon('images/clock.png'),
                              const Text("Đặt trước",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.pushNamed(Routes.voucher),
                          child: Column(
                            children: [
                              _buildCircleIcon('images/voucher.png'),
                              const Text("Voucher",
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            _buildCircleIcon('images/action_key.png'),
                            const Text("Tất cả",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // _buildInfoCard("images/wallet.png", screenWidth,
                        //     "Thanh Toán", "Thêm thẻ"),
                        // TextButton(onPressed: () async {
                        //   print(await ref.read(driverProvider.future));
                        // }, child: Text('aaa')),
                        _buildInfoCard(
                            "images/coin.png", screenWidth, "Tích điểm", "100000"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Khám phá ngay",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(width: 6),
                        Icon(FontAwesomeIcons.arrowRight, size: 22)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32,),
              RoundedImage(
                imgPath: "images/banner_1.png",
                width: screenWidth * 0.6,
              ),
              SizedBox(height: 32,),
              RoundedImage(
                imgPath: "images/banner_2.png",
                width: screenWidth * 0.6,
              ),
              SizedBox(height: 32,),
              RoundedImage(
                imgPath: "images/banner_3.png",
                width: screenWidth * 0.6,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleIcon(String imagePath) {
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xFFFBEAEB),
        shape: BoxShape.circle,
      ),
      child: Image.asset(imagePath, width: 100, height: 100),
    );
  }

  Widget _buildInfoCard(
      String imgPath, double screenWidth, String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF9FA1A6).withOpacity(0.2),
        borderRadius: BorderRadius.circular(10), // Optional: round the corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02), // Shadow color
            spreadRadius: 2, // How much the shadow spreads
            blurRadius: 5, // How blurry the shadow is
            offset: const Offset(
                0, 4), // Horizontal and vertical offset of the shadow
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: screenWidth * 0.42, // Set the minimum width
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Image.asset(imgPath, width: 30, height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
