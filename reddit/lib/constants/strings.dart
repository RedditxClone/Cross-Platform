//---------------------------------------
// --------------Backend-----------------
//---------------------------------------
// Backend URL
const baseUrl =
    'https://swproject.demosfortest.com/api/'; //String.fromEnvironment('BASE_URL', defaultValue: '');
const imagesUrl =
    'https://static.swproject.demosfortest.com/'; //String.fromEnvironment('MEDIA_URL', defaultValue: '');
const mockUrl = 'https://a3a539c4-1746-44d4-8e06-d579a1d30d53.mock.pstmn.io/';
// Use mock server instead of our backend server
const useMockServerForAllWebServices = false;
//---------------------------------------
// -----------homepage routes-----------
//---------------------------------------
const homePageRoute = '/home';
const popularPageRoute = '/popular';
//---------------------------------------
// -----------Log in / Sign up-----------
//---------------------------------------
//---------------------------------------
//--------------User Profile-------------
//---------------------------------------
const profilePageRoute = '/profile';
const otherProfilePageRoute = '/OtherProfile';
//---------------------------------------
// ----------Settings routes-------------
//---------------------------------------
const settingsTabsRoute = "/tabs";
//---------------------------------------
// ------Account settings routes---------
//---------------------------------------
const accountSettingsRoute = "/account_settings";
const updateEmailAddressRoute = "/account_settings/update_email_address";
const changePasswordRoute = "/account_settings/change_password";
const manageNotificationsRoute = "/account_settings/manage_notifications";
const countryRoute = "/account_settings/country";
const manageBlockedAccountsRoute = "/account_settings/manage_blocked_accounts";
//---------------------------------------
// ------Profile settings routes---------
//---------------------------------------
const profileSettingsRoute = '/profileSettings';
//---------------------------------------
// ------Safety settings routes----------
//---------------------------------------
const safetySettingsRoute = '/safetySettings';
//---------------------------------------
// ------Email settings routes---------
//---------------------------------------
const emailSettingsWebScreenRoute = "/emailSettings";
//---------------------------------------
// -----Feed settings routes---------
//---------------------------------------
const feedSettingRoute = '/feed_settings';
//---------------------------------------
// -----------reCaptcha routes-----------
//---------------------------------------
const recaptchaRoute = "/recaptcha";
const SIGNU_PAGE1 = '/signup1';
const SIGNU_PAGE2 = '/signup2';
const loginPage = '/login';
const FACEBOOK_APP_ID = '3404099966577167';
const USER_AGGREMENT = 'https://www.redditinc.com/policies/user-agreement';
const PRIVACY_POLICY = 'https://www.redditinc.com/policies/privacy-policy';
const forgetPasswordWeb = '/forgetPassword';
const forgetUsernameWeb = '/forgetUsername';
const getHelpPage =
    'https://reddithelp.com/hc/en-us/sections/360008917491-Account-Security';
const signupScreen = '/signupScreen';
const loginScreen = '/loginScreen';
const forgetPasswordAndroid = '/forgetPasswordAndroid';
const forgetUsernameAndroid = '/forgetUsernameAndroid';
const interesetesScreen = '/interesetesScreen';
const chooseGenderScreen = '/chooseGenderScreen';
const chooseProfileImgScreen = '/chooseProfileImgScreen';
const gitHubClientID = '278e3e6f443383001225';
//---------------------------------------
// ------subreddit page route---------
//---------------------------------------
const subredditPageScreenRoute = "/subredditPageScreen";
const historyPageScreenRoute = '/HistoryPageScreen';
const createCommunityScreenRoute = '/CreateCommunityScreen';
//---------------------------------------
//-----------Mod tools Route-------------
//---------------------------------------
const modlistRoute = '/modlist';
const modqueueRoute = '/modqueue';
const spamRoute = '/spam';
const editedRoute = '/edited';
const approvedRoute = '/approved';
const addApprovedRoute = '/addApprovedRoute';
const communitySettingsRoute = '/communitysettings';
const tafficRoute = '/taffic';
const rulesRoute = '/rules';
const unmoderatedRoute = '/unmod';
const moderatorsRoute = '/mod';
//---------------------------------------
// ------------Message Route-------------
//---------------------------------------
const sendMessageRoute = '/message';
const inboxRoute = '/inbox';
const sentRoute = '/sent';
