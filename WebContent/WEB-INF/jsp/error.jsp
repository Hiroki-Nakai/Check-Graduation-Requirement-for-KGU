<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String undergraduate = (String)request.getAttribute("undergraduate");
%>

<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>関西学院大学 卒業判定システム 再アップロード要求画面</title>
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
	out.println( "<font color=\"red\">" + undergraduate + "学部" + "</font>" + "の卒業判定システムは現在開発中です");
}
%>
</h2>

<br>
※現在対応中の学部は、
「商学部」・「経済学部」・「社会学部」・「国際学部」・「法学部」・「文学部」・「人間福祉学部」・「教育学部」・「理工学部」
です。<br>
※本サイトは大学院の成績通知書には対応していません。
</div>
</main>

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
