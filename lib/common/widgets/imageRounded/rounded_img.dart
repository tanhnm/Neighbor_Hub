import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imgPath,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor = Colors.white,
    this.padding,
    this.isNetworkImage = false,
    this.fit = BoxFit.contain,
    this.onPressed,
    this.borderRadius = 10.0,
  });

  final double? width, height;
  final String imgPath;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BoxFit? fit;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius)),
      child: ClipRRect(
        borderRadius: applyImageRadius
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.zero,
        child: Image(
            fit: fit,
            width: width,
            height: height,
            image: isNetworkImage
                ? NetworkImage(imgPath) as ImageProvider<Object>
                : AssetImage(imgPath) as ImageProvider<Object>),
      ),
    );
  }
}
