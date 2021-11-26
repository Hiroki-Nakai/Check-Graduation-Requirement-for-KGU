<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String undergraduate = (String)request.getAttribute("undergraduate");
%>

<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>関西学院大学 卒業判定サイト 再アップロード要求画面</title>
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
<h2>
<%
if ( undergraduate ==null ){
	out.println("成績通知書のpdfファイルをアップロードしてください");
}
else{
	out.println( "本サイトは、" + "<font color=\"red\">" + undergraduate + "学部" + "</font>" + "の成績通知書には対応していません。");
}
%>
</h2>

<br>
※本サイトは、総合政策学部、大学院、留学生の成績通知書には対応していません。<br>
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
