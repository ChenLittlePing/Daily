
import 'dart:async';
import 'package:audioplayer/audioplayer.dart';

/// 封装音频播放器
/// iOS需要在Runner/Info.plist配置一下信息，才能播放http类型的url音频
/// <key>NSAppTransportSecurity</key>
/// <dict>
/// <key>NSAllowsArbitraryLoads</key>
/// <true/>
/// </dict>
class APlayer {
  static final APlayer _singleton = APlayer._internal();

  static final AudioPlayer _player = new AudioPlayer();

  APlayer._internal();

  factory APlayer() {
    return _singleton;
  }

  Future<bool> play(String url) async {
    await stop();
    final result = await _player.play(url);
    return result == 1;
  }

  Future<bool> playLocal(String path) async {
    final result = await _player.play(path, isLocal: true);
    return result == 1;
  }

  Future<bool> pause() async {
    final result = await _player.pause();
    return result == 1;
  }

  Future<bool> stop() async {
    final result = await _player.stop();
    return result == 1;
  }
}