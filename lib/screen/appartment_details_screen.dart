import 'package:booker/screen/rent_screen.dart';
import 'package:booker/service/profil_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:booker/model/apartment_model.dart';

class ApartmentDetailsScreen extends StatelessWidget {
  final ApartmentModel model;

  const ApartmentDetailsScreen({super.key, required this.model});

  static const Color mainColor = Color.fromRGBO(127, 86, 217, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Apartment Details",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: mainColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: mainColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼️ Apartment Image
            if (model.apartmentImage != null)
              CachedNetworkImage(
                imageUrl: model.apartmentImage!,
                placeholder: (_, __) => Image.asset("assets/placeholder.png"),
                errorWidget: (_, __, ___) =>
                    Image.asset("assets/placeholder.png"),
              ),

            const SizedBox(height: 16),

            // 🏠 Title: City + Governorate
            Text(
              "${model.city}, ${model.governorate}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            // 💰 Price
            Text(
              "${model.rentPrice} SYP / month",
              style: const TextStyle(
                fontSize: 18,
                color: mainColor,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 16),

            // 📊 Apartment Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoItem(Icons.bed, "${model.rooms} Beds"),
                _infoItem(Icons.bathtub, "${model.bathrooms} Baths"),
                _infoItem(Icons.square_foot, "${model.apartmentSpace} sqft"),
              ],
            ),

            const SizedBox(height: 24),

            // 👤 Owner Info (بدون صورة API حالياً)
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey[400],
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),

                const Expanded(
                  child: Text(
                    "Owner Name", // لاحقاً ديناميكي
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

                _circleIcon(
                  icon: Icons.phone,
                  color: Colors.green,
                  onTap: () {},
                ),
                const SizedBox(width: 12),
                _circleIcon(
                  icon: Icons.message,
                  color: mainColor,
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 🟣 Rent Now Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final repo = ProfileRepository();
                  final profile = await repo.loadProfile();

                  if (profile == null) {
                    print("⚠️ No profile found");
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          SelectDateScreen(model: model, profile: profile),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Rent Now",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: mainColor, size: 20),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }

  Widget _circleIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}
