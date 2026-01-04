import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';
import 'package:recipe_finder_app/features/auth/data/models/user_model.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_watcher/auth_watcher_bloc.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_watcher/auth_watcher_event.dart';
import 'package:recipe_finder_app/features/auth/presentation/pages/about_us_page.dart';
import 'package:recipe_finder_app/features/auth/presentation/pages/change_password_page.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/repositories/auth_repository_impl.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.currentUser, required this.authRepo});
  final UserModel currentUser;
  final AuthRepositoryImpl authRepo;

  @override
  Widget build(BuildContext context) {
    final Color iconBgColor = const Color(0xFF1F352A);
    final Color dangerColor = const Color(0xFF2C1B1B);
    final Color dangerText = const Color(0xFFEB5757);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        ),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.grey.shade300,
                          child: CachedNetworkImage(
                            imageUrl: currentUser.avatarUrl ?? '',
                            placeholder: (context, url){
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: double.infinity,
                                  height: 250,
                                  color: Colors.white,
                                ),
                              );
                            },
                            errorWidget: (context, url, error) => Center(child: SvgPicture.asset('lib/core/images/avatar-people.svg', height: 50,)),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0, right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: ColorThemes.primaryAccent,
                            shape: BoxShape.circle,
                            border: Border.all(color: ColorThemes.backgroundColor, width: 2),
                          ),
                          child: const Icon(Icons.edit, color: Colors.black, size: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    currentUser.name,
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    currentUser.email,
                    style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            _buildSectionTitle("SETUP & SECURITY"),
            Container(
              decoration: BoxDecoration(
                color: ColorThemes.cardBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildListTile(
                      context: context,
                      icon: Icons.language,
                      title: "Languages",
                      iconColor: ColorThemes.primaryAccent,
                      iconBg: iconBgColor,
                      showDivider: true,
                      trailingText: "English",
                      onTap: (){}
                  ),
                  _buildListTile(
                      context: context,
                      icon: Icons.lock,
                      title: "Change Password",
                      iconColor: ColorThemes.primaryAccent,
                      iconBg: iconBgColor,
                      showDivider: false,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordPage(authRepo: authRepo, typeRequest: 1,)))
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            _buildSectionTitle("ABOUT & SUPPORT"),
            Container(
              decoration: BoxDecoration(
                color: ColorThemes.cardBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildListTile(
                      context: context,
                      icon: Icons.help_outline,
                      title: "Help Center",
                      iconColor: ColorThemes.primaryAccent,
                      iconBg: iconBgColor,
                      showDivider: true,
                      onTap: (){}
                  ),
                  _buildListTile(
                      context: context,
                      icon: Icons.info_outline,
                      title: "About Us",
                      iconColor: ColorThemes.primaryAccent,
                      iconBg: iconBgColor,
                      showDivider: false,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()))
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  authRepo.signOut();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: dangerColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                  splashFactory: NoSplash.splashFactory,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: dangerText, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "Đăng xuất",
                      style: TextStyle(color: dangerText, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color iconColor,
    required Color iconBg,
    required bool showDivider,
    String? trailingText,
    required VoidCallback onTap
  }) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            title: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (trailingText != null)
                  Text(
                    trailingText,
                    style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
                  ),
                if (trailingText != null) const SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(0.3), size: 14),
              ],
            ),
            onTap: () => onTap(),
          ),
        ),
        if (showDivider)
          Divider(color: Colors.white.withOpacity(0.05), height: 1, indent: 60, endIndent: 20),
      ],
    );
  }
}