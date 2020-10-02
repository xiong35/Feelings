import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Profile {
  String locale;
  String theme = "light";
}

class Global {
  // static SharedPreferences _prefs;
  static Profile profile = Profile();
  // 网络缓存对象
  // static NetCache netCache = NetCache();

  // 可选的主题列表
  // static List<MaterialColor> get themes => _themes;

  // 是否为release版
  // static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在APP启动时执行
  // static Future init() async {
  //   _prefs = await SharedPreferences.getInstance();
  //   var _profile = _prefs.getString("profile");
  //   if (_profile != null) {
  //     try {
  //       profile = Profile.fromJson(jsonDecode(_profile));
  //     } catch (e) {
  //       print(e);
  //     }
  //   }

  //   // 如果没有缓存策略，设置默认缓存策略
  //   profile.cache = profile.cache ?? CacheConfig()
  //     ..enable = true
  //     ..maxAge = 3600
  //     ..maxCount = 100;

  //   //初始化网络请求相关配置
  //   Git.init();
  // }

  // 持久化Profile信息
  static saveProfile() => {
        print(
          'locale: ${profile.locale}, theme: ${profile.theme}',
        )
      };
  // _prefs.setString("profile", jsonEncode(profile.toJson()));
}

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}

class LocaleModel extends ProfileChangeNotifier {
  // 获取当前用户的APP语言配置Locale类，如果为null，则语言跟随系统语言
  Locale getLocale() {
    if (_profile.locale == null) return null;
    var t = _profile.locale.split("_");
    return Locale(t[0], t[1]);
  }

  // 获取当前Locale的字符串表示
  String get locale => _profile.locale;

  // 用户改变APP语言后，通知依赖项更新，新语言会立即生效
  set locale(String locale) {
    _profile.locale = locale;
    notifyListeners();
  }
}

class ThemeModel extends ProfileChangeNotifier {
  String get theme => _profile.theme;

  set theme(String newTheme) {
    _profile.theme = newTheme;
    notifyListeners();
  }
}
