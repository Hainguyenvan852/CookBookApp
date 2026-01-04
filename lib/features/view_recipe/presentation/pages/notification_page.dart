import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';
import 'package:shimmer/shimmer.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 22,)
        ),
        title: const Text(
          "Thông báo",
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.done_all, color: ColorThemes.primaryAccent),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.grey),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("MỚI NHẤT"),

            _buildFoodNotification(
              imageUrl: 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?q=80&w=1000',
              title: "Món phở bò mới!",
              chefName: "Chef Tuấn",
              actionText: "vừa đăng một công thức Phở Đặc Biệt mới. Hãy xem ngay!",
              time: "2p",
              isNew: true,
            ),
            _buildFoodNotification(
              imageUrl: 'https://images.unsplash.com/photo-1585325701165-351af916e581?q=80&w=1000',
              title: "Bún chả Hà Nội!",
              chefName: "Chef Lan",
              actionText: "đã chia sẻ bí quyết nước chấm thần thánh. Đừng bỏ lỡ!",
              time: "15p",
              isNew: true,
            ),
            _buildFoodNotification(
              imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=1000',
              title: "Cơm tấm sườn bì!",
              chefName: "MasterChef Hùng",
              actionText: "vừa cập nhật công thức ướp sườn nướng mật ong.",
              time: "45p",
              isNew: true,
            ),

            const SizedBox(height: 20),

            _buildSectionHeader("TRƯỚC ĐÓ"),

            _buildFoodNotification(
              imageUrl: 'https://images.unsplash.com/photo-1626804475297-411dbe6312a7?q=80&w=1000',
              title: "Bánh mì chảo",
              chefName: "Bếp Nhà Mẹ",
              actionText: "đã đăng tải video hướng dẫn làm pate gan tại nhà.",
              time: "2h",
              isNew: false,
            ),
            _buildFoodNotification(
              imageUrl: 'https://images.unsplash.com/photo-1563379926898-05f4575a45d8?q=80&w=1000',
              title: "Mỳ Ý Carbonara",
              chefName: "Gordon R.",
              actionText: "giới thiệu cách làm sốt kem trứng chuẩn Ý.",
              time: "5h",
              isNew: false,
            ),
            _buildFoodNotification(
              imageUrl: 'https://images.unsplash.com/photo-1512058564366-18510be2db19?q=80&w=1000',
              title: "Salad nhiệt đới",
              chefName: "Healthy Food",
              actionText: "chia sẻ thực đơn giảm cân cho tuần mới.",
              time: "1d",
              isNew: false,
            ),
            _buildFoodNotification(
              imageUrl: 'https://images.unsplash.com/photo-1551024709-8f23befc6f87?q=80&w=1000',
              title: "Cocktail Mùa Hè",
              chefName: "Barista Huy",
              actionText: "vừa thêm công thức pha chế Mojito giải nhiệt.",
              time: "2d",
              isNew: false,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildFoodNotification({
    required String imageUrl,
    required String title,
    required String chefName,
    required String actionText,
    required String time,
    required bool isNew,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isNew ? Color(0xFF0E271A) : Colors.transparent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 55,
                width: 55,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    errorWidget: (context, url, error) => Center(child: Icon(Icons.error, color: Colors.white,)),
                    placeholder: (context, url){
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                    height: 250,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF4ADE80),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.restaurant_menu, size: 12, color: Colors.black),
                ),
              )
            ],
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: isNew ? const Color(0xFF4ADE80) : Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13, height: 1.4),
                    children: [
                      TextSpan(
                        text: chefName,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const TextSpan(text: " "),
                      TextSpan(text: actionText),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (isNew)
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF4ADE80),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}