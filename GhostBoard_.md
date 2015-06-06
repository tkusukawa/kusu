# WinApp：GhostBoard #

クリップボード操作(Ctrl+x,Ctrl+c,Ctrl+v)をしていて、
「いまちゃんとコピーできたかな？」
「ペーストしようとしているものは合ってる？」
と思って躊躇したことはないでしょうか。
文章をいじっていて、移動させるつもりで一部分をカットして、
別の操作を挟んだ際にクリップボードを使って消えてしまった、
ということはないでしょうか。
GhostBoardはそんな方の役に立ちます。

「覚えきれないので文字列表示を見ながらコマンドを入力したい」とか
「いつもコピペする定形テキストを簡単に入力したい」
という方にも利用していただけると思います。

![http://kusu.googlecode.com/files/ghostboardcap.jpg](http://kusu.googlecode.com/files/ghostboardcap.jpg)

## 動作環境 ##
Windows XP,Vista, Windows7で使えています。

## インストール／アンインストール ##
インストーラではプログラムメニューとスタートアップにショートカットを作成し、
ユーザのアプリケーションデータフォルダにGhostBoardフォルダを作成します。
コントロールパネルの「プログラム～」でアンインストールすることで、
作成したショートカットとGhostBoardフォルダは削除されます。

レジストリは使用していません。EXEファイルを実行すると、
作業フォルダに設定情報のファイルが作られます。

## 操作方法 ##
● ウィンドウのアクティブ化（移動、リサイズ）<br>
「アクティブキー」(デフォルトはCtrl)を長押しすることで<br>
ウィンドウの透過モードが解除され、<br>
ウィンドウ操作が行えるようになります。<br>
<br>
長押ししながらウィンドウの端でマウスカーソルが十字矢印になったところで<br>
ドラッグするとウィンドウが移動し、<br>
ウィンドウの端でマウスカーソルが上下または左右の矢印になったところで<br>
ドラッグするとウィンドウの大きさが変わります。<br>
<br>
「アクティブキー」はデフォルト設定では「Ctrl」ですが、<br>
Ctrl,Shift,Alt,Winの4つのキーの中から任意の組合せを設定することができます。<br>
<br>
● クリップボードの監視と履歴参照<br>
GhostBoardは他のアプリケーションのクリップボードへのコピーを監視し、<br>
コピーされたテキストをウィンドウに即時表示します。<br>
取得した更新テキストは過去32個まで記憶しており、<br>
ホットキー（アクティブキー長押し＋↑/↓）で順に履歴を呼び出して<br>
クリップボードに書き戻すことができます。<br>
<br>
ホットキー操作を行っても入力フォーカスは元のアプリケーションのままなので<br>
ウィンドウ切り替えを行うことなく、編集作業を継続することができます。<br>
<br>
履歴の一覧はタスクトレイのアイコンを右クリックしたときのメニューで<br>
「history」を選択すると確認することができます。<br>
<br>
操作時に履歴番号やテンプレート番号がバルーン表示されます。<br>
（履歴では時刻も表示されます。邪魔な場合は設定をOFFにしてください。）<br>
<br>
● テキストグループの選択（定形テキスト）<br>
「アクティブキー＋←」「アクティブキー＋→」で、<br>
テキストグループを選択します。<br>
テキストグループには「白」「赤」「緑」「青」の４つがあります。<br>
「白」はクリップボードの履歴を参照するグループ、<br>
その他のグループは定形テキストを保存・参照するグループとなっています。<br>
<br>
● フォーカス（編集）<br>
定形テキストの内容を編集する際は<br>
アクティブキーを押しながらウィンドウをクリックするか、<br>
タスクトレイのアイコンをクリックすることで<br>
GhostBoardにフォーカスが与えられ、編集できる状態になります。<br>
<br>
● メニュー<br>
アクティブキーを押しながらウィンドウを右クリックするか、<br>
タスクトレイのアイコンを右クリックすることで、<br>
メニューを表示します。<br>
<br>
メニューからクリップボード履歴や定形テキストを選択することもできます。<br>
<br>
● 設定<br>
メニューの「Settings」を選択することで設定ダイアログを表示します。<br>
設定ダイアログでは、以下の設定を行うことができます。<br>
１．各状態でのウィンドウ表示濃度<br>
２．アクティブキーの組合せ<br>
３．バルーン表示する／しない<br>
<br>
● 終了<br>
メニューの「Exit」を選択することでGhostBoardを終了することが出来ます。<br>
<br>
▲ ダイアログが画面の外に出ちゃった時の対応<br>
リモートデスクトップ等で画面サイズが変わった際に<br>
ダイアログが表示領域の外に出てしまう場合があり、<br>
見ることも操作することもできなくなった時の対応方法です。<br>
1.タスクトレイのアイコンをクリックしてダイアログにフォーカスを与えます<br>
2.「Altキー」+「スペースキー」を押します。→ メニューが出る<br>
3.メニューの「移動」を選ぶ<br>
4.カーソルキー（例えば「↑」）を押す<br>
5.マウスを動かす→マウスカーソルにダイアログがくっついてくる<br>
6.目的の場所までマウスを動かしてクリック→移動完了<br>

<h2>連絡先</h2>
バグレポートやご要望については本ページにコメント書き込むか、<br>
「Issues」に書き込みをして頂けると助かります。<br>
<br>
<h2>開発環境</h2>
GhostBoardはVisualStudio2005 StandardEdition(VC++ MFC)で作っています。<br>
ソースコードをSubversionのリポジトリの形で<br>
<a href='http://kusu.googlecode.com/svn/trunk/WinApp/GhostBoard/'>http://kusu.googlecode.com/svn/trunk/WinApp/GhostBoard/</a>
にて公開しています。<br>
自分が欲しい機能を試行錯誤を繰り返して加えてきたものなので、<br>
間違いなどがあるかもしれませんが、何かの参考になれば幸いです。<br>
お気づきの点がございましたらご連絡いただけると助かります。<br>
<br>
<h2>バイナリダウンロード</h2>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoardInstaller-1.1.9.zip'>GhostBoard-1.1.9 インストーラ</a>
</li><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.1.9.zip'>GhostBoard-1.1.9 EXEファイル</a>
<blockquote>2010/03/13 <a href='https://code.google.com/p/kusu/source/detail?r=131'>r131</a><br>
インストーラを追加<br>
クリップボードチェインに更新イベントを渡せていなかった問題の修正<br>
クリップボードチェインから外れていた場合に再接続する仕組みを実装<br>
履歴のメニュー選択をサブメニューからメインメニューに変更</blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.1.8.zip'>GhostBoard-1.1.8</a>
<blockquote>2010/03/06 <a href='https://code.google.com/p/kusu/source/detail?r=129'>r129</a><br>
クリップボード文字列の取得処理を別スレッドで処理することで連続イベント通知に対して一度しか処理を行わないように効率化<br>
履歴参照時に履歴を追加してしまう不具合を修正<br>
フォーカス時にクリップボードを更新してしまう問題を修正<br>
スクリーンサイズが小さくなったときにスクリーンに入る位置に移動する機能を実装</blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.1.7.zip'>GhostBoard-1.1.7</a>
<blockquote>2010/02/27 <a href='https://code.google.com/p/kusu/source/detail?r=126'>r126</a><br>
テキスト以外がクリップボードにある時のダイアログの色がグレーになるように修正<br>
テキスト以外がクリップボードにあがった後にインデックス番号がおかしくなる不具合の修正</blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.1.6.zip'>GhostBoard-1.1.6</a>
<blockquote>2010/01/18 <a href='https://code.google.com/p/kusu/source/detail?r=113'>r113</a> <a href='https://code.google.com/p/kusu/source/detail?r=114'>r114</a> <a href='https://code.google.com/p/kusu/source/detail?r=115'>r115</a> <a href='https://code.google.com/p/kusu/source/detail?r=116'>r116</a><br>
アクティブ時の透明度を設定できるように修正<br>
デフォルトのウィンドウ位置が右下になるように修正<br>
アクティブになった際に必ず最前面に表示されるように修正<br>
非表示設定の機能を削除（透明度を０に設定すれば良いので）<br>
バルーン表示する／しないを設定できる機能を追加<br>
履歴や定形テキストをメニューから選択できる機能を追加</blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.1.5.zip'>GhostBoard-1.1.5(BETA)</a>
<blockquote>2010/01/10 <a href='https://code.google.com/p/kusu/source/detail?r=110'>r110</a><br>
エクセルのセルをコピーすると正常にクリップボードを監視出来なくなる問題の対応<br>
ファイルコピー時にファイルのパスを表示するように修正</blockquote></li></ul>

<ul><li>GhostBoard-1.1.4(BETA)<br>
<blockquote>2010/01/10 <a href='https://code.google.com/p/kusu/source/detail?r=105'>r105</a> <a href='https://code.google.com/p/kusu/source/detail?r=107'>r107</a> <a href='https://code.google.com/p/kusu/source/detail?r=108'>r108</a><br>
クリップボードの更新タイミングを「アクテイブキーOFF時」→「履歴表示時」に変更<br>
アクティブキーのデフォルトを「Ctrl+Alt」→「Ctrl」に変更<br>
デフォルトの透明度を変更(薄く)<br>
クリップボードの内容がテキストでない時は「not TEXT」をバルーン表示するように修正<br>
クリップボードテキストの取得処理をリファクタリング<br></blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.1.3.zip'>GhostBoard-1.1.3.zip</a>
<blockquote>2009/11/16 <a href='https://code.google.com/p/kusu/source/detail?r=88'>r88</a><br>
「<a href='https://code.google.com/p/kusu/issues/detail?id=11'>Issue 11</a>: テンプレートの編集内容が保持されない場合がある」への対応<br></blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.1.2.zip'>GhostBoard-1.1.2.zip</a>
<blockquote>2009/11/08 <a href='https://code.google.com/p/kusu/source/detail?r=83'>r83</a><br>
アクティブキーにWindowsキーを追加<br>
アクティブキーの一部だけを押した時に一瞬アクティブになる問題を修正<br>
2009/11/14 <a href='https://code.google.com/p/kusu/source/detail?r=84'>r84</a><br>
テキストテンプレート機能を追加<br>
2009/11/15 Rev.85<br>
フォーカス消失のイベントを取りこぼす問題への対応<br>
アクティブキー＋Enterでフォーカス取得(テンプレート編集)できるように修正<br>
README.txtを記述<br></blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.0.0.8.zip'>GhostBoard-1.0.0.8.zip</a>
<blockquote>2009/11/08 <a href='https://code.google.com/p/kusu/source/detail?r=80'>r80</a><br>
起動時の履歴が無い状態で履歴を参照するとエラーになっていた不具合を修正<br>
履歴番号を最新との差ではなく、起動時からのカウント番号を表示するように修正<br>
クリップボードへのテキストコピーのタイミングで番号をバルーン表示するように修正<br>
バルーン表示が決まった時間にきちんと消えるように修正</blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.0.0.7.zip'>GhostBoard-1.0.0.7.zip</a>
<blockquote>2009/11/07 <a href='https://code.google.com/p/kusu/source/detail?r=76'>r76</a><br>
透明度とアクティブキーを設定で変更できるように修正</blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.0.0.6.zip'>GhostBoard-1.0.0.6.zip</a>
<blockquote>2009/11/03 <a href='https://code.google.com/p/kusu/source/detail?r=74'>r74</a><br>
タスクトレイに格納するように修正<br>
クリップボードの履歴の番号とコピーした時刻をバルーン表示するように修正<br>
使われていない履歴配列は表示しないように修正</blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.0.0.5.zip'>GhostBoard-1.0.0.5.zip</a>
<blockquote>2009/11/01 <a href='https://code.google.com/p/kusu/source/detail?r=70'>r70</a>
履歴編集中のコピペのおかしな挙動を修正</blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.0.0.4.zip'>GhostBoard-1.0.0.4.zip</a>
<blockquote>2009/10/31<br>
ホットキーで過去のコピーの履歴をクリップボードに呼び出せるように修正</blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/ghostboard-1.0.0.3.zip'>ghostboard-1.0.0.3.zip</a></li></ul>
