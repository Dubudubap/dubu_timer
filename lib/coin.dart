import 'package:dubu_timer/hive_model.dart';
import 'package:flutter/material.dart';
import 'package:dubu_timer/provider/global_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class coin extends StatefulWidget {
  const coin({Key? key}) : super(key: key);

  @override
  _coinState createState() => _coinState();
}

class _coinState extends State<coin> {
  int maxAttempts = 3;

  RewardedAd? rewardedAd;
  int rewardedAdAttempts = 0;

  static const AdRequest request = AdRequest();

  void createRewardedAd() {
    RewardedAd.load(
      adUnitId: RewardedAd.testAdUnitId,
      request: request,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
          rewardedAdAttempts = 0;
        },
        onAdFailedToLoad: (error) {
          rewardedAdAttempts++;
          rewardedAd = null;
          print('failed to load ${error.message}');

          if (rewardedAdAttempts <= maxAttempts) {
            createRewardedAd();
          }
        },
      ),
    );
  }

  void showRewardedAd() {
    if (rewardedAd == null) {
      print('trying to show before loading');
      return;
    }

    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) => print('ad showed $ad'),
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        print('failed to show the ad $ad');

        createRewardedAd();
      },
    );

    rewardedAd!.show(onUserEarnedReward: (ad, reward) {
      print('reward video ${reward.amount} ${reward.type}');
      context.read<Counts>().add((reward.amount.toDouble()));
    });

    rewardedAd = null;
  }

  List Items = [];
  var closet;
  late DynamicList listClass;

  @override
  void initState() {
    super.initState();
    closet = Provider.of<ListProvider>(context, listen: false);
    listClass = DynamicList(closet.items);
    createRewardedAd();
  }

  Future<void> SaveModelValue() async {
    final box = await Hive.box<HiveModel>('hiveModel');
    int id = 1;
    if (box.isNotEmpty) {
      final Item = box.getAt(0);
    }
    Items = closet.GetItems();
    box.put(
      id,
      HiveModel(
        coins: context.read<Counts>().count.floor(),
        totalTime: context.read<Times>().totalTime,
        itemList: Items,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<HiveModel>('hiveModel').listenable(),
        builder: (context, Box<HiveModel> box, child) {
          final item = box.getAt(0);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 20,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/coin.png',
                      height: 20,
                      width: 20,
                    ),
                    Text(
                      '  ' + item!.coins.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'ShortStack',
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        showRewardedAd();
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        side: MaterialStateProperty.all(
                            BorderSide(color: Colors.black87, width: 3)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                      ),
                      child: SizedBox(
                        width: 250,
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/tv.png',
                                height: 20,
                                width: 20,
                              ),
                              Text('  Get 100 coins',
                                  style: TextStyle(
                                    fontFamily: 'ShortStack',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  )),
                            ]),
                      )),
                  OutlinedButton(
                      onPressed: () {
                        context.read<Counts>().add(10000);
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        side: MaterialStateProperty.all(
                            BorderSide(color: Colors.black87, width: 3)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                      ),
                      child: SizedBox(
                        width: 250,
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/tv.png',
                                height: 20,
                                width: 20,
                              ),
                              Text('  Get 10000 coins',
                                  style: TextStyle(
                                    fontFamily: 'ShortStack',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  )),
                            ]),
                      )),
                ],
              ),
            ]),
          );
        });
  }
}
