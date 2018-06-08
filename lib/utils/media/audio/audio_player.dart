
import 'dart:async';
import 'dart:ui';
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

  static Duration _duration = Duration();
  static Duration _position = Duration();

  factory APlayer() {
    return _singleton;
  }

  Duration getDuration() {
    return _duration;
  }

  Duration getPosition() {
    return _position;
  }

  void _clear() {
    _duration = Duration();
    _position = Duration();
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
    _clear();
    return result == 1;
  }

  Future<bool> seek(double seconds) async {
    final result = await _player.seek(seconds);
    return result == 1;
  }

  void setDurationHandler(TimeChangeHandler handler) {
    _player.setDurationHandler((duration) {
      _duration = duration;
      handler(duration);
    });
  }

  void setPositionHandler(TimeChangeHandler handler) {
    _player.setPositionHandler((duration) {
      _position = duration;
      handler(duration);
    });
  }

  void setCompletionHandler(VoidCallback callback) {
    _player.setCompletionHandler(callback);
  }
}