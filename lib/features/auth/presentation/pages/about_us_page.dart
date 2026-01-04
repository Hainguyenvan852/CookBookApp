import 'package:flutter/material.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color textGrey = Colors.white.withOpacity(0.7);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Về chúng tôi",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: ColorThemes.primaryAccent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: ColorThemes.primaryAccent.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: const Icon(Icons.restaurant_menu, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 20),

            const Text(
              "CookBook",
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Text(
              "The leading recipe sharing platform \nfor the food-loving community.",
              textAlign: TextAlign.center,
              style: TextStyle(color: textGrey, fontSize: 13, height: 1.4),
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorThemes.cardBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("1. Introduction about Application"),
                  _buildParagraph(
                      "CookBook is a mobile app designed to connect people who are passionate about cooking. Our mission is to bring the joy of creating meals every day, making it easy for you to find, save, and share unique recipes from around the world.",
                      textGrey
                  ),
                  _buildParagraph(
                      "With its user-friendly and modern interface, CookBook is not just a recipe book, but also a vibrant community.",
                      textGrey
                  ),
                  const SizedBox(height: 10),

                  _buildSectionTitle("2. Key Features"),
                  _buildBulletPoint("Discover thousands of new recipes every day..", textGrey),
                  _buildBulletPoint("Save your favorite recipes to your personal collection.", textGrey),
                  _buildBulletPoint("Smart search by ingredients, cooking time, and dietary requirements.", textGrey),
                  _buildBulletPoint("Share your own recipes with the community.", textGrey),
                  _buildBulletPoint("Convenient hands-free cooking view.", textGrey),
                  const SizedBox(height: 10),

                  _buildSectionTitle("3. Privacy Policy"),
                  _buildParagraph(
                      "We are committed to protecting your privacy. Any personal information collected (such as name, email, and food preferences) is used solely to improve the user experience and personalize suggested content..",
                      textGrey
                  ),
                  _buildParagraph(
                      "Your data is encrypted and stored securely. We do not share your information with third parties for commercial purposes.",
                      textGrey
                  ),
                  const SizedBox(height: 10),

                  _buildSectionTitle("4. Terms of Service"),
                  _buildParagraph(
                      "By using CookBook, you agree to abide by our community guidelines. We encourage respect and healthy sharing.",
                      textGrey
                  ),
                  const SizedBox(height: 10),

                  _buildSectionTitle("5. Contact & Support"),
                  _buildParagraph(
                      "If you have any questions, suggestions, or need technical support, please contact our team via email at support@cookbook.com.",
                      textGrey
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Text(
              "© 2024 CookBook Inc. All rights reserved.",
              style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 11),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Made with ", style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 11)),
                const Icon(Icons.favorite, color: Colors.red, size: 10),
                Text(" for food lovers.", style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 11)),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 13,
          height: 1.5,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildBulletPoint(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 5, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}