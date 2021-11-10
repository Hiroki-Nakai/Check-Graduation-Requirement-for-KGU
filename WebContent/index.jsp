<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>関西学院大学 卒業判定サイト ファイルアップロード画面</title>
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
<div style="text-align:center">
<h2>成績通知書(PDFファイル)をアップロード</h2>

<form action="./CheckGrades" method="post" enctype="multipart/form-data">
<p><font size=4>
<input type="file" accept=".pdf" name="submit_pdf" class="btn">
<button type="submit" class="btn2">判定結果を見る</button>
</font></p>
</form>

<br><br>
※現在対応中の学部は、
「商学部」・「経済学部」・「社会学部」・「国際学部」・「法学部」・「文学部」・「人間福祉学部」・「教育学部」・「理工学部」
です。<br>
※本サイトは大学院の成績通知書には対応していません。<br>
※卒業条件の詳細は、各学部の「履修心得」・「教育課程表」をご覧ください。
</div>
</main>

<!--
※本サイトの不備による卒業可否の誤判定が生じる場合がございます。<br>
※その際の責任は一切負いかねますので，予めご了承ください。<br>
※最終的な卒業可否の判断は各個人で行ってください。<br>
-->

<footer>
<div style="text-align:center">
<a href="./PrivacyPolicy" style="text-decoration:none;"><font size=4 color="white">
プライバシーポリシー
</font>
</a>
</div>
</footer>

</body>
</html>
