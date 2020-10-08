# feelings

一款基于 flutter 和[网易云接口](https://github.com/Binaryify/NeteaseCloudMusicApi)的音乐 app🎧

## 环境要求

- flutter  1.22.0-10.0.pre.138+
- [网易云音乐后端 API](https://github.com/Binaryify/NeteaseCloudMusicApi) (在`lib/global/http.dart`中可修改配置, 也可不修改而直接使用我的 API)
- 安卓虚拟机环境

## 安装

```shell
git clone git@github.com:xiong35/Feelings.git

flutter pub get
```

## 运行

> 确保运行`flutter doctor`无误

```shell
flutter run
```

## 打包 apk

参考[这篇教程](https://www.cnblogs.com/pp-pping/p/12167733.html), 先生成自己的数字签名密钥

```shell
flutter build apk
```

> `build\app\outputs\flutter-apk\app-release.apk`文件即是打包好的 apk

## 贡献者

- 感谢[左右不分的座头鲸](https://space.bilibili.com/262868467/)提供 logo 🌚

## License

[The MIT License (MIT)](https://github.com/xiong35/Feelings/blob/master/LICENSE)

## ENJOY IT😜