import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Üst Navigasyon
            _buildTopNavigation(context),

            // Profil Bölümü
            _buildProfileSection(),

            // Kullanıcı Adı Bölümü
            _buildUsernameSection(),

            // Menü Öğeleri
            Expanded(child: _buildMenuItems()),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavigation(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        // Profil Resmi ve Mavi Daireler
        Stack(
          alignment: Alignment.center,
          children: [
            // En dıştaki mavi daire
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withValues(alpha: 0.3),
              ),
            ),

            // Orta mavi daire
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withValues(alpha: 0.5),
              ),
            ),

            // İç mavi daire
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withValues(alpha: 0.7),
              ),
            ),

            // Profil resmi
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: Image.asset(AppImages.carImages[0], fit: BoxFit.cover),
              ),
            ),

            // Düzenleme ikonu
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.black, size: 18),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Free Butonu
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Free',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUsernameSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white24, width: 1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.person, color: Colors.white, size: 24),
          const SizedBox(width: 16),
          const Text(
            'ModShopMarcus',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              // Kullanıcı adı düzenleme
            },
            icon: const Icon(Icons.edit, color: Colors.white70, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    final menuItems = [
      {'icon': Icons.bug_report, 'title': 'Hata Bildir', 'onTap': () {}},
      {'icon': Icons.eco, 'title': 'Geri Bildirim Yap!', 'onTap': () {}},
      {'icon': Icons.gavel, 'title': 'Gizlilik Politikası', 'onTap': () {}},
      {'icon': Icons.description, 'title': 'Kullanım Şartları', 'onTap': () {}},
      {
        'icon': Icons.camera_alt,
        'title': 'Bizi Instagramda Takip Et',
        'onTap': () {},
      },
      {'icon': Icons.star, 'title': 'Bizi Oyla', 'onTap': () {}},
      {'icon': Icons.language, 'title': 'Dil Değiştir', 'onTap': () {}},
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) =>
          const Divider(color: Colors.white24, height: 1),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          leading: Icon(
            item['icon'] as IconData,
            color: Colors.white,
            size: 24,
          ),
          title: Text(
            item['title'] as String,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white70,
            size: 16,
          ),
          onTap: item['onTap'] as VoidCallback,
        );
      },
    );
  }
}
