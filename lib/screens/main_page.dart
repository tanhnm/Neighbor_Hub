import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/widgets/imageRounded/rounded_img.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/BookingCarScreen/destination_pick.dart';
import 'package:flutter_application_1/screens/Driver/map_driver_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  User? user;
  Box? userBox;
  Future<User>? userIdFuture;
  @override
  void initState() {
    super.initState();
    _initializeHiveBox();
  }

  Future<void> _initializeHiveBox() async {
    try {
      userBox = await Hive.openBox<User>('users');
      setState(() {
        userIdFuture = _loadUser();
        userIdFuture!.then((value) => user = value);
      });
    } catch (e) {
      print('Error opening Hive box: $e');
    }
  }

  Future<User> _loadUser() async {
    try {
      user = userBox?.get('user');
      if (user == null) {
        throw Exception('No user found in the Hive box.');
      }
      print('User: ${user?.username.toString()}');
      return user!;
    } catch (e) {
      print('Error loading user: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    getToken() async {
      var box = await Hive.openBox('authBox');
      String token = await box.get('token', defaultValue: null);
      return token;
    }

    getToken().then((value) {
      print(value);
    });

    return Scaffold(
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
              Container(
                height: 100,
                color: const Color(0xFFCC2C70), // Set background color
              ),
              const SizedBox(height: 14),
              Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle, // Makes the container a circle
                      ),
                      child: Image.asset('images/Logo.png',
                          width: 100, height: 100),
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.bell,
                          size: 24,
                          color: Colors.black,
                        ),
                        SizedBox(width: 20),
                        FaIcon(
                          FontAwesomeIcons.bars,
                          size: 25,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                        "xin chào, ${user?.username ?? "Bạn".toUpperCase()}",
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DestinationPick(),
                              ),
                            );
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DestinationPick(),
                              ),
                            );
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DestinationPick(),
                              ),
                            );
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
                        Column(
                          children: [
                            _buildCircleIcon('images/voucher.png'),
                            const Text("Voucher",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
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
                        _buildInfoCard("images/wallet.png", screenWidth,
                            "Thanh Toán", "Thêm thẻ"),
                        _buildInfoCard(
                            "images/coin.png", screenWidth, "Tích điểm", "50"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text("Khám phá ngay",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(width: 6),
                        Icon(FontAwesomeIcons.arrowRight, size: 22)
                      ],
                    ),
                    CarouselSlider(
                      items: const [
                        RoundedImage(imgPath: "images/banner_1.png"),
                      ],
                      options: CarouselOptions(
                        height: 200, // Set a fixed height
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        enlargeCenterPage: true,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundedImage(
                        imgPath: "images/banner_2.png",
                        width: screenWidth * 0.4,
                      ),
                      RoundedImage(
                        imgPath: "images/banner_3.png",
                        width: screenWidth * 0.4,
                      ),
                    ],
                  ))
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
