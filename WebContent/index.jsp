<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-WEXM79GB02"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-WEXM79GB02');
</script>

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
<font size=4>
<input type="file" accept=".pdf" name="submit_pdf" class="btn">
</font>

<br>
<br>

<h3>
※利用規約・プライバシーポリシーにご同意の上、判定結果をご覧ください
</h3>
<font size=4>
<a href="./Policy#use">
利用規約はこちら
</a><br>
<a href="./Policy#privacy">
プライバシーポリシーはこちら
</a>
</font>
<br><br>

<button type="submit" class="btn2">
<font size=4>同意して判定結果を見る</font></button>
<br><br>
</form>
</div>
</main>


<footer>
<div style="text-align:center">
<a href="./Policy#use" style="text-decoration:none;"><font size=4 color="white">
・利用規約
</font></a>
　
<a href="./Policy#privacy" style="text-decoration:none;"><font size=4 color="white">
・プライバシーポリシー
</font></a>
</div>
</footer>

</body>
</html>
