import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:meme_generator/bloc/theme_bloc/theme_bloc.dart';
import 'package:meme_generator/models/downloads.dart';
import 'package:meme_generator/models/favourites.dart';
import 'package:meme_generator/screens/home.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['memes', 'jokes', 'funny', 'comedy', 'generator'],
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: BannerAd.testAdUnitId,
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

InterstitialAd myInterstitial = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: InterstitialAd.testAdUnitId,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(FavouritesAdapter());
  Hive.registerAdapter(DownloadsAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: AppWithTheme(),
    );
  }
}

class AppWithTheme extends StatefulWidget {
  @override
  _AppWithThemeState createState() => _AppWithThemeState();
}

class _AppWithThemeState extends State<AppWithTheme> {
  String currentTheme = 'light';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ThemeBloc>(context).add(GetThemeEvent());
    FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-6840685082264318~5942622167');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThemeBloc, ThemeState>(
      listener: (context, state) {
        if (state is ChangeThemeLoaded) {
          setState(() {
            currentTheme = state.themeMode;
          });
        } else if (state is GetThemeLoaded) {
          setState(() {
            currentTheme = state.themeMode;
          });
        }
      },
      child: MaterialApp(
        title: 'Meme Generator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white,
        ),
        themeMode: currentTheme == 'dark' ? ThemeMode.dark : ThemeMode.light,
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.teal,
          textTheme: TextTheme(
            button: TextStyle(fontFamily: 'Poppins'),
            bodyText2: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
        home: Home(),
      ),
    );
  }
}
