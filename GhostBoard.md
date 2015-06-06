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

## 機能 ##
表示：クリップボードのテキスト内容を監視して、半透明のウィンドウにリアルタイム表示します。
透明度は好みの濃さに設定できるので邪魔になる場合は薄くしておくことができます。

履歴：過去のクリップボードテキストを記憶し、簡単な操作で再度クリップボードに戻すことができます。

定型文：設定しておいた定型テキストを、簡単な操作でクリップボードにセットできます。

操作：マウスによるメニュー選択の他に、ホットキーによって直感的な選択操作を行うことができます。

## 動作環境 ##
Windows XP,Vista, Windows7で使えています。

## インストール／アンインストール ##
インストーラはプログラムメニューとスタートアップにショートカットを作成し、
ユーザのアプリケーションデータフォルダに作業フォルダ:GhostBoardを作成します。
コントロールパネルの「プログラム～」でアンインストールすることで、
配置したEXEとショートカットが削除されます。
プログラムによって作業フォルダに作成された設定ファイルは
削除されませんので不要な場合は手動で削除してください。

レジストリは使用していません。EXEファイルを実行すると、
作業フォルダに設定情報のファイルが作られます。

## 操作方法 ##
● GhostBoardウィンドウのアクティブ化（移動、リサイズ、透明度）<br>
「アクティブキー」(デフォルトはCtrl)を長押しすることで<br>
ウィンドウの透過モードが解除され、<br>
ウィンドウ操作を行うことが可能になります。<br>
<br>
長押ししながらウィンドウの端でマウスカーソルが十字矢印になったところで<br>
ドラッグするとウィンドウが移動し、<br>
ウィンドウの端でマウスカーソルが上下または左右の矢印になったところで<br>
ドラッグするとウィンドウの大きさが変わります。<br>
<br>
「アクティブキー」はデフォルト設定では「Ctrl」ですが、<br>
Ctrl,Shift,Alt,Winの4つのキーの中から任意の組合せを設定することができます。<br>
(タスクトレイ右クリック→Settings→active key)<br>
<br>
表示が邪魔になる場合は透明度を変更することができます。<br>
アクティブ化した時のウィンドウの透明度、通常のウィンドウの透明度および<br>
マウスを近づけた際の透明度を個別に設定することができます。<br>
(右クリック→Settings→ active alpha/default alpha/on mouse alpha)<br>
<br>
● クリップボードの監視と履歴参照<br>
GhostBoardはクリップボードへのコピーイベントを監視し、<br>
コピーされたテキストをGhostBoardウィンドウに即時表示します。<br>
取得したコピーテキストは記憶しており、<br>
ホットキーの上下（デフォルトはCtrl＋↑/↓）で順に履歴を呼び出して<br>
クリップボードに書き戻すことができます。<br>
<br>
ホットキー操作を行っても入力フォーカスは元のアプリケーションのままなので<br>
ウィンドウ切り替えを行うことなく、編集作業を継続することができます。<br>
<br>
参照操作時に前後の履歴番号とテキストの一部がバルーン表示されます。<br>
（邪魔な場合は設定をOFFにしてください。右クリック→Settings→icon notif.）<br>
<br>
履歴の参照と選択はマウス操作でも行うことができます。<br>
タスクトレイのGhostBoardアイコンを右クリックすることで<br>
履歴の一覧をメニュー表示することができマウスクリックで選択できます。<br>
<br>
● テキストグループの選択（定形テキスト）<br>
ホットキーの左右(デフォルトはCtrl＋←/→)で、<br>
テキストグループを選択します。<br>
テキストグループには「白」「赤」「緑」「青」の４つがあります。<br>
「白」はクリップボードの履歴を参照するグループ、<br>
その他のグループは定形テキストを保存・参照するグループとなっています。<br>
<br>
各グループにそれぞれ定型文を保存することができ、<br>
グループ選択後にホットキーの上下(デフォルトはCtrl＋↑/↓)で記憶領域を選択します。<br>
(記憶領域番号はバルーン表示で確認できます)<br>
<br>
定型文の記憶領域はマウス操作でも選択することができます。<br>
タスクトレイのアイコンを右クリックし、<br>
メニューの「red」「green」「blue」を選択すると<br>
各グループの記憶領域がサブメニューとして表示されます。<br>
<br>
● フォーカス（編集）<br>
下記のいずれかの操作によって<br>
GhostBoardウィンドウにフォーカスが与えられ、<br>
選択中の記憶領域を編集できる状態になります。<br>
・アクテイブキーを押しながらGhostBoardウィンドウをクリック<br>
・タスクトレイのアイコンを左クリック<br>
・ホットキー（デフォルト設定：Ctrl+Shift+F）<br>
<br>
編集状態に入ってからも<br>
ホットキーの上下左右で記憶領域を切り替えることができます。<br>
<br>
テキストグループ「赤」「緑」「青」の編集結果は設定ファイルに格納され、<br>
次回起動時に復元されますが、クリップボード履歴(グループ白)の内容は<br>
永続化されません。<br>
<br>
ホットキーはトグル動作となっており、<br>
フォーカスがある状態で再度ホットキー操作すると<br>
元のアプリケーションにフォーカスを戻します。<br>
<br>
● メニュー<br>
下記のいずれかの操作でメニューを表示することができます。<br>
・タスクトレイのアイコンを右クリック<br>
・ホットキー（デフォルト設定：Ctrl+Shift+M）<br>
・GhostBoardウィンドウを右クリック(フォーカスが無い状態ではアクティブキーを押しながら右クリック)<br>
<br>
● 設定<br>
メニューの「Settings」を選択することで設定ダイアログを表示します。<br>
設定ダイアログでは、以下の設定を行うことができます。<br>
１．各状態でのウィンドウ表示濃度<br>
２．アクティブキーの組合せ<br>
３．バルーン表示する／しない<br>
４. ホットキーの変更<br>
５．ホットキー操作時のリスト表示の高さと濃度<br>
６．記録できるテキストの数(1～256)<br>
<br>
● わかりにくい仕様<br>
設定ダイアログでホットキーの設定に修飾キー(CtrlやShift等)無しで設定すると、<br>
アクティブキーの組み合わせが修飾キーとして使われます。<br>
→ ホットキーにWinキーが使えます。<br>
<br>
● 終了<br>
メニューの「Exit」を選択することでGhostBoardを終了することが出来ます。<br>
<br>
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
<h2>掲載記事</h2>
・iP!（アイピー）2010年2月号<br>
・Windows100% 2010年02月号<br>
・<a href='http://www.vector.co.jp/magazine/softnews/100316/n1003162.html'>ベクターレビュー</a> 2010年3月16日<br>
・iP!（アイピー）2010年4月号<br>
・週刊アスキー2010年4月26日発売「煌７道場」<br>
・週刊アスキー2010年9月13日発売 「800号記念 フリーソフト800本掲載大特集」<br>
・Windows100% 2010年10月号<br>
・<a href='http://www.gigafree.net/utility/clip/ghostboard.html'>ｋ本的に無料ソフト・フリーソフト</a> 2010年12月8日(?) ←使い方の説明がとてもわかりやすいです<br>
・フリーソフトBest Of Best 2011 完全保存版 (超トリセツ) ISBN978-4-905144-07-6 2011/2/24<br>
・日経PCビギナーズ2011年12月号69ページ<br>
・日経パソコン2013年1月14日号「お答えします」<br>
<br>
<h2>バイナリダウンロード</h2>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoardInstaller-1.1.21.zip'>GhostBoard-1.1.21 インストーラ</a>
</li><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.1.21.zip'>GhostBoard-1.1.21 EXEファイル</a>
<blockquote>2010/10/24 <a href='https://code.google.com/p/kusu/source/detail?r=175'>r175</a> Ver1.1.21<br>
<a href='https://code.google.com/p/kusu/issues/detail?id=26'>Issue 26</a>: 修飾キーなしの設定だったらActiveキーを修飾キーに使う の対応<br></blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoardInstaller-1.1.20.zip'>GhostBoard-1.1.20 インストーラ</a>
</li><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.1.20.zip'>GhostBoard-1.1.20 EXEファイル</a>
<blockquote>2010/09/20 <a href='https://code.google.com/p/kusu/source/detail?r=173'>r173</a> Ver1.1.20<br>
テキスト数を任意数にした際のメニュー表示の不具合を修正<br></blockquote></li></ul>

<ul><li>GhostBoard-1.1.19 インストーラ<br>
</li><li>GhostBoard-1.1.19 EXEファイル<br>
<blockquote>2010/09/20 <a href='https://code.google.com/p/kusu/source/detail?r=170'>r170</a> Ver1.1.19 ※任意数のメニュー表示処理に不具合が見つかりました<br>
<a href='https://code.google.com/p/kusu/issues/detail?id=23'>Issue 23</a>: フォーカスインとメニュー表示のホットキーが欲しい の対応 <a href='https://code.google.com/p/kusu/source/detail?r=168'>r168</a><br>
<a href='https://code.google.com/p/kusu/issues/detail?id=24'>Issue 24</a>: 白赤緑青の各グループの記録数を任意に設定できるようにして欲しい の対応 <a href='https://code.google.com/p/kusu/source/detail?r=169'>r169</a><br></blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoardInstaller-1.1.18.zip'>GhostBoard-1.1.18 インストーラ</a>
</li><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.1.18.zip'>GhostBoard-1.1.18 EXEファイル</a>
<blockquote>2010/09/04 <a href='https://code.google.com/p/kusu/source/detail?r=166'>r166</a> Ver1.1.18<br>
ホットキーによる履歴選択操作時に履歴リストがちらつかないように修正</blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoardInstaller-1.1.17.zip'>GhostBoard-1.1.17 インストーラ</a>
</li><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.1.17.zip'>GhostBoard-1.1.17 EXEファイル</a>
<blockquote>2010/07/18 <a href='https://code.google.com/p/kusu/source/detail?r=161'>r161</a><br>
ホットキー操作時のリスト表示をバルーンでなく、リストボックスコントロールで行うように変更<br>
バージョン1.1.17に更新<br></blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoardInstaller-1.1.16.zip'>GhostBoard-1.1.16 インストーラ</a>
</li><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.1.16.zip'>GhostBoard-1.1.16 EXEファイル</a>
<blockquote>2010/06/19 <a href='https://code.google.com/p/kusu/source/detail?r=156'>r156</a><br>
表示濃度を最低に設定した際にウィンドウがアクティブにならないように修正<br>
バルーンの履歴表示の横幅を予め確保するために先頭行にタブを表示<br>
デフォルトの表示濃度を150から100に変更<br>
VerUp時に設定ファイルを消さずに引き継ぐように修正<br>
バージョン番号を1.1.16に更新<br></blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoardInstaller-1.1.15.zip'>GhostBoard-1.1.15 インストーラ</a>
</li><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.1.15.zip'>GhostBoard-1.1.15 EXEファイル</a>
<blockquote>2010/06/12 <a href='https://code.google.com/p/kusu/source/detail?r=154'>r154</a><br>
バージョン番号を1.1.15に更新<br>
2010/04/24 <a href='https://code.google.com/p/kusu/source/detail?r=153'>r153</a><br>
ホットキーの設定を無しにした時の不具合を修正<br></blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoardInstaller-1.1.14.zip'>GhostBoard-1.1.14 インストーラ</a>
</li><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.1.14.zip'>GhostBoard-1.1.14 EXEファイル</a>
<blockquote>2010/04/18 <a href='https://code.google.com/p/kusu/source/detail?r=150'>r150</a><br>
履歴探索時のバルーン表示の文字数等を調整<br>
ReadMeブラッシュアップ<br>
2010/04/18 <a href='https://code.google.com/p/kusu/source/detail?r=149'>r149</a><br>
定型文のIndex参照方向を反転<br>
2010/04/12 <a href='https://code.google.com/p/kusu/source/detail?r=148'>r148</a><br>
ホットキーによる参照時にリストをバルーン表示<br>
2010/04/11 <a href='https://code.google.com/p/kusu/source/detail?r=146'>r146</a><br>
ウィンドウがスクリーンの上や左にとび出した場合もスクリーン内に連れ戻すように修正<br>
メニューをESCでキャンセルした場合はフォーカスを捨てるように修正<br>
2010/04/11 <a href='https://code.google.com/p/kusu/source/detail?r=145'>r145</a><br>
ホットキー設定機能を追加<br>
2010/04/10 <a href='https://code.google.com/p/kusu/source/detail?r=144'>r144</a><br>
GhostBoardウィンドウでの最後の操作がコピーであれば、表示内容ではなくコピー内容をクリップボードに残すように修正<br></blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoardInstaller-1.1.12.zip'>GhostBoard-1.1.12 インストーラ</a>
</li><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.1.12.zip'>GhostBoard-1.1.12 EXEファイル</a>
<blockquote>2010/03/27 <a href='https://code.google.com/p/kusu/source/detail?r=142'>r142</a><br>
ホットキーで履歴を参照した際に履歴を更新してしまう場合があった問題を修正</blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoardInstaller-1.1.11.zip'>GhostBoard-1.1.11 インストーラ</a>
</li><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.1.11.zip'>GhostBoard-1.1.11 EXEファイル</a>
<blockquote>2010/03/22 <a href='https://code.google.com/p/kusu/source/detail?r=138'>r138</a><br>
ReadMe.txtへの操作方法の追記<br>
登録されていない定型文の記憶領域をメニューに表示するように修正<br>
(久米様：ご助言ありがとうございました)<br>
起動直後にフォーカスを失っても透明化されない場合があった問題の修正<br>
定型文を選択した際にクリップボード履歴を追加してしまう場合があった問題の修正</blockquote></li></ul>

<ul><li><a href='http://kusu.googlecode.com/files/GhostBoardInstaller-1.1.10.zip'>GhostBoard-1.1.10 インストーラ</a>
</li><li><a href='http://kusu.googlecode.com/files/GhostBoard-1.1.10.zip'>GhostBoard-1.1.10 EXEファイル</a>
<blockquote>2010/03/20 <a href='https://code.google.com/p/kusu/source/detail?r=136'>r136</a><br>
クリップボード監視の正常性確認をアクティブキー操作毎に行うように修正<br>
稀にフォーカス状態の認識が切り替わり続ける問題の修正<br>
メニューから履歴/定型文を選択した際にフォーカスを元のアプリに戻す機能を追加</blockquote></li></ul>

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

<ul><li><a href='http://kusu.googlecode.com/files/ghostboard-1.0.0.3.zip'>ghostboard-1.0.0.3.zip</a>