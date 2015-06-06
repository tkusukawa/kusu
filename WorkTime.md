# このページは[r-labs](http://www.r-labs.org/projects/worktime/wiki/WorkTime)に引越しました #

→ http://www.r-labs.org/projects/worktime/wiki/WorkTime

## 古いバージョンのリリースノート ##

  * Ver0.1.3([r229](https://code.google.com/p/kusu/source/detail?r=229)) [redmine\_work\_time-0.1.3.tar.gz](http://kusu.googlecode.com/files/redmine_work_time-0.1.3.tar.gz) Date: 2011-09-17
> Version 0.1.3<br>
<blockquote>fixes #824 ユーザ切り替え時にユーザ名が見えるように変更<br>
fixes #826 新規エントリの活動をデフォルト値が選択された状態で表示されるように修正<br>
fixed <a href='https://code.google.com/p/kusu/issues/detail?id=52'>Issue 52</a>: RuntimeError in Work timeController#index if there is a time entry without ticket id<br>
<a href='https://code.google.com/p/kusu/issues/detail?id=48'>Issue 48</a>: French translation<br>
エラー表示の不具合を修正<br>
fixed <a href='https://code.google.com/p/kusu/issues/detail?id=45'>Issue 45</a>: 時間トラッキングがイネーブルでないPJのチケットが「日毎工数」に表示される<br></blockquote>

<ul><li>Ver0.1.2(<a href='https://code.google.com/p/kusu/source/detail?r=225'>r225</a>) <a href='http://kusu.googlecode.com/files/redmine_work_time-0.1.2.tar.gz'>redmine_work_time-0.1.2.tar.gz</a> Date: 2011-07-03<br>
</li></ul><blockquote>Version 0.1.2<br>
fixed <a href='https://code.google.com/p/kusu/issues/detail?id=44'>Issue 44</a>: http 500 error loading work_time in Redmine 1.2.0 stable<br>
prototype.jsが二重に読み込まれていたのでインクルードを削除<br></blockquote>

<ul><li>Ver0.1.1(<a href='https://code.google.com/p/kusu/source/detail?r=223'>r223</a>) <a href='http://kusu.googlecode.com/files/redmine_work_time-0.1.1.tar.gz'>redmine_work_time-0.1.1.tar.gz</a> Date: 2011-06-27<br>
</li></ul><blockquote>(<a href='https://code.google.com/p/kusu/source/detail?r=223'>r223</a>) Version 0.1.1<br>
(<a href='https://code.google.com/p/kusu/source/detail?r=222'>r222</a>)<br>
Redmine-1.2でチケット追加を行えていなかった不具合の修正<br>
他の人の工数を確認した際に、自分に権限の無いプロジェクトが表示できていなかった問題の修正<br>
プロジェクト限定が機能していなかった問題の修正<br>
(<a href='https://code.google.com/p/kusu/source/detail?r=221'>r221</a>) フォーム更新時にもパラメータをURLに引き継ぐように修正<br>
(<a href='https://code.google.com/p/kusu/source/detail?r=219'>r219</a>)<br>
パラメータが無かった場合にパラメータ付きURLにリダイレクトするように修正<br>
メモのタイトルをパラメータ付きリンクに変更<br>
(<a href='https://code.google.com/p/kusu/source/detail?r=218'>r218</a>)<br>
<a href='https://code.google.com/p/kusu/issues/detail?id=42'>Issue 42</a>: 他人の工数参照にて変更系のリンクは不要 への対応<br>
チケットへのリンクをポップアップ属性に変更<br></blockquote>

<ul><li>Ver0.1.0(<a href='https://code.google.com/p/kusu/source/detail?r=212'>r212</a>) <a href='http://kusu.googlecode.com/files/redmine_work_time-0.1.0.tar.gz'>redmine_work_time-0.1.0.tar.gz</a> Date: 2011-05-22<br>
</li></ul><blockquote><font color='#ff0000'>
<blockquote>本バージョンにてDB設計が変更されていますので、バージョンアップ前のDBバックアップを強く推奨いたします。今回、チケット順位の月次保持を廃止しており、この処理変更に伴って過去のチケットが大量に表示される場合があります。その際は「終了チケット削除」のリンクを設けましたので、この機能にてご対応頂けると幸いです。<br>
</blockquote></font>
(<a href='https://code.google.com/p/kusu/source/detail?r=212'>r212</a>) Version 0.1.0<br>
(<a href='https://code.google.com/p/kusu/source/detail?r=211'>r211</a>) fixed <a href='https://code.google.com/p/kusu/issues/detail?id=39'>Issue 39</a>: Error 500 with Redmine <a href='https://code.google.com/p/kusu/source/detail?r=5723'>R5723</a>.<br>
(<a href='https://code.google.com/p/kusu/source/detail?r=209'>r209</a>) 重複削除と順序の正規化の処理が不完全だったので修正<br>
(<a href='https://code.google.com/p/kusu/source/detail?r=208'>r208</a>)<br>
月間集計においてもプロジェクト順序とチケット順序の重複削除と正規化を行うように修正<br>
行末の不要なセミコロンを削除<br>
日毎工数のデータ作成をリファクタリング（クエリ回数削減）<br>
工数が残っていてもチケット順序を削除できるように修正<br>
チケット追加ロジックをビューではなくちゃんとコントローラで処理するようにした<br>
(<a href='https://code.google.com/p/kusu/source/detail?r=206'>r206</a>) 終了チケットを削除する機能を追加<br>
(<a href='https://code.google.com/p/kusu/source/detail?r=204'>r204</a>)<br>
表示チケットの削除リンク<a href='x.md'>x</a>を月間工数表から日毎工数に移動<br>
月間工数表の表示内容をコントローラ内で計算するように修正<br>
月間工数表には工数が入力されたチケットしか表示しないように修正<br>
(<a href='https://code.google.com/p/kusu/source/detail?r=201'>r201</a>) 工数入力権限が無い場合でも工数入力できていた問題の修正<br>
(<a href='https://code.google.com/p/kusu/source/detail?r=199'>r199</a>)<br>
bug fix <a href='https://code.google.com/p/kusu/issues/detail?id=35'>Issue 35</a>: Worktime-Link in Top-Page-Menubar<br>
ログインしていなかったら一旦ログイン画面に遷移するように修正<br>
チケット抽出時に表示権限があることを確認するように修正<br>
プロジェクト順位を全プロジェクト共通とした<br>
チケット順位を月毎にしないで全月共通とした<br>
日毎工数からチケット順位を変更できるようにした<br>
プロジェクト順位とチケット順位の重複削除と順序の正規化を行うようにした<br>
(<a href='https://code.google.com/p/kusu/source/detail?r=198'>r198</a>) adapt <a href='https://code.google.com/p/kusu/issues/detail?id=35'>Issue 35</a>: Worktime-Link in Top-Page-Menubar<br>
(<a href='https://code.google.com/p/kusu/source/detail?r=197'>r197</a>) accept xyz3710's translation file(ko.yml)<br>
(<a href='https://code.google.com/p/kusu/source/detail?r=196'>r196</a>) accept maikovisky's translation.<br>
(<a href='https://code.google.com/p/kusu/source/detail?r=195'>r195</a>) accept Marc's translation.<br></blockquote>

<ul><li>Ver0.0.63(<a href='https://code.google.com/p/kusu/source/detail?r=191'>r191</a>) <a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.63+.tar.gz'>redmine_work_time-0.0.63+.tar.gz</a> Date: 2011-02-27<br>
</li></ul><blockquote><a href='https://code.google.com/p/kusu/issues/detail?id=28'>Issue 28</a>: 進捗率の入力をWorkTimeからできないか<br>
<a href='https://code.google.com/p/kusu/issues/detail?id=32'>Issue 32</a>: German translations<br>
NetBeansの警告箇所を修正<br>
チケット選択ポップアップの選択リンクをボタンに変更<br>
日毎工数でプロジェクト毎の合計値の表示崩れを修正<br>
日毎メモにユーザ名が表示されるように修正<br>
日毎工数のチケットへのリンクをshowModalDialogに変更<br>
メモの編集画面の下にも「更新」ボタンを設置<br></blockquote>

<ul><li>Ver0.0.62(<a href='https://code.google.com/p/kusu/source/detail?r=181'>r181</a>) <a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.62.tar.gz'>redmine_work_time-0.0.62.tar.gz</a> Date: 2010-12-12<br>
</li></ul><blockquote><a href='https://code.google.com/p/kusu/issues/detail?id=25'>Issue 25</a>: prj.activitiesがないときにエラー への対応<br>
<a href='https://code.google.com/p/kusu/issues/detail?id=30'>Issue 30</a>: luisete.serrano の多言語対応を取り込み<br></blockquote>

<ul><li>Ver0.0.61(<a href='https://code.google.com/p/kusu/source/detail?r=164'>r164</a>) <a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.61.tar.gz'>redmine_work_time-0.0.61.tar.gz</a> Date: 15:59:33, 2010年7月19日<br>
</li></ul><blockquote><a href='https://code.google.com/p/kusu/issues/detail?id=21'>Issue 21</a>: 一度登録した時間登録を消すI/Fがほしい への対応<br></blockquote>

<ul><li>(<a href='https://code.google.com/p/kusu/source/detail?r=163'>r163</a>) Date: 13:51:22, 2010年7月19日<br>
</li></ul><blockquote><a href='https://code.google.com/p/kusu/issues/detail?id=14'>Issue 14</a>: 書庫に保存したプロジェクトがチケット選択画面の選択肢に出てくる の修正<br></blockquote>

<ul><li>Ver0.0.60(<a href='https://code.google.com/p/kusu/source/detail?r=159'>r159</a>) <a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.60.tar.gz'>redmine_work_time-0.0.60.tar.gz</a> Date: 21:13:09, 2010年7月10日<br>
</li></ul><blockquote><a href='https://code.google.com/p/kusu/issues/detail?id=20'>Issue 20</a>: mschibata様から連絡いただいた「日毎工数の活動セレクトに同じ項目が複数表示される場合がある」問題の修正</blockquote>

<ul><li>Ver0.0.59(<a href='https://code.google.com/p/kusu/source/detail?r=124'>r124</a>) <a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.59.tar.gz'>redmine_work_time-0.0.59.tar.gz</a> Date: 17:20:23, 2010年2月11日<br>
</li></ul><blockquote>「<a href='https://code.google.com/p/kusu/issues/detail?id=19'>Issue 19</a>: プロジェクトメンバとしてグループを設定するとエラーになる」への対応</blockquote>

<ul><li>Ver0.0.58(<a href='https://code.google.com/p/kusu/source/detail?r=120'>r120</a>) <a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.58.tar.gz'>redmine_work_time-0.0.58.tar.gz</a> Date: 0:35:52, 2010年2月2日<br>
</li></ul><blockquote>大変長らく対応できていなかったIssue 5 (Redmine0.9で動作しない)への対応になります。<br>
本修正は全てsathiroyuki様のご尽力によるものです。ありがとうございます。</blockquote>

<ul><li>Ver0.0.57(<a href='https://code.google.com/p/kusu/source/detail?r=104'>r104</a>) <a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.57.tar.gz'>redmine_work_time-0.0.57.tar.gz</a> Date: 14:16:53, 2009年12月30日<br>
</li></ul><blockquote>「<a href='https://code.google.com/p/kusu/issues/detail?id=16'>Issue 16</a>: 経過時間のカスタムフィールド追加」への対応<br>
経過時間のカスタムフィールドを作成した場合に、日毎工数入力の画面でカスタムフィールドを入力できるように機能追加しました。</blockquote>

<ul><li>Ver0.0.56(<a href='https://code.google.com/p/kusu/source/detail?r=102'>r102</a>) <a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.56.tar.gz'>redmine_work_time-0.0.56.tar.gz</a> Date: 23:18:51, 2009年12月12日<br>
</li></ul><blockquote>「<a href='https://code.google.com/p/kusu/issues/detail?id=15'>Issue 15</a>:IEでの日毎工数-チケット追加」への対応</blockquote>

<ul><li>Ver0.0.55(<a href='https://code.google.com/p/kusu/source/detail?r=93'>r93</a>) <a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.55.tar.gz'>redmine_work_time-0.0.55.tar.gz</a> Date: 18:08:32, 2009年11月29日<br>
</li></ul><blockquote>チケットを削除すると場合によってはエラーで何も出来なくなるとの連絡をいただいたので対応しました</blockquote>

<ul><li>Ver0.0.54(<a href='https://code.google.com/p/kusu/source/detail?r=90'>r90</a>) <a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.54.tar.gz'>redmine_work_time-0.0.54.tar.gz</a> Date: 11:02:19, 2009年11月29日<br>
</li></ul><blockquote>「<a href='https://code.google.com/p/kusu/issues/detail?id=12'>Issue 12</a>: Redmine 0.8.7 でチケットを追加できない」への対応<br>
↑haru.ii.a9i1e様：詳細なご報告ありがとうございました。<br>
↑Ajax.Updateのmethodをgetにすることで解決いたしました。</blockquote>

<ul><li>Ver0.0.53(<a href='https://code.google.com/p/kusu/source/detail?r=72'>r72</a>) <a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.53.tar.gz'>redmine_work_time-0.0.53.tar.gz</a> Date: 21:31:39, 2009年11月1日<br>
</li></ul><blockquote>日毎工数入力のリストで既存のチケットを複製する機能を追加<br>
メモの日付表示に曜日の表示を追加<br>
チケット選択のポップアップダイアログで初期フォーカスが番号入力、且つEnterで適用されるように修正</blockquote>

<ul><li>Ver0.0.52(<a href='https://code.google.com/p/kusu/source/detail?r=63'>r63</a>) <a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.52.tar.gz'>redmine_work_time-0.0.52.tar.gz</a> Date: 18:05:49, 2009年9月13日<br>
</li></ul><blockquote>休日表示の機能追加(raku0893さんに送って頂いたコードをベースにしました)<br>
チケット選択を番号入力でも行えるように修正</blockquote>

<ul><li>Ver0.0.51(<a href='https://code.google.com/p/kusu/source/detail?r=61'>r61</a>) Date: 8:51:19, 2009年9月13日<br>
</li></ul><blockquote>「<a href='https://code.google.com/p/kusu/issues/detail?id=9'>Issue 9</a>: Developmentモードでエラー」の対応。<br>
developmentモードでも動作するように修正(情報提供ありがとうございます＞raku0893様)</blockquote>

<ul><li>Ver0.0.50(<a href='https://code.google.com/p/kusu/source/detail?r=60'>r60</a>) Date: 14:38:37, 2009年8月9日<br>
</li></ul><blockquote>データ列出力用の画面を追加</blockquote>

<ul><li>Ver0.0.49(<a href='https://code.google.com/p/kusu/source/detail?r=59'>r59</a>) Date: 13:33:10, 2009年8月9日</li></ul>

<blockquote>チケット洗濯時にクローズ状態のチケットを最初表示しないように修正</blockquote>

<ul><li>Ver0.0.48(<a href='https://code.google.com/p/kusu/source/detail?r=56'>r56</a>) <a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.48.tar.gz'>redmine_work_time-0.0.48.tar.gz</a> (2009-07-26 12:26:28)</li></ul>

<blockquote>「<a href='https://code.google.com/p/kusu/issues/detail?id=6'>Issue 6</a>:チケット付替設定の月の変更手段」の対応<br>
チケット選択ポップアップにあるプロジェクトと選択プルダウンの文言修正<br></blockquote>

<ul><li>Ver0.0.47(<a href='https://code.google.com/p/kusu/source/detail?r=55'>r55</a>)<br>
</li></ul><blockquote>「<a href='https://code.google.com/p/kusu/issues/detail?id=3'>Issue 3</a>:一度に複数のチケットを追加したい」への対応</blockquote>

<ul><li>Ver0.0.46(<a href='https://code.google.com/p/kusu/source/detail?r=54'>r54</a>)<br>
</li></ul><blockquote>日毎メモの編集状態時にも日付が表示されるように修正</blockquote>

<ul><li><a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.45.tar.gz'>redmine_work_time-0.0.45.tar.gz</a> (2009-07-01 23:51:19)<br>
</li></ul><blockquote>工数チケットの付替設定の追加／削除にて、ページを読み直すのではなく、テーブル内容をAjaxUpdateするように修正</blockquote>

<ul><li><a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.44.tar.gz'>redmine_work_time-0.0.44.tar.gz</a> (2009-6-29 23:48:31)<br>
</li></ul><blockquote>個人工数表示の月間集計に表示されないはずの、「その日のチケット操作」が表示されて高さの計算がずれる不具合を修正。</blockquote>

<ul><li><a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.43.tar.gz'>redmine_work_time-0.0.43.tar.gz</a> (2009-6-27 23:13:33)<br>
</li></ul><blockquote>チケット付替設定を別画面にした際の不具合修正。<br>
チケット付替え画面で付替え後のチケット月間集計を確認できるように修正。</blockquote>

<ul><li>redmine_work_time-0.0.42.tar.gz (2009-6-27 15:44:31)<br>
</li></ul><blockquote>新しいプロジェクトの当日操作チケットが表示されない問題を修正</blockquote>

<ul><li>redmine_work_time-0.0.41.tar.gz (2009-6-27 14:52:22)<br>
</li></ul><blockquote>月間集計の付け替え設定を個別の画面で表示するように変更</blockquote>

<ul><li><a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.40.tar.gz'>redmine_work_time-0.0.40.tar.gz</a> (2009-6-21 21:55:25)<br>
</li></ul><blockquote>IEでJavaScriptがエラーになる不具合を修正</blockquote>

<ul><li><a href='http://kusu.googlecode.com/files/redmine_work_time-0.0.39.tar.gz'>redmine_work_time-0.0.39.tar.gz</a> (2009-6-15 19:05:20)</li></ul>


もっと過去のバージョンは<br>
<a href='http://kusu.way-nifty.com/blog/redmine_work_time.html'>http://kusu.way-nifty.com/blog/redmine_work_time.html</a>
にあります。