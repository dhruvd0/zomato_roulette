import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  void initState() {
    super.initState();
  }

  double volume = 0.5;
  @override
  Widget build(BuildContext context) {
    var width2 = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      color: Colors.green,
      width: width2,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: width2,
            child: CachedNetworkImage(
              imageUrl:
                  "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/a320bd27907029.586f9786314eb.gif",
              fit: BoxFit.fitWidth,
            ),
          ),
          const Positioned(
            bottom: 100,
            left: 20,
            child: Text(
              "",
              style: TextStyle(color: Colors.white,fontSize: 50),
            ),
          )
        ],
      ),
    ));
  }
}

String convertToMinutesSeconds(Duration duration) {
  final parsedMinutes = duration.inMinutes < 10
      ? '0${duration.inMinutes}'
      : duration.inMinutes.toString();

  final seconds = duration.inSeconds % 60;

  final parsedSeconds =
      seconds < 10 ? '0${seconds % 60}' : (seconds % 60).toString();
  return '$parsedMinutes:$parsedSeconds';
}

IconData animatedVolumeIcon(double volume) {
  if (volume == 0)
    return Icons.volume_mute;
  else if (volume < 0.5)
    return Icons.volume_down;
  else
    return Icons.volume_up;
}
