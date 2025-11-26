import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jollycast/gen/assets.gen.dart';
import 'package:jollycast/view/widgets/color.dart';
import 'package:jollycast/view/widgets/appbar.dart';
import 'package:jollycast/view/widgets/text.dart';
import 'package:jollycast/view/widgets/card.dart';
import 'package:jollycast/view/widgets/section_header.dart';
import 'package:jollycast/view/widgets/see_all_button.dart';
import 'package:jollycast/core/provider/episodes_controller.dart';
import 'package:jollycast/core/provider/audio_player_controller.dart';
import 'package:jollycast/utils/navigation_helper.dart';
import 'package:jollycast/utils/provider_helper.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:jollycast/core/model/episodes/get_trending_model.dart';
import 'package:jollycast/view/screens/player/player_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupAuthErrorHandler();
      _loadData();
    });
  }

  void _setupAuthErrorHandler() {
    if (!mounted) return;
    final episodesController = ProviderHelper.episodes(context);
    final authController = ProviderHelper.auth(context);
    episodesController.setAuthErrorHandler(() {
      authController.logout();
    });
  }

  void _loadData() {
    if (!mounted) return;
    try {
      final episodesController = ProviderHelper.episodes(context);
      final token = ProviderHelper.token(context);
      if (token == null) return;

      // Load all necessary data for discover screen
      episodesController.getTrendingEpisodes(
        page: 1,
        perPage: 10,
        token: token,
      );
      episodesController.getEditorsPick(token: token);
      episodesController.getTopJolly(page: 1, perPage: 10, token: token);
      episodesController.getLatestEpisodes(page: 1, perPage: 20, token: token);
      episodesController.getHandpicked(amount: 3, token: token);
    } catch (e) {
      // Provider not available yet, will retry on next frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _loadData();
      });
    }
  }

  Future<void> _onRefresh() async {
    final episodesController = ProviderHelper.episodes(context);
    final token = ProviderHelper.token(context);
    if (token == null) return;

    await Future.wait([
      episodesController.refreshTrendingEpisodes(token: token),
      episodesController.getEditorsPick(token: token),
      episodesController.refreshTopJolly(token: token),
      episodesController.refreshLatestEpisodes(token: token),
      episodesController.getHandpicked(amount: 3, token: token),
    ]);
  }

  Future<void> _openPlayerScreen(Episode episode) async {
    final episodesController = ProviderHelper.episodes(context);
    final audioController = ProviderHelper.audio(context);
    final token = ProviderHelper.token(context);
    if (token == null) return;

    NavigationHelper.showLoadingDialog(context);

    Episode? detailed;
    try {
      detailed = await episodesController.getEpisodeById(
        id: episode.id,
        token: token,
      );
    } finally {
      if (mounted) {
        NavigationHelper.hideLoadingDialog(context);
      }
    }

    if (!mounted) return;

    final episodeToPlay = detailed ?? episode;

    // Start playing the episode
    await audioController.playEpisode(episodeToPlay);

    Navigator.of(context).push(
      NavigationHelper.slideUpTransition(PlayerScreen(episode: episodeToPlay)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor3,
      appBar: const CustomAppBar(),
      body: Consumer<EpisodesController>(
        builder: (context, episodesController, child) {
          return LiquidPullToRefresh(
            onRefresh: _onRefresh,
            color: editorsPickGradientEnd,
            backgroundColor: editorsPickGradientStart,
            height: 100,
            showChildOpacityTransition: false,
            springAnimationDurationInMilliseconds: 300,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hot & trending episodes section
                  SectionHeader(
                    icon: Assets.images.fire.image(),
                    title: 'Hot & trending episodes',
                  ),
                  SizedBox(
                    height: 400.spMin,
                    child: episodesController.trendingEpisodes.isEmpty
                        ? _buildTrendingPlaceholders()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 24.spMin),
                            itemCount:
                                episodesController.trendingEpisodes.length,
                            itemBuilder: (context, index) {
                              final episode =
                                  episodesController.trendingEpisodes[index];
                              return Consumer<AudioPlayerController>(
                                builder: (context, audioController, child) {
                                  return GestureDetector(
                                    onTap: () => _openPlayerScreen(episode),
                                    child: TrendingCard(
                                      imagePath: episode.pictureUrl,
                                      podcastName: episode.podcast.title,
                                      episodeTitle: episode.title.length > 30
                                          ? '${episode.title.substring(0, 30)}...'
                                          : episode.title,
                                      description:
                                          episode.description.length > 100
                                          ? '${episode.description.substring(0, 100)}...'
                                          : episode.description,
                                      episodeId: episode.id,
                                      onPlay: () {
                                        if (audioController
                                                .currentEpisode
                                                ?.id ==
                                            episode.id) {
                                          audioController.togglePlayPause();
                                        } else {
                                          _openPlayerScreen(episode);
                                        }
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ),
                  SizedBox(height: 57.spMin),
                  // Editor's pick section
                  SectionHeader(
                    icon: Assets.svg.purpleStar.svg(),
                    title: "Editor's pick",
                    padding: EdgeInsets.only(left: 23.spMin, bottom: 16.spMin),
                    iconWidth: 27,
                    iconHeight: 27,
                    spacing: 5,
                  ),
                  SizedBox(height: 17.spMin),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.spMin),
                    child: episodesController.editorsPickEpisode == null
                        ? _buildEditorsPickPlaceholder()
                        : _buildEditorsPickCard(
                            episodesController.editorsPickEpisode!,
                          ),
                  ),
                  SizedBox(height: 60.spMin),
                  // Top jolly section
                  Padding(
                    padding: EdgeInsets.only(left: 21.spMin, right: 18.spMin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          text: 'Top jolly',
                          fontSize: 24,
                          color: whiteColor,
                          fontWeight: FontWeight.w800,
                        ),
                        SeeAllButton(),
                      ],
                    ),
                  ),
                  SizedBox(height: 23.spMin),
                  // Top jolly cards row
                  SizedBox(
                    height: 237.spMin,
                    child: episodesController.topJollyPodcasts.isEmpty
                        ? _buildTopJollyPlaceholders()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(left: 14.spMin),
                            itemCount:
                                episodesController.topJollyPodcasts.length,
                            itemBuilder: (context, index) {
                              final podcast =
                                  episodesController.topJollyPodcasts[index];
                              return _buildTopJollyCard(podcast);
                            },
                          ),
                  ),
                  SizedBox(height: 50.spMin),
                  // Newest episodes section
                  Padding(
                    padding: EdgeInsets.only(left: 21.spMin, right: 18.spMin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          text: 'Newest episodes',
                          fontSize: 24,
                          color: whiteColor,
                          fontWeight: FontWeight.w800,
                        ),
                        SeeAllButton(text: 'Shuffle play', width: 101),
                      ],
                    ),
                  ),
                  SizedBox(height: 17.spMin),
                  // Newest episodes horizontal scroll
                  SizedBox(
                    height: 510.spMin,
                    child: episodesController.latestEpisodes.isEmpty
                        ? _buildLatestEpisodesPlaceholder()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(left: 12.spMin),
                            itemCount:
                                (episodesController.latestEpisodes.length / 5)
                                    .ceil(),
                            itemBuilder: (context, index) {
                              final startIndex = index * 5;
                              final endIndex = (startIndex + 5).clamp(
                                0,
                                episodesController.latestEpisodes.length,
                              );
                              final episodes = episodesController.latestEpisodes
                                  .sublist(startIndex, endIndex);

                              return Padding(
                                padding: EdgeInsets.only(right: 22.spMin),
                                child: SizedBox(
                                  width: 300.spMin,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(episodes.length, (
                                      rowIndex,
                                    ) {
                                      final episode = episodes[rowIndex];
                                      final itemNumber =
                                          (startIndex + rowIndex + 1)
                                              .toString()
                                              .padLeft(2, '0');
                                      final dateFormat = DateFormat(
                                        'd MMM, yy',
                                      );
                                      final durationMinutes =
                                          (episode.duration / 60).round();

                                      return GestureDetector(
                                        onTap: () => _openPlayerScreen(episode),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            bottom:
                                                rowIndex < episodes.length - 1
                                                ? 21.spMin
                                                : 0,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Number text
                                              CustomTextWidget(
                                                text: itemNumber,
                                                fontSize: 15,
                                                color: greyTextColor,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              SizedBox(width: 6.spMin),
                                              // Image container with play button
                                              Container(
                                                width: 79.spMin,
                                                height: 79.79798126220703.spMin,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        5.spMin,
                                                      ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5.spMin,
                                                          ),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            episode.pictureUrl,
                                                        width: 79.spMin,
                                                        height:
                                                            79.79798126220703
                                                                .spMin,
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            (
                                                              context,
                                                              url,
                                                            ) => Container(
                                                              width: 79.spMin,
                                                              height:
                                                                  79.79798126220703
                                                                      .spMin,
                                                              color:
                                                                  darkGreyColor,
                                                            ),
                                                        errorWidget: (context, url, error) {
                                                          return Container(
                                                            width: 79.spMin,
                                                            height:
                                                                79.79798126220703
                                                                    .spMin,
                                                            color:
                                                                darkGreyColor,
                                                            child: Icon(
                                                              Icons
                                                                  .image_not_supported,
                                                              color:
                                                                  greyTextColor,
                                                              size: 20.spMin,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Consumer<AudioPlayerController>(
                                                        builder:
                                                            (
                                                              context,
                                                              audioController,
                                                              child,
                                                            ) {
                                                              final isPlaying =
                                                                  audioController
                                                                          .currentEpisode
                                                                          ?.id ==
                                                                      episode
                                                                          .id &&
                                                                  audioController
                                                                      .isPlaying;
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  if (audioController
                                                                          .currentEpisode
                                                                          ?.id ==
                                                                      episode
                                                                          .id) {
                                                                    audioController
                                                                        .togglePlayPause();
                                                                  } else {
                                                                    _openPlayerScreen(
                                                                      episode,
                                                                    );
                                                                  }
                                                                },
                                                                child: Container(
                                                                  width:
                                                                      35.54999923706055
                                                                          .spMin,
                                                                  height:
                                                                      35.90909194946289
                                                                          .spMin,
                                                                  decoration: BoxDecoration(
                                                                    color: primaryColor
                                                                        .withOpacity(
                                                                          0.7,
                                                                        ),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                      color:
                                                                          whiteColor,
                                                                      width: 2
                                                                          .spMin,
                                                                    ),
                                                                  ),
                                                                  child: Icon(
                                                                    isPlaying
                                                                        ? Icons
                                                                              .pause
                                                                        : Icons
                                                                              .play_arrow,
                                                                    color:
                                                                        whiteColor,
                                                                    size: 20
                                                                        .spMin,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 7.spMin),
                                              // Text column
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomTextWidget(
                                                      text:
                                                          episode.title.length >
                                                              30
                                                          ? '${episode.title.substring(0, 30)}...'
                                                          : episode.title,
                                                      fontSize: 15,
                                                      color: whiteColor,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                    SizedBox(height: 2.spMin),
                                                    CustomTextWidget(
                                                      text:
                                                          episode
                                                                  .description
                                                                  .length >
                                                              50
                                                          ? '${episode.description.substring(0, 50)}...'
                                                          : episode.description,
                                                      fontSize: 13,
                                                      color:
                                                          descriptionTextColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      maxLines: 2,
                                                    ),
                                                    SizedBox(height: 7.spMin),
                                                    CustomTextWidget(
                                                      text:
                                                          '${dateFormat.format(episode.publishedAt)} - $durationMinutes minutes',
                                                      fontSize: 13,
                                                      color: greyTextColor,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  SizedBox(height: 40.spMin),
                  // See all button
                  Center(child: SeeAllButton.large()),
                  SizedBox(height: 58.spMin),
                  // Mixed by interest & categories
                  Padding(
                    padding: EdgeInsets.only(left: 21.spMin),
                    child: CustomTextWidget(
                      text: 'Mixed by interest & categories',
                      fontSize: 24,
                      color: whiteColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 14.spMin),
                  // Mixed by interest & categories grid
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 19.spMin),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.spMin,
                        mainAxisSpacing: 15.spMin,
                        childAspectRatio: 190 / 221.5,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: topJollyCardColor,
                            borderRadius: BorderRadius.circular(12.spMin),
                            border: Border.all(
                              color: topJollyBorderColor,
                              width: 1.spMin,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 9.spMin,
                              right: 9.spMin,
                              top: 11.spMin,
                              bottom: 8.spMin,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image grid container
                                Container(
                                  width: 173.spMin,
                                  height: 158.2318115234375.spMin,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      3.spMin,
                                    ),
                                  ),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 0,
                                          mainAxisSpacing: 0,
                                          childAspectRatio:
                                              86.5 / 79.11585235595703,
                                        ),
                                    itemCount: 4,
                                    itemBuilder: (context, imgIndex) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          3.spMin,
                                        ),
                                        child: Assets.images.cardImage1.image(
                                          width: 86.5.spMin,
                                          height: 79.11585235595703.spMin,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 12.spMin),
                                // Category text
                                CustomTextWidget(
                                  text: '#Artandculture',
                                  fontSize: 16,
                                  color: whiteColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 40.spMin),
                  // Show all button
                  Center(child: SeeAllButton.large(text: 'Show all')),
                  SizedBox(height: 76.spMin),
                  // Handpicked for you section
                  Padding(
                    padding: EdgeInsets.only(left: 23.spMin),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Assets.images.fire.image(
                          width: 27.spMin,
                          height: 36.spMin,
                        ),
                        SizedBox(width: 6.spMin),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidget(
                              text: 'Handpicked for you',
                              fontSize: 24,
                              color: whiteColor,
                              fontWeight: FontWeight.w800,
                            ),
                            SizedBox(height: 3.spMin),
                            CustomTextWidget(
                              text: "Podcasts you'd love",
                              fontSize: 18,
                              color: greyTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 28.spMin),
                  // Handpicked containers list
                  episodesController.handpickedEpisodes.isEmpty
                      ? _buildHandpickedPlaceholder()
                      : Column(
                          children: List.generate(
                            episodesController.handpickedEpisodes.length,
                            (index) {
                              final episode =
                                  episodesController.handpickedEpisodes[index];
                              return GestureDetector(
                                onTap: () => _openPlayerScreen(episode),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.spMin,
                                  ),
                                  child: Container(
                                    width: 382.spMin,
                                    height: 500.spMin,
                                    margin: EdgeInsets.only(
                                      bottom:
                                          index <
                                              episodesController
                                                      .handpickedEpisodes
                                                      .length -
                                                  1
                                          ? 20.spMin
                                          : 0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: topJollyCardColor,
                                      borderRadius: BorderRadius.circular(
                                        12.spMin,
                                      ),
                                      border: Border.all(
                                        color: topJollyBorderColor,
                                        width: 1.spMin,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 57.spMin,
                                        right: 48.5.spMin,
                                        top: 37.spMin,
                                        bottom: 8.spMin,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Image container
                                          Container(
                                            width: 278.spMin,
                                            height: 237.spMin,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    8.spMin,
                                                  ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    8.spMin,
                                                  ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    episode.podcast.pictureUrl,
                                                width: 278.spMin,
                                                height: 237.spMin,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Container(
                                                      width: 278.spMin,
                                                      height: 237.spMin,
                                                      color: darkGreyColor,
                                                    ),
                                                errorWidget:
                                                    (context, url, error) {
                                                      return Container(
                                                        width: 278.spMin,
                                                        height: 237.spMin,
                                                        color: darkGreyColor,
                                                        child: Icon(
                                                          Icons
                                                              .image_not_supported,
                                                          color: greyTextColor,
                                                          size: 40.spMin,
                                                        ),
                                                      );
                                                    },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 11.spMin),
                                          // Title
                                          CustomTextWidget(
                                            text: episode.podcast.title,
                                            fontSize: 18,
                                            color: whiteColor,
                                            fontWeight: FontWeight.w800,
                                            textAlign: TextAlign.start,
                                          ),
                                          SizedBox(height: 0),
                                          // Author
                                          CustomTextWidget(
                                            text:
                                                'By: ${episode.podcast.author}',
                                            fontSize: 14,
                                            color: greyTextColor,
                                            fontWeight: FontWeight.w500,
                                            textAlign: TextAlign.start,
                                          ),
                                          SizedBox(height: 9.spMin),
                                          // Description
                                          CustomTextWidget(
                                            text:
                                                episode
                                                        .podcast
                                                        .description
                                                        .length >
                                                    150
                                                ? '${episode.podcast.description.substring(0, 150)}...'
                                                : episode.podcast.description,
                                            fontSize: 14,
                                            color: descriptionTextColor,
                                            fontWeight: FontWeight.w500,
                                            maxLines: 4,
                                            textAlign: TextAlign.start,
                                          ),
                                          SizedBox(height: 21.spMin),
                                          // Buttons row with episodes text
                                          Row(
                                            children: [
                                              // Follow button
                                              Container(
                                                width: 78.5.spMin,
                                                height: 30.spMin,
                                                decoration: BoxDecoration(
                                                  color: buttonGreyColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        18.spMin,
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                    6.spMin,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Assets.svg.add.svg(
                                                        width: 18.spMin,
                                                        height: 18.spMin,
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                              greyTextColor,
                                                              BlendMode.srcIn,
                                                            ),
                                                      ),
                                                      SizedBox(width: 4.spMin),
                                                      CustomTextWidget(
                                                        text: 'Follow',
                                                        fontSize: 13,
                                                        color: greyTextColor,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 13.spMin),
                                              // Play button
                                              Consumer<AudioPlayerController>(
                                                builder: (context, audioController, child) {
                                                  final isPlaying =
                                                      audioController
                                                              .currentEpisode
                                                              ?.id ==
                                                          episode.id &&
                                                      audioController.isPlaying;
                                                  return GestureDetector(
                                                    onTap: () {
                                                      if (audioController
                                                              .currentEpisode
                                                              ?.id ==
                                                          episode.id) {
                                                        audioController
                                                            .togglePlayPause();
                                                      } else {
                                                        _openPlayerScreen(
                                                          episode,
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      width: 78.5.spMin,
                                                      height: 30.spMin,
                                                      decoration: BoxDecoration(
                                                        color: playButtonGreen,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              18.spMin,
                                                            ),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                          6.spMin,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              isPlaying
                                                                  ? Icons
                                                                        .pause_rounded
                                                                  : Icons
                                                                        .play_arrow_rounded,
                                                              color: whiteColor,
                                                              size: 18.spMin,
                                                            ),
                                                            SizedBox(
                                                              width: 4.spMin,
                                                            ),
                                                            CustomTextWidget(
                                                              text: isPlaying
                                                                  ? 'Pause'
                                                                  : 'Play',
                                                              fontSize: 13,
                                                              color: whiteColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              SizedBox(width: 26.spMin),
                                              // Episodes count - placeholder since we don't have this data
                                              CustomTextWidget(
                                                text: 'Episodes',
                                                fontSize: 14,
                                                color: whiteColor,
                                                fontWeight: FontWeight.w600,
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  SizedBox(height: 88.spMin),
                  // Hashtag tags
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.spMin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row 1
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildHashtagTag('#relationship'),
                            _buildHashtagTag('#engagement'),
                          ],
                        ),
                        SizedBox(height: 26.spMin),
                        // Row 2
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildHashtagTag('#football'),
                            _buildHashtagTag('#football'),
                            _buildHashtagTag('#football'),
                          ],
                        ),
                        SizedBox(height: 26.spMin),
                        // Row 3
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildHashtagTag('#relationship'),
                            _buildHashtagTag('#engagement'),
                          ],
                        ),
                        SizedBox(height: 26.spMin),
                        // Row 4
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildHashtagTag('#relationship'),
                            _buildHashtagTag('#engagement'),
                          ],
                        ),
                        SizedBox(height: 26.spMin),
                        // Row 5
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildHashtagTag('#football'),
                            _buildHashtagTag('#football'),
                            _buildHashtagTag('#football'),
                          ],
                        ),
                        SizedBox(height: 26.spMin),
                        // Row 6
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildHashtagTag('#relationship'),
                            _buildHashtagTag('#engagement'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.spMin),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHashtagTag(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.spMin, vertical: 8.spMin),
      decoration: BoxDecoration(
        color: hashtagBackgroundColor,
        borderRadius: BorderRadius.circular(20.spMin),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1A000000),
            offset: Offset(0, 0),
            blurRadius: 20.spMin,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Text(
        tag,
        style: TextStyle(
          fontFamily: 'Euclid Circular A',
          fontWeight: FontWeight.w600,
          fontSize: 16.spMin,
          height: 1.0,
          letterSpacing: 0,
          color: whiteColor,
        ),
      ),
    );
  }

  Widget _buildTopJollyCard(dynamic podcast) {
    return Container(
      width: 185.spMin,
      height: 237.spMin,
      margin: EdgeInsets.only(right: 10.spMin),
      decoration: BoxDecoration(
        color: topJollyCardColor,
        borderRadius: BorderRadius.circular(12.spMin),
        border: Border.all(color: topJollyBorderColor, width: 1.spMin),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 7.spMin,
          top: 7.spMin,
          right: 7.spMin,
          bottom: 10.spMin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.spMin),
              child: CachedNetworkImage(
                imageUrl: podcast.pictureUrl,
                height: 133.spMin,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 133.spMin,
                  width: double.infinity,
                  color: darkGreyColor,
                ),
                errorWidget: (context, url, error) {
                  return Container(
                    height: 133.spMin,
                    width: double.infinity,
                    color: darkGreyColor,
                    child: Icon(
                      Icons.image_not_supported,
                      color: greyTextColor,
                      size: 30.spMin,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 7.spMin),
            // Title
            CustomTextWidget(
              text: podcast.title,
              fontSize: 16,
              color: whiteColor,
              fontWeight: FontWeight.w800,
            ),
            SizedBox(height: 0),
            // Author
            CustomTextWidget(
              text: podcast.author,
              fontSize: 13,
              color: greyTextColor,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 7.spMin),
            // Buttons row
            Row(
              children: [
                // Follow button
                Container(
                  width: 78.5.spMin,
                  height: 30.spMin,
                  decoration: BoxDecoration(
                    color: buttonGreyColor,
                    borderRadius: BorderRadius.circular(18.spMin),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6.spMin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.svg.add.svg(
                          width: 18.spMin,
                          height: 18.spMin,
                          colorFilter: ColorFilter.mode(
                            greyTextColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 4.spMin),
                        CustomTextWidget(
                          text: 'Follow',
                          fontSize: 13,
                          color: greyTextColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.spMin),
                // Share button
                Container(
                  width: 30.spMin,
                  height: 30.spMin,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: offWhiteColor, width: 1.spMin),
                  ),
                  child: Center(
                    child: Assets.svg.share.svg(
                      width: 12.spMin,
                      height: 12.spMin,
                      colorFilter: ColorFilter.mode(
                        whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditorsPickCard(Episode episode) {
    return GestureDetector(
      onTap: () => _openPlayerScreen(episode),
      child: Container(
        height: 206.spMin,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [editorsPickGradientStart, editorsPickGradientEnd],
            stops: const [0.4362, 0.9953],
          ),
          borderRadius: BorderRadius.circular(16.spMin),
        ),
        child: Row(
          children: [
            // Image with 7px padding all around
            Padding(
              padding: EdgeInsets.all(7.spMin),
              child: Container(
                width: 192.spMin,
                height: 192.spMin,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.spMin),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.spMin),
                      child: CachedNetworkImage(
                        imageUrl: episode.pictureUrl,
                        width: 192.spMin,
                        height: 192.spMin,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 192.spMin,
                          height: 192.spMin,
                          color: darkGreyColor,
                        ),
                        errorWidget: (context, url, error) {
                          return Container(
                            width: 192.spMin,
                            height: 192.spMin,
                            color: darkGreyColor,
                            child: Icon(
                              Icons.image_not_supported,
                              color: greyTextColor,
                              size: 40.spMin,
                            ),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: Consumer<AudioPlayerController>(
                        builder: (context, audioController, child) {
                          final isPlaying =
                              audioController.currentEpisode?.id ==
                                  episode.id &&
                              audioController.isPlaying;
                          return GestureDetector(
                            onTap: () {
                              if (audioController.currentEpisode?.id ==
                                  episode.id) {
                                audioController.togglePlayPause();
                              } else {
                                _openPlayerScreen(episode);
                              }
                            },
                            child: Container(
                              width: 48.spMin,
                              height: 48.spMin,
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.7),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: whiteColor,
                                  width: 2.spMin,
                                ),
                              ),
                              child: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: whiteColor,
                                size: 26.spMin,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Column on the right
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 14.spMin,
                  right: 7.spMin,
                  bottom: 12.spMin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    CustomTextWidget(
                      text: episode.title.length > 30
                          ? '${episode.title.substring(0, 30)}...'
                          : episode.title,
                      fontSize: 16,
                      color: whiteColor,
                      fontWeight: FontWeight.w800,
                    ),
                    SizedBox(height: 1.spMin),
                    // Author
                    CustomTextWidget(
                      text: 'By: ${episode.podcast.author}',
                      fontSize: 13,
                      color: greyTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 6.spMin),
                    // Description
                    CustomTextWidget(
                      text: episode.description.length > 120
                          ? '${episode.description.substring(0, 120)}...'
                          : episode.description,
                      fontSize: 13,
                      color: descriptionTextColor,
                      fontWeight: FontWeight.w500,
                      maxLines: 5,
                    ),
                    SizedBox(height: 11.spMin),
                    // Row with buttons
                    Row(
                      children: [
                        // First button
                        Container(
                          width: 78.5.spMin,
                          height: 30.spMin,
                          decoration: BoxDecoration(
                            color: buttonGreyColor,
                            borderRadius: BorderRadius.circular(18.spMin),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.spMin),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Assets.svg.add.svg(
                                  width: 18.spMin,
                                  height: 18.spMin,
                                  colorFilter: ColorFilter.mode(
                                    greyTextColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 4.spMin),
                                CustomTextWidget(
                                  text: 'Follow',
                                  fontSize: 13,
                                  color: greyTextColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.spMin),
                        // Second button - Share button
                        Container(
                          width: 30.spMin,
                          height: 30.spMin,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: offWhiteColor,
                              width: 1.spMin,
                            ),
                          ),
                          child: Center(
                            child: Assets.svg.share.svg(
                              width: 12.spMin,
                              height: 12.spMin,
                              colorFilter: ColorFilter.mode(
                                whiteColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildTrendingPlaceholders() {
    return Shimmer.fromColors(
      baseColor: darkGreyColor,
      highlightColor: darkGreyColor2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24.spMin),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 283.spMin,
            height: 351.spMin,
            margin: EdgeInsets.only(right: 16.spMin),
            decoration: BoxDecoration(
              color: darkGreyColor3,
              borderRadius: BorderRadius.circular(12.spMin),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditorsPickPlaceholder() {
    return Shimmer.fromColors(
      baseColor: darkGreyColor,
      highlightColor: darkGreyColor2,
      child: Container(
        height: 206.spMin,
        decoration: BoxDecoration(
          color: darkGreyColor3,
          borderRadius: BorderRadius.circular(16.spMin),
        ),
      ),
    );
  }

  Widget _buildTopJollyPlaceholders() {
    return Shimmer.fromColors(
      baseColor: darkGreyColor,
      highlightColor: darkGreyColor2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 14.spMin),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 185.spMin,
            height: 237.spMin,
            margin: EdgeInsets.only(right: 10.spMin),
            decoration: BoxDecoration(
              color: darkGreyColor3,
              borderRadius: BorderRadius.circular(12.spMin),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLatestEpisodesPlaceholder() {
    return Shimmer.fromColors(
      baseColor: darkGreyColor,
      highlightColor: darkGreyColor2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 12.spMin),
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 22.spMin),
            child: SizedBox(
              width: 300.spMin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(5, (rowIndex) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: rowIndex < 4 ? 21.spMin : 0,
                    ),
                    child: Container(
                      height: 80.spMin,
                      decoration: BoxDecoration(
                        color: darkGreyColor3,
                        borderRadius: BorderRadius.circular(8.spMin),
                      ),
                    ),
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHandpickedPlaceholder() {
    return Shimmer.fromColors(
      baseColor: darkGreyColor,
      highlightColor: darkGreyColor2,
      child: Column(
        children: List.generate(3, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.spMin),
            child: Container(
              width: 382.spMin,
              height: 500.spMin,
              margin: EdgeInsets.only(bottom: index < 2 ? 20.spMin : 0),
              decoration: BoxDecoration(
                color: darkGreyColor3,
                borderRadius: BorderRadius.circular(12.spMin),
              ),
            ),
          );
        }),
      ),
    );
  }
}
