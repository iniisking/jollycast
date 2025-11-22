import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jollycast/view/widgets/button.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/text.dart';
import 'package:jollycast/view/screens/authentication/all_set_screen.dart';
import '../../../gen/assets.gen.dart';

class SelectAvatarScreen extends StatefulWidget {
  const SelectAvatarScreen({super.key});

  @override
  State<SelectAvatarScreen> createState() => _SelectAvatarScreenState();
}

class _SelectAvatarScreenState extends State<SelectAvatarScreen> {
  int? _selectedAvatarIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Assets.images.accountSetUpBackground.image(
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.centerRight,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Row(children: [Assets.svg.headphones.svg()]),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19.spMin),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomTextWidget(
                            text: 'Select an avatar to represent\nyour funk',
                            fontSize: 26.spMin,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.spMin),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19.spMin),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildAvatar(0, Assets.svg.avatar1.svg()),
                          ),
                          SizedBox(width: 15.spMin),
                          Expanded(
                            child: _buildAvatar(1, Assets.svg.avatar2.svg()),
                          ),
                          SizedBox(width: 15.spMin),
                          Expanded(
                            child: _buildAvatar(2, Assets.svg.avatar3.svg()),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.spMin),
                      Row(
                        children: [
                          Expanded(
                            child: _buildAvatar(3, Assets.svg.avatar4.svg()),
                          ),
                          SizedBox(width: 15.spMin),
                          Expanded(
                            child: _buildAvatar(4, Assets.svg.avatar5.svg()),
                          ),
                          SizedBox(width: 15.spMin),
                          Expanded(
                            child: _buildAvatar(5, Assets.svg.avatar6.svg()),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.spMin),
                      Row(
                        children: [
                          Expanded(
                            child: _buildAvatar(6, Assets.svg.avatar7.svg()),
                          ),
                          SizedBox(width: 15.spMin),
                          Expanded(
                            child: _buildAvatar(7, Assets.svg.avatar8.svg()),
                          ),
                          SizedBox(width: 15.spMin),
                          Expanded(
                            child: _buildAvatar(8, Assets.svg.avatar9.svg()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19.spMin),
                  child: CustomButton(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllSetScreen(),
                        ),
                      );
                    },
                    text: CustomTextWidget(
                      text: 'Continue',
                      fontSize: 20,
                      color: whiteColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(int index, Widget avatar) {
    final isSelected = _selectedAvatarIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAvatarIndex = isSelected ? null : index;
        });
      },
      child: AnimatedScale(
        scale: isSelected ? 1.15 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Avatar with increased size
            Transform.scale(scale: 1.0, child: avatar),
            // Circular ring indicator for selected state
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: isSelected ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: whiteColor, width: 4.spMin),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: whiteColor.withOpacity(0.5),
                              blurRadius: 20.spMin,
                              spreadRadius: 4.spMin,
                            ),
                          ]
                        : [],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
