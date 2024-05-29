import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.product,
  });

  final product;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 500,
      width: 300,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // color: Colors.grey.shade600,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Image.network(
        product.image,
      ),
    );
  }
}
