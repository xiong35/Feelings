
# api

## global

- [登录](https://binaryify.github.io/NeteaseCloudMusicApi/#/?id=_1-%e6%89%8b%e6%9c%ba%e7%99%bb%e5%bd%95): `/login/cellphone?phone=xxx&md5_password=yyy`
- 歌单详情: `/playlist/detail?id=24381616`

## home

- [banner](https://binaryify.github.io/NeteaseCloudMusicApi/#/?id=banner): `/banner?type=1`
- 单曲
  - 根据登录状态获得: `/recommend/songs`
  - 热门单曲: `/artist/top/song?id=6452` // 夹带私货
- 歌单
  - 根据登录状态获得: `/recommend/resource`
  - [热门歌单](https://binaryify.github.io/NeteaseCloudMusicApi/#/?id=%e8%8e%b7%e5%8f%96%e7%b2%be%e5%93%81%e6%ad%8c%e5%8d%95): `/top/playlist/highquality`
- [收藏歌单](https://binaryify.github.io/NeteaseCloudMusicApi/#/?id=%e6%94%b6%e8%97%8f%e5%8f%96%e6%b6%88%e6%94%b6%e8%97%8f%e6%ad%8c%e5%8d%95): `/playlist/subscribe`
- 喜欢音乐: `/like?id=347230`

## mine

- 用户详情: `/user/detail?uid=32953014`
- 用户歌单: `/user/playlist?uid=32953014`
- 新建歌单: `/playlist/create?name=测试歌单`
- 删除歌单: `/playlist/delete?id=5013464397,5013427772`

## playView

- 获取歌词: `/lyric?id=33894312`
- 歌曲 url: `/song/url?id=33894312`