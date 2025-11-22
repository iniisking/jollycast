import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jollycast/view/widgets/button.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/text.dart';
import 'package:jollycast/view/widgets/textfield.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:jollycast/view/widgets/shimmer.dart';
import 'package:jollycast/view/screens/authentication/complete_account_screen.dart';
import '../../../gen/assets.gen.dart';

class VerifyPhoneScreen extends StatefulWidget {
  final String phoneNumber;

  const VerifyPhoneScreen({super.key, required this.phoneNumber});

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _hasError = false;
  final _codeController = TextEditingController();

  bool get _isCodeValid {
    final digitsOnly = _codeController.text.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.length == 6;
  }

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    _codeController.addListener(_onCodeChanged);
  }

  void _onCodeChanged() {
    setState(() {});
  }

  Future<void> _initializeVideo() async {
    try {
      _videoPlayerController = VideoPlayerController.asset(
        Assets.video.onboardingVideo,
      );
      await _videoPlayerController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: true,
        showControls: false,
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        errorBuilder: (context, errorMessage) {
          return const Center(
            child: Text('Video failed to load. Please restart the app.'),
          );
        },
      );

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint('Video initialization error: $e');
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background video/shimmer
          if (_hasError)
            const Center(
              child: Text('Video failed to load. Please restart the app.'),
            )
          else if (_chewieController != null &&
              _videoPlayerController != null &&
              _videoPlayerController!.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoPlayerController!.value.size.width,
                  height: _videoPlayerController!.value.size.height,
                  child: Chewie(controller: _chewieController!),
                ),
              ),
            )
          else
            const VideoLoadingShimmer(),
          // Content on top
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 22.spMin,
                        right: 22.spMin,
                        bottom: keyboardHeight > 0
                            ? keyboardHeight + 20.spMin
                            : 0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Assets.images.logoOnboarding1.image(
                                height: 77.spMin,
                                width: 172.spMin,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.spMin),
                          Row(
                            children: [
                              CustomTextWidget(
                                text:
                                    'Enter the 6 digit code sent to your\nphone number ${widget.phoneNumber}',
                                fontSize: 24.spMin,
                                color: whiteColor,
                                fontWeight: FontWeight.w700,
                                textAlign: TextAlign.start,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          SizedBox(height: 28.spMin),
                          AuthTextFormField(
                            hintText: 'Enter code',
                            controller: _codeController,
                            fontSize: 16,
                            hintTextColor: greyColor,
                            primaryBorderColor: authBorderColor,
                            errorBorderColor: errorColor,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                          ),
                          SizedBox(height: 20.spMin),
                          CustomButton(
                            enabled: _isCodeValid,
                            onTap: _isCodeValid
                                ? () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CompleteAccountScreen(
                                              phoneNumber: widget.phoneNumber,
                                            ),
                                      ),
                                    );
                                  }
                                : null,
                            text: CustomTextWidget(
                              text: 'Continue',
                              fontSize: 20,
                              color: whiteColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 83.spMin),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
