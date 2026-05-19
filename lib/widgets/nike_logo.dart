import 'package:flutter/material.dart';
import 'package:shop/core/theme/app_colors.dart';

class NikeLogo extends StatelessWidget {
  const NikeLogo({super.key, this.height = 22, this.color});

  final double height;
  final Color? color;

  static const _assetPath = 'assets/images/nike_swoosh.png';

  @override
  Widget build(BuildContext context) {
    final width = height * 3.2;
    final image = Image.asset(
      _assetPath,
      height: height,
      width: width,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      isAntiAlias: true,
    );

    final logo = color == null
        ? image
        : ColorFiltered(
            colorFilter: ColorFilter.mode(
              color ?? AppColors.primary,
              BlendMode.srcIn,
            ),
            child: image,
          );

    return SizedBox(
      width: width,
      height: height,
      child: logo,
    );
  }
}
