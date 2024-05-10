import 'package:flutter/material.dart';
import 'package:puc_minas/app/core/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: product.color,
        ),
        color: product.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(product.title),
              Text(product.genre),
            ],
          ),
          Divider(
            color: product.color,
            thickness: 1.5,
          ),
          Text(product.description),
        ],
      ),
    );
  }
}
