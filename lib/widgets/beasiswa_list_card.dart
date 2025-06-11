// lib/widgets/beasiswa_list_card.dart

import 'package:beasiswa/models/beasiswa_model.dart';
import 'package:beasiswa/pages/home/beasiswa_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:beasiswa/theme.dart';

class BeasiswaListCard extends StatelessWidget {
  final BeasiswaModel beasiswa;
  final String status;
  const BeasiswaListCard({
    required this.beasiswa,
    required this.status,
    Key? key,
  }) : super(key: key);

  Widget _buildStatusBadge(String status) {
    Color statusColor;
    String statusText;

    switch (status.toLowerCase()) {
      case 'accepted':
        statusColor = Colors.green;
        statusText = 'Diterima';
        break;
      case 'rejected':
        statusColor = alertColor;
        statusText = 'Ditolak';
        break;
      case 'pending':
      default:
        statusColor = secondaryColor;
        statusText = 'Pending';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

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
                  const SizedBox(height: 6),
                  _buildStatusBadge(status),
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
