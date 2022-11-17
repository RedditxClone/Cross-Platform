import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/feed_settings_cubit.dart';
import 'package:reddit/data/model/feed_setting_model.dart';

class FeedSetting extends StatefulWidget {
  const FeedSetting({super.key});
  @override
  State<StatefulWidget> createState() => _FeedSettingState();
}

class _FeedSettingState extends State<FeedSetting> {
  late FeedSettingModel feedsetting;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FeedSettingsCubit>(context).getFeedSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<FeedSettingsCubit, FeedSettingsState>(
        builder: (context, state) {
          if (state is FeedSettingsLoaded) {
            feedsetting = state.feedSettings;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Text(
                      "Feed settings",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .merge(const TextStyle(color: Colors.white)),
                    ),
                  ),
                  Text(
                    "CONTENT PREFERENCES",
                    style: Theme.of(context).textTheme.caption!.merge(
                        const TextStyle(
                            color: Color.fromARGB(255, 125, 124, 124))),
                  ),
                  const Divider(),
                  SwitchListTile(
                    inactiveTrackColor: const Color.fromARGB(255, 34, 33, 33),
                    title: const Text(
                      "Adult content",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text(
                      "Enable to view adult and NSFW (not safe for work) content in your feed and search results.",
                      style:
                          TextStyle(color: Color.fromARGB(255, 125, 124, 124)),
                    ),
                    isThreeLine: true,
                    value: feedsetting.adultContent,
                    onChanged: (value) {
                      feedsetting.adultContent = value;
                      BlocProvider.of<FeedSettingsCubit>(context)
                          .updateFeedSettings(feedsetting);
                    },
                  ),
                  SwitchListTile(
                    inactiveTrackColor: const Color.fromARGB(255, 34, 33, 33),
                    title: const Text(
                      "Autoplay media",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text(
                      "Play videos and gifs automatically when in the viewport.",
                      style:
                          TextStyle(color: Color.fromARGB(255, 125, 124, 124)),
                    ),
                    isThreeLine: true,
                    value: feedsetting.autoPlayMedia,
                    onChanged: (value) {
                      feedsetting.autoPlayMedia = value;
                      BlocProvider.of<FeedSettingsCubit>(context)
                          .updateFeedSettings(feedsetting);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
