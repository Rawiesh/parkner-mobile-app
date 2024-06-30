import 'package:flutter/material.dart';

class AreaCard extends StatelessWidget {
  final String imgUrl;
  final String name;
  final String? address;
  final String? distance;
  final String? price;

  const AreaCard({
    super.key,
    required this.imgUrl,
    required this.name,
    this.address,
    this.distance,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xffe6f7f7),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imgUrl,
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff06100E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff38403E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      distance ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff38403E),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              price != null ? "SRD $price" : "",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xff358c7c),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
