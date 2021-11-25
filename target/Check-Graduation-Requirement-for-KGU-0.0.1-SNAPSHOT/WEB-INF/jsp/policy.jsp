<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>関西学院大学 卒業判定サイト プライバシーポリシー</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/style.css">
</head>

<body>

<header>
<div style="text-align:center">
<!-- heroku用であればhref="/"とするとルートディレクトリを指定してくれる。以下はローカル用
<h1><a href="./CheckGrades" style="text-decoration:none;"><font color="dodgerblue">
 -->
<h1><a href="/" style="text-decoration:none;"><font color="dodgerblue">
関西学院大学
<img src="${pageContext.request.contextPath}/image/crescent.png" alt="" align="bottom" width="50" height="50">
卒業判定サイト
</font></a></h1>
</div>
</header>

<main>

<table class="table-w"><tr>
<td>　</td><td>


<h2 id="use">利用規約</h2>
----------------------------------------------------------------------------------<br>

<h2>免責事項</h2>
※本サイトの卒業可否の誤判定による責任は一切負いかねますので，予めご了承ください。<br>
※卒業条件の詳細は、各学部の「履修心得」・「教育課程表」をご覧ください。<br>
※判定結果に誤りがある場合がありますので，最終的な卒業可否の判断は，各個人で行ってください。<br>

<h2 id="privacy">プライバシーポリシー</h2>
※取得した成績通知書は，本サイトの卒業判定以外には利用いたしません。<br>
※取得した個人情報を第三者に譲渡することはありません。<br>

<h2>アクセス解析ツールについて</h2>
本サイトでは、Googleによるアクセス解析ツール「Googleアナリティクス」を使用しています。<br>
このGoogleアナリティクスは、データの収集のためにCookieを使用しています。
このデータは匿名で収集されており、個人を特定するものではありません。
この機能はCookieを無効にすることで収集を拒否することが出来ますので、お使いのブラウザの設定をご確認ください。<br>

<h2>プライバシーポリシーの変更について</h2>
※本ポリシーの内容は，ユーザーに通知することなく変更することがあります。<br>
※変更後のプライバシーポリシーは，本サイトに掲載したときから効力を生じるものとします。<br><br>


</td><td>　</td>
</tr></table>

</main>

<footer>
<div style="text-align:center">
<a href="./PrivacyPolicy#use" style="text-decoration:none;"><font size=4 color="white">
・利用規約
</font></a>
　
<a href="./PrivacyPolicy#privacy" style="text-decoration:none;"><font size=4 color="white">
・プライバシーポリシー
</font></a>
</div>
</footer>

</body>
</html>
