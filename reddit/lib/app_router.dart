import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reddit/business_logic/cubit/cubit/search/cubit/search_comments_cubit.dart';
import 'package:reddit/business_logic/cubit/cubit/search/cubit/search_communities_cubit.dart';
import 'package:reddit/business_logic/cubit/comments/comments_cubit.dart';
import 'package:reddit/business_logic/cubit/cubit/change_password_cubit.dart';
import 'package:reddit/business_logic/cubit/cubit/delete_account_cubit.dart';
import 'package:reddit/business_logic/cubit/messages/messages_cubit.dart';
import 'package:reddit/business_logic/cubit/modtools/modtools_cubit.dart';
import 'package:reddit/business_logic/cubit/posts/posts_home_cubit.dart';
import 'package:reddit/business_logic/cubit/posts/posts_my_profile_cubit.dart';
import 'package:reddit/business_logic/cubit/posts/posts_popular_cubit.dart';
import 'package:reddit/business_logic/cubit/posts/posts_subreddit_cubit.dart';
import 'package:reddit/business_logic/cubit/posts/posts_user_cubit.dart';
import 'package:reddit/business_logic/cubit/posts/sort_cubit.dart';
import 'package:reddit/data/model/comments/comment_model.dart';
import 'package:reddit/business_logic/cubit/user_profile/follow_unfollow_cubit.dart';
import 'package:reddit/data/repository/comments/comments_repository.dart';
import 'package:reddit/data/web_services/comments/comments_web_services.dart';
import 'package:reddit/data/repository/modtools/modtools_repository.dart';
import 'package:reddit/data/repository/posts/posts_repository.dart';
import 'package:reddit/data/web_services/modtools/modtools_webservices.dart';
import 'package:reddit/data/web_services/posts/posts_web_services.dart';
import 'package:reddit/business_logic/cubit/user_profile/user_profile_cubit.dart';
import 'package:reddit/data/repository/feed_setting_repository.dart';
import 'package:reddit/data/repository/messages/messages_repository.dart';
import 'package:reddit/data/repository/user_profile/user_profile_repository.dart';
import 'package:reddit/data/web_services/feed_setting_web_services.dart';
import 'package:reddit/data/web_services/messages/messages_web_services.dart';
import 'package:reddit/presentation/screens/forget_username_web.dart';
import 'package:reddit/data/web_services/user_profile/user_profile_webservices.dart';
import 'package:reddit/presentation/screens/messages/send_message_web.dart';
import 'package:reddit/presentation/screens/modtools/mobile/add_approved_user_screen.dart';
import 'package:reddit/presentation/screens/modtools/mobile/add_moderator.dart';
import 'package:reddit/presentation/screens/modtools/mobile/approved_users.dart';
import 'package:reddit/presentation/screens/modtools/mobile/ban_user.dart';
import 'package:reddit/presentation/screens/modtools/mobile/banned_users.dart';
import 'package:reddit/presentation/screens/modtools/mobile/mod_list_screen.dart';
import 'package:reddit/presentation/screens/modtools/mobile/moderators.dart';
import 'package:reddit/presentation/screens/modtools/mobile/mute_user_screen.dart';
import 'package:reddit/presentation/screens/modtools/mobile/muted_users_screen.dart';
import 'package:reddit/presentation/screens/modtools/web/approved_web.dart';
import 'package:reddit/presentation/screens/modtools/web/edited_web.dart';
import 'package:reddit/presentation/screens/modtools/web/modqueue_web.dart';
import 'package:reddit/presentation/screens/modtools/web/spam_web.dart';
import 'package:reddit/presentation/screens/modtools/web/traffic_stats.dart';
import 'package:reddit/presentation/screens/modtools/web/unmoderated.dart';
import 'package:reddit/presentation/screens/new_post/create_post_screen.dart';
// import 'package:reddit/presentation/screens/profile/other_user_orfile_screen.dart';
import 'package:reddit/presentation/screens/search/search_web.dart';
import 'business_logic/cubit/cubit/search/cubit/search_cubit.dart';
import 'business_logic/cubit/cubit/search/cubit/search_people_cubit.dart';
import 'business_logic/cubit/cubit/search/cubit/search_posts_cubit.dart';
import 'package:reddit/presentation/screens/post/post_page.dart';
import 'package:reddit/presentation/screens/post/post_page_web.dart';
import 'package:reddit/presentation/screens/profile/other_user_profile_screen.dart';
import 'business_logic/cubit/feed_settings_cubit.dart';
import 'business_logic/cubit/new_post/create_post_cubit.dart';
import 'business_logic/cubit/new_post/post_flair_cubit.dart';
import 'business_logic/cubit/new_post/post_subreddit_preview_cubit.dart';
import 'business_logic/cubit/new_post/post_to_cubit.dart';
import 'data/model/flair_model.dart';
import 'data/model/post_model.dart';
import 'data/model/subreddit_model.dart';
import 'data/repository/new_post_repository.dart';
import 'data/repository/search_repo.dart';
import 'data/web_services/create_post_web_services.dart';
import 'data/web_services/search_web_service.dart';
import 'business_logic/cubit/left_drawer/left_drawer_cubit.dart';
import 'data/repository/left_drawer/left_drawer_repository.dart';
import 'data/web_services/left_drawer/left_drawer_web_services.dart';
import 'presentation/screens/feed_setting.dart';
import 'package:reddit/presentation/screens/profile/others_profile_page_web.dart';
import 'package:reddit/presentation/screens/profile/profile_page_web.dart';
import 'package:reddit/presentation/screens/profile/profile_screen.dart';
import 'business_logic/cubit/cubit/auth/cubit/auth_cubit.dart';
import 'data/repository/auth_repo.dart';
import 'data/web_services/authorization/auth_web_service.dart';
import 'presentation/screens/new_post/post_flair_screen.dart';
import 'presentation/screens/new_post/post_subreddit_preview_screen.dart';
import 'presentation/screens/new_post/post_to_mobile.dart';
import 'presentation/screens/setting_tab_ui.dart';
import 'package:reddit/presentation/screens/recaptcha_screen.dart'
    if (dart.library.html) 'package:reddit/presentation/screens/recaptcha_screen_web.dart'
    as recaptcha_screen;
import 'package:reddit/data/repository/subreddit_page_repository.dart';
import 'package:reddit/data/web_services/subreddit_page_web_services.dart';
import 'package:reddit/presentation/screens/subreddit_screen.dart';
import 'package:reddit/business_logic/cubit/subreddit_page_cubit.dart';
import 'package:reddit/business_logic/cubit/history_page_cubit.dart';

import 'package:reddit/data/repository/history_page_repository.dart';

import 'package:reddit/data/web_services/history_page_web_services.dart';

import 'package:reddit/presentation/screens/history_screen.dart';

import 'package:reddit/business_logic/cubit/create_community_cubit.dart';
import 'package:reddit/data/repository/create_community_repository.dart';
import 'package:reddit/data/web_services/create_community_web_services.dart';
import 'presentation/screens/create_community_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/settings/safety_settings_cubit.dart';
import 'package:reddit/data/repository/safety_settings_repository.dart';
import 'package:reddit/data/web_services/safety_settings_web_services.dart';
import 'package:reddit/presentation/screens/home/home_page_mobile.dart';
import 'package:reddit/presentation/screens/home/home_page_web.dart';
import 'package:reddit/presentation/screens/popular/popular.dart';
import 'package:reddit/presentation/screens/popular/popular_web.dart';
import 'package:reddit/business_logic/cubit/settings/settings_cubit.dart';
import 'package:reddit/data/repository/settings_repository.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';
import 'package:reddit/presentation/screens/profile_settings_screen.dart';
import 'package:reddit/business_logic/cubit/email_settings_cubit.dart';
import 'package:reddit/data/repository/email_settings_repo.dart';
import 'package:reddit/data/web_services/email_settings_web_services.dart';
import 'package:reddit/business_logic/cubit/cubit/account_settings_cubit.dart';
import 'package:reddit/data/repository/account_settings_repository.dart';
import 'package:reddit/data/web_services/account_settings_web_services.dart';
import 'package:reddit/presentation/screens/account_settings/account_settings_screen_web.dart';
import 'package:reddit/presentation/screens/account_settings/account_settings_screen.dart';
import 'package:reddit/presentation/screens/account_settings/change_password_screen.dart';
import 'package:reddit/presentation/screens/account_settings/country_screen.dart';
import 'package:reddit/presentation/screens/account_settings/manage_blocked_accounts_screen.dart';
import 'package:reddit/presentation/screens/account_settings/manage_notifications_screen.dart';
import 'package:reddit/presentation/screens/account_settings/update_email_address_screen.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/presentation/screens/choose_gender_android.dart';
import 'package:reddit/presentation/screens/choose_profile_screen.dart';
import 'package:reddit/presentation/screens/forget_password_android.dart';
import 'package:reddit/presentation/screens/forget_password_web.dart';
import 'package:reddit/presentation/screens/forget_username_android.dart';
import 'package:reddit/presentation/screens/intesrests_android.dart';
import 'package:reddit/presentation/screens/login_page.dart';
import 'package:reddit/presentation/screens/login_screen.dart';
import 'package:reddit/presentation/screens/signup_page.dart';
import 'package:reddit/presentation/screens/signup_page2.dart';
import 'package:reddit/presentation/screens/signup_screen.dart';

class AppRouter {
  // platform
  bool get isMobile =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android;
  // declare repository and cubit objects

  late AccountSettingsRepository accountSettingsRepository;
  late AccountSettingsCubit accountSettingsCubit;
  late ChangePasswordCubit changePasswordCubit;
  late DeleteAccountCubit deleteAccountCubit;
  late SafetySettingsRepository safetySettingsRepository;
  late SafetySettingsCubit safetySettingsCubit;
  late SettingsRepository settingsRepository;
  late SettingsCubit settingsCubit;
  late EmailSettingsRepository emailSettingsReposity;
  late EmailSettingsCubit emailSettingsCubit;
  late EmailSettingsWebServices emailSettingsWebServices;
  late AuthRepo authRepo;
  late SubredditPageCubit subredditPageCubit;
  late SubredditPageRepository subredditPageRepository;
  late SubredditWebServices subredditWebServices;
  late HistoryPageCubit historyPageCubit;
  late HistoryPageRepository historyPageRepository;
  late HistoryPageWebServices historyPageWebServices;
  late AuthCubit authCubit;
  late CreateCommunityRepository communityRepository;
  late CreateCommunityCubit createCommunityCubit;
  late CreateCommunityWebServices communityWebServices;
  late UserProfileWebServices userProfileWebServices;
  late UserProfileRepository userProfileRepository;
  late UserProfileCubit userProfileCubit;

  late SearchCubit searchCubit;
  late SearchPostsCubit searchPostsCubit;
  late SearchCommentsCubit searchCommentsCubit;
  late SearchCommunitiesCubit searchCommunitiesCubit;
  late SearchPeopleCubit searchUsersCubit;

  late MessagesWebServices messagesWebServices;
  late MessagesRepository messagesRepository;
  late MessagesCubit messagesCubitApproved;
  late MessagesCubit messagesCubitProfile;

  late ModToolsWebServices modtoolsWebServices;
  late ModToolsRepository modtoolsRepository;
  late ModtoolsCubit modtoolsCubit;
  late FollowUnfollowCubit followUnfollowCubit;

  late PostsWebServices postsWebServices;
  late PostsRepository postsRepository;
  late PostsHomeCubit postsHomeCubit;
  late PostsPopularCubit postsPopularCubit;
  late PostsMyProfileCubit postsMyProfileCubit;
  late PostsUserCubit postsUserCubit;
  late PostsSubredditCubit postsSubredditCubit;
  late CommentsRepository commentsRepository;
  late CommentsCubit commentsCubit;
  late SortCubit homeSortCubit;
  late SortCubit popularSortCubit;
  late SortCubit myProfileSortCubit;
  late SortCubit otherProfileSortCubit;
  late CreatePostRepository postRepository;
  late CreatePostCubit createPostCubit;
  late PostToCubit postToCubit;
  late PostSubredditPreviewCubit postSubredditPreviewCubit;
  late PostFlairCubit postFlairCubit;
  late CreatePostWebServices postWebServices;

  late SortCubit subredditSortCubit;
  AppRouter() {
    // initialise repository and cubit objects
    safetySettingsRepository =
        SafetySettingsRepository(SafetySettingsWebServices());
    safetySettingsCubit = SafetySettingsCubit(safetySettingsRepository);
    settingsRepository = SettingsRepository(SettingsWebServices());
    settingsCubit = SettingsCubit(settingsRepository);
    emailSettingsWebServices = EmailSettingsWebServices();
    emailSettingsReposity = EmailSettingsRepository(emailSettingsWebServices);
    emailSettingsCubit = EmailSettingsCubit(emailSettingsReposity);
    accountSettingsRepository =
        AccountSettingsRepository(AccountSettingsWebServices());
    accountSettingsCubit = AccountSettingsCubit(accountSettingsRepository);
    changePasswordCubit = ChangePasswordCubit(accountSettingsRepository);
    deleteAccountCubit = DeleteAccountCubit(accountSettingsRepository);
    authRepo = AuthRepo(AuthWebService());
    authCubit = AuthCubit(authRepo, settingsRepository);
    subredditWebServices = SubredditWebServices();
    subredditPageRepository = SubredditPageRepository(subredditWebServices);
    subredditPageCubit = SubredditPageCubit(subredditPageRepository);
    historyPageWebServices = HistoryPageWebServices();
    historyPageRepository = HistoryPageRepository(historyPageWebServices);
    historyPageCubit = HistoryPageCubit(historyPageRepository);
    communityWebServices = CreateCommunityWebServices();
    communityRepository = CreateCommunityRepository(communityWebServices);
    createCommunityCubit = CreateCommunityCubit(communityRepository);

    postsWebServices = PostsWebServices();
    postsRepository = PostsRepository(postsWebServices);
    postsHomeCubit = PostsHomeCubit(postsRepository);
    postsPopularCubit = PostsPopularCubit(postsRepository);
    postsMyProfileCubit = PostsMyProfileCubit(postsRepository);
    postsSubredditCubit = PostsSubredditCubit(postsRepository);
    postsUserCubit = PostsUserCubit(postsRepository);
    commentsRepository = CommentsRepository(CommentsWebServices());
    commentsCubit = CommentsCubit(commentsRepository);
    userProfileWebServices = UserProfileWebServices();
    userProfileRepository = UserProfileRepository(userProfileWebServices);
    userProfileCubit = UserProfileCubit(userProfileRepository);
    followUnfollowCubit = FollowUnfollowCubit(userProfileRepository);
    searchCubit = SearchCubit(SearchRepo(SearchWebService()));
    searchPostsCubit = SearchPostsCubit(SearchRepo(SearchWebService()));
    searchCommentsCubit = SearchCommentsCubit(SearchRepo(SearchWebService()));
    searchCommunitiesCubit =
        SearchCommunitiesCubit(SearchRepo(SearchWebService()));
    searchUsersCubit = SearchPeopleCubit(SearchRepo(SearchWebService()));

    messagesWebServices = MessagesWebServices();
    messagesRepository = MessagesRepository(messagesWebServices);
    messagesCubitApproved = MessagesCubit(messagesRepository);
    messagesCubitProfile = MessagesCubit(messagesRepository);

    modtoolsWebServices = ModToolsWebServices();
    modtoolsRepository = ModToolsRepository(modtoolsWebServices);
    modtoolsCubit = ModtoolsCubit(modtoolsRepository);
    homeSortCubit = SortCubit();
    otherProfileSortCubit = SortCubit();
    myProfileSortCubit = SortCubit();
    popularSortCubit = SortCubit();
    postWebServices = CreatePostWebServices();
    postRepository = CreatePostRepository(postWebServices);
    createPostCubit = CreatePostCubit(postRepository);
    postToCubit = PostToCubit(postRepository);
    postSubredditPreviewCubit = PostSubredditPreviewCubit(postRepository);
    postFlairCubit = PostFlairCubit(postRepository);
    subredditSortCubit = SortCubit();
  }
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case feedSettingRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => FeedSettingsCubit(FeedSettingRepository(
                feedSettingsWebServices: FeedSettingWebServices())),
            child: const FeedSetting(),
          ),
        );

      case homePageRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: ((context) => authCubit),
              ),
              BlocProvider.value(
                value: postsHomeCubit,
              ),
              BlocProvider.value(
                value: homeSortCubit,
              ),
            ],
            child: kIsWeb
                ? HomePageWeb()
                : MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => LeftDrawerCubit(
                            LeftDrawerRepository(LeftDrawerWebServices())),
                      ),
                      BlocProvider.value(
                        value: postsPopularCubit,
                      ),
                    ],
                    child: HomePage(),
                  ),
          ),
        );

      case popularPageRoute:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: postsPopularCubit,
                    ),
                    BlocProvider.value(
                      value: popularSortCubit,
                    ),
                    BlocProvider.value(
                      value: authCubit,
                    ),
                  ],
                  child: const PopularWeb(),
                  // child: kIsWeb ? const PopularWeb() : const Popular(),
                ));

      case profilePageRoute:
        return MaterialPageRoute(
            builder: (_) => kIsWeb
                ? MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => postsMyProfileCubit),
                      BlocProvider.value(value: settingsCubit),
                      BlocProvider.value(value: userProfileCubit),
                      BlocProvider.value(
                        value: myProfileSortCubit,
                      ),
                      BlocProvider.value(
                        value: myProfileSortCubit,
                      ),
                    ],
                    child: const ProfilePageWeb(),
                  )
                : MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: settingsCubit,
                      ),
                      BlocProvider(
                        create: (context) => postsMyProfileCubit,
                      ),
                      BlocProvider.value(
                        value: myProfileSortCubit,
                      ),
                    ],
                    child: const ProfileScreen(),
                  ));

      case otherProfilePageRoute:
        final userID = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: userProfileCubit),
              BlocProvider.value(value: settingsCubit),
              BlocProvider.value(value: messagesCubitProfile),
              BlocProvider.value(value: postsUserCubit),
              BlocProvider.value(value: followUnfollowCubit),
              BlocProvider.value(value: otherProfileSortCubit),
            ],
            child: kIsWeb
                ? OtherProfilePageWeb(userID: userID)
                : OtherProfileScreen(userID: userID),
          ),
        );

      case subredditPageScreenRoute:
        String subredditId =
            (arguments as Map<String, dynamic>)['sId'] as String;
        SubredditModel? subredditModel =
            (arguments)['subreddit'] as SubredditModel?;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) =>
                            SubredditPageCubit(subredditPageRepository),
                      ),
                      BlocProvider(
                        create: (context) => authCubit,
                      ),
                      BlocProvider.value(value: subredditSortCubit),
                      BlocProvider.value(value: postsSubredditCubit),
                    ],
                    child: SubredditPageScreen(
                      subredditId: subredditId,
                      subredditModel: subredditModel,
                    )));
      //---------------------------------------------------------------------------
      //------------------------------MOD LIST-------------------------------------
      //---------------------------------------------------------------------------
      case modlistRoute:
        final subreddit = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: modtoolsCubit,
                child: ModListScreen(
                    subredditName: subreddit['name']!,
                    subredditId: subreddit['id']!)));

      case modqueueRoute:
        final subreddit = settings.arguments as Map<String, String?>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: modtoolsCubit,
                child: ModQueueWeb(
                    subredditName: subreddit['name']!,
                    subredditId: subreddit['id']!)));

      case spamRoute:
        final subreddit = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: modtoolsCubit,
                child: kIsWeb
                    ? SpamWeb(
                        subredditName: subreddit['name']!,
                        subredditId: subreddit['id']!)
                    : null));
      case unmoderatedRoute:
        final subreddit = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: modtoolsCubit,
                child: kIsWeb
                    ? UnmoderatedWeb(
                        subredditName: subreddit['name']!,
                        subredditId: subreddit['id']!)
                    : null));

      case addApprovedRoute:
        final subreddit = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: modtoolsCubit,
                child: AddApprovedUserScreen(subredditId: subreddit['id']!)));
      case addModeratorRoute:
        final subreddit = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: modtoolsCubit,
            child: AddModeratorScreen(subredditId: subreddit['id']!),
          ),
        );
      case addMutedUserRoute:
        final subreddit = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: modtoolsCubit,
            child: MuteUserScreen(subredditId: subreddit['id']!),
          ),
        );
      case addBannedUserRoute:
        final subreddit = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: modtoolsCubit,
            child: BanUserScreen(subredditId: subreddit['id']!),
          ),
        );

      case approvedRoute:
        final subreddit = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: modtoolsCubit),
                      BlocProvider.value(value: messagesCubitApproved),
                    ],
                    child: kIsWeb
                        ? ApprovedWeb(
                            subredditName: subreddit['name']!,
                            subredditId: subreddit['id']!)
                        : ApprovedUsersScreen(
                            subredditName: subreddit['name']!,
                            subredditId: subreddit['id']!)));
      case moderatorsRoute:
        final subreddit = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: modtoolsCubit),
                    ],
                    child: kIsWeb
                        ? ApprovedWeb(
                            subredditName: subreddit['name']!,
                            subredditId: subreddit['id']!)
                        : ModeratorsScreen(
                            subredditName: subreddit['name']!,
                            subredditId: subreddit['id']!)));
      case bannedUsersRoute:
        final subreddit = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: modtoolsCubit),
                    ],
                    child: kIsWeb
                        ? ApprovedWeb(
                            subredditName: subreddit['name']!,
                            subredditId: subreddit['id']!)
                        : BannedUsersScreen(
                            subredditName: subreddit['name']!,
                            subredditId: subreddit['id']!)));
      case mutedUsersRoute:
        final subreddit = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: modtoolsCubit),
                    ],
                    child: kIsWeb
                        ? ApprovedWeb(
                            subredditName: subreddit['name']!,
                            subredditId: subreddit['id']!)
                        : MutedUsersScreen(
                            subredditName: subreddit['name']!,
                            subredditId: subreddit['id']!)));
      case editedRoute:
        final subreddit = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: modtoolsCubit,
                child: kIsWeb
                    ? EditedWeb(
                        subredditName: subreddit['name']!,
                        subredditId: subreddit['id']!)
                    : null));

      case tafficRoute:
        final subreddit = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: modtoolsCubit,
                child: kIsWeb
                    ? TrafficStatsWeb(
                        subredditName: subreddit['name']!,
                        subredditId: subreddit['id']!)
                    : null));
      //---------------------------------------------------------------------------
      case historyPageScreenRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: historyPageCubit,
                  child: const HistoryPageScreen(),
                ));
      case createCommunityScreenRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: createCommunityCubit,
                  child: const CreateCommunityScreen(),
                ));

      case SIGNU_PAGE2:
        final userEmail = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: authCubit,
                child: SignupWeb2(
                  userEmail: userEmail,
                )));
      case forgetUsernameWeb:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const ForgetUsernameWeb(),
          ),
        );
      case forgetPasswordWeb:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const ForgetPasswordWeb(),
          ),
        );
      case SIGNU_PAGE1:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const SignupWeb(),
          ),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const LoginWeb(),
          ),
        );
      case signupScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const SignupMobile(),
          ),
        );
      case forgetPasswordAndroid:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const ForgetPasswordAndroid(),
          ),
        );
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const LoginMobile(),
          ),
        );
      case forgetUsernameAndroid:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const ForgetUsernameAndroid(),
          ),
        );
      case interesetesScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const InterestsAndroid(),
          ),
        );
      case chooseProfileImgScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const ChooseProfileImgAndroid(),
          ),
        );
      case chooseGenderScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const ChooseGenderAndroid(),
          ),
        );
      /*
      case example:
      case '/':
        return MaterialPageRoute(
          // create bloc at the the root of widget tree
          builder: (_) => BlocProvider(
            // we pass the cubit class to create
            create: (context) => CubitObject,
            // our child is the screen itself
            child: const Screen(),
          ),
        );
      */

      case recaptchaRoute:
        // return MaterialPageRoute(builder: (_) => const RecaptchaScreenWeb());
        return MaterialPageRoute(
            builder: (_) => const recaptcha_screen.RecaptchaScreen());

      case accountSettingsRoute:
        return MaterialPageRoute(
          builder: (_) => isMobile
              ? MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: accountSettingsCubit,
                    ),
                    BlocProvider.value(
                      value: deleteAccountCubit,
                    ),
                  ],
                  child: AccountSettingsScreen(arguments),
                )
              : MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => accountSettingsCubit,
                    ),
                    BlocProvider(
                      create: (context) => changePasswordCubit,
                    ),
                  ],
                  child: const AccountSettingsScreenWeb(),
                ),
        );
      case updateEmailAddressRoute:
        return MaterialPageRoute(
            builder: (_) => UpdateEmailAddressScreen(arguments));
      case settingsTabsRoute:
        return MaterialPageRoute(builder: (_) => SettingTabUi());

      case changePasswordRoute:
        return MaterialPageRoute(builder: (context) {
          Map<String, dynamic> argMap = arguments as Map<String, dynamic>;
          return BlocProvider.value(
            value: changePasswordCubit,
            child: ChangePasswordScreen(arguments),
          );
        });
      case postPageRoute:
        return MaterialPageRoute(builder: (context) {
          Map<String, dynamic> argMap = arguments as Map<String, dynamic>;
          return BlocProvider.value(
            value: commentsCubit,
            child: isMobile
                ? PostPage(arguments: arguments)
                : PostPageWeb(arguments: arguments),
          );
        });
      case manageNotificationsRoute:
        return MaterialPageRoute(
            builder: (_) => const ManageNotificationsScreen());
      case countryRoute:
        return MaterialPageRoute(builder: (_) => CountryScreen(arguments));
      case manageBlockedAccountsRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => safetySettingsCubit,
                  child: const ManageBlockedAccountsScreen(),
                ));

      // case safetySettingsRoute:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider(
      //             create: (BuildContext context) => safetySettingsCubit,
      //             child: const SafetySettingsWeb(),
      //           ));
      case profileSettingsRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: settingsCubit,
                  child: const ProfileSettingsScreen(),
                ));
      case searchRouteWeb:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) =>
                          SearchCubit(SearchRepo(SearchWebService())),
                    ),
                    BlocProvider(
                      create: (context) =>
                          SearchPostsCubit(SearchRepo(SearchWebService())),
                    ),
                    BlocProvider(
                      create: (context) =>
                          SearchCommentsCubit(SearchRepo(SearchWebService())),
                    ),
                    BlocProvider(
                      create: (context) =>
                          SearchPeopleCubit(SearchRepo(SearchWebService())),
                    ),
                    BlocProvider(
                      create: (context) => SearchCommunitiesCubit(
                          SearchRepo(SearchWebService())),
                    ),
                  ],
                  child: const SearchWeb(),
                ));
      case sendMessageRoute:
        String username = arguments as String;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => messagesCubitProfile,
                  child: SendMessageWeb(username: username),
                ));
      case createPostScreenRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => createPostCubit,
                  child: const CreatePostScreen(),
                ));

      case postToMobileScreenRoute:
        PostModel newPostModel = arguments as PostModel;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => postToCubit,
                  child: PostToScreen(postModel: newPostModel),
                ));

      case postSubredditPreviewScreenRoute:
        PostModel newPostModel =
            (arguments as Map<String, dynamic>)['post'] as PostModel;
        SubredditModel subredditModel =
            (arguments)['subreddit'] as SubredditModel;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => postSubredditPreviewCubit,
                  child: PostSubredditPreviewScreen(
                    postModel: newPostModel,
                    subredditModel: subredditModel,
                  ),
                ));

      case postFlairScreenRoute:
        List<FlairModel> flairList = arguments as List<FlairModel>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => postFlairCubit,
                  child: PostFlairScreen(
                    flairList: flairList,
                  ),
                ));

      default:
        return null;
    }
  }
}
