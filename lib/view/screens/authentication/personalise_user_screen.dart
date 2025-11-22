import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jollycast/view/widgets/button.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/text.dart';
import 'package:jollycast/view/widgets/interest_tag.dart';
import 'package:jollycast/view/screens/authentication/select_avatar_screen.dart';
import '../../../gen/assets.gen.dart';

class PersonaliseUserScreen extends StatefulWidget {
  const PersonaliseUserScreen({super.key});

  @override
  State<PersonaliseUserScreen> createState() => _PersonaliseUserScreenState();
}

class _PersonaliseUserScreenState extends State<PersonaliseUserScreen> {
  final Set<String> _selectedInterests = {};

  final List<String> _interests = [
    'Business & Career',
    'Movies & Cinema',
    'Tech events',
    'Mountain climbing',
    'Educational',
    'Religious & Spiritual',
    'Sip & Paint',
    'Fitness',
    'Sports',
    'Kayaking',
    'Clubs & Party',
    'Games',
    'Concerts',
    'Art & Culture',
    'Karaoke',
    'Adventure',
    'Health & Lifestyle',
    'Food & Drinks',
  ];

  // Layout configuration: number of items per row
  final List<int> _rowLayout = [2, 2, 2, 3, 3, 2, 2, 2];

  void _toggleInterest(String interest) {
    setState(() {
      if (_selectedInterests.contains(interest)) {
        _selectedInterests.remove(interest);
      } else {
        _selectedInterests.add(interest);
      }
    });
  }

  List<Widget> _buildInterestRows() {
    final List<Widget> rows = [];
    int currentIndex = 0;

    for (int itemsInRow in _rowLayout) {
      if (currentIndex >= _interests.length) break;

      final List<Widget> rowChildren = [];
      for (int i = 0; i < itemsInRow && currentIndex < _interests.length; i++) {
        final interest = _interests[currentIndex];
        rowChildren.add(
          InterestTag(
            text: interest,
            isSelected: _selectedInterests.contains(interest),
            onTap: () => _toggleInterest(interest),
          ),
        );
        if (i < itemsInRow - 1 && currentIndex < _interests.length - 1) {
          rowChildren.add(SizedBox(width: 6.spMin));
        }
        currentIndex++;
      }

      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowChildren,
        ),
      );
      if (currentIndex < _interests.length) {
        rows.add(SizedBox(height: 12.spMin));
      }
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Assets.images.accountSetUpBackground.image(
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Row(children: [Assets.svg.headphones.svg()]),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.spMin),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomTextWidget(
                            text: 'Welcome, Devon',
                            fontSize: 28.spMin,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.spMin),
                      Row(
                        children: [
                          CustomTextWidget(
                            text:
                                'Personalize your Jolly experience\nby selecting your top interest and favorite topics.',
                            fontSize: 18.spMin,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      SizedBox(height: 26.spMin),
                      ..._buildInterestRows(),
                      SizedBox(height: 40.spMin),
                      CustomButton(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SelectAvatarScreen(),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
