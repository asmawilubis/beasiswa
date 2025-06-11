// lib/widgets/beasiswa_list_card.dart

import 'package:beasiswa/models/beasiswa_model.dart';
import 'package:beasiswa/pages/home/beasiswa_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:beasiswa/theme.dart';

class BeasiswaListCard extends StatelessWidget {
  final BeasiswaModel beasiswa;
  const BeasiswaListCard({required this.beasiswa, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BeasiswaDetailPage(beasiswa: beasiswa),
            ),
          ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20), // Ganti top menjadi bottom
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor2, // Warna latar
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/img_beasiswa.png', // Placeholder, ganti jika ada URL gambar
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    beasiswa.name, // Data dinamis
                    style: formTextStyle.copyWith(fontWeight: semiBold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    beasiswa.category.name, // Data dinamis
                    style: secondaryTextStyle.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: subtitleTextColor),
          ],
        ),
      ),
    );
  }
}
