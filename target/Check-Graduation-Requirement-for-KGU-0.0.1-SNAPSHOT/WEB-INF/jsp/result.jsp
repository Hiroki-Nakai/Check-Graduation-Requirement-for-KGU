<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.stream.Stream" %>
<%@ page import="java.util.Collections" %>

<%
ArrayList<String> textANDposition = (ArrayList<String>)request.getAttribute("text_pos");
String undergraduate = (String)request.getAttribute("undergraduate");
String program = (String)request.getAttribute("program");
String course = (String)request.getAttribute("course");
String[] languages = (String[])request.getAttribute("languages");


ArrayList<String> risyu = new ArrayList<String>(); //履修状況を格納する
ArrayList<Integer> risyu_pos = new ArrayList<Integer>(); //履修科目のPDF上でのx座標を格納

int i = 0;
int skip = 1; //科目がスペースで区切られている場合の分岐のため
int next = 3; //科目がスペースで区切られている場合の必要単位の有無を考慮
while (i < textANDposition.size()){
	String[] split = textANDposition.get(i).split("%");
	String split_text = split[0];
	String text_position = split[1];
    if (!(split_text.matches("[+-]?\\d*(\\.\\d+)?"))){
    	if (i+1 < textANDposition.size()-1){
    		String[] split_adj = textANDposition.get(i+1).split("%");
    		if (!(split_adj[0].matches("[+-]?\\d*(\\.\\d+)?"))){
    			split_text = split_text + "-" + split_adj[0];
    			skip = 2;
    			next = 4;
    		}
    	}
    	risyu.add(split_text);
    	// string型の座標をダブル型で受け取り，整数型に変換して，配列に追加
    	risyu_pos.add( (int)Double.parseDouble(text_position) );

    	if (i+next < textANDposition.size()){
    		String[] split_next = textANDposition.get(i+next).split("%");
    		if (!(split_next[0].matches("[+-]?\\d*(\\.\\d+)?"))){
    			risyu.add("--");
    		}
    	}
    	else{
    		risyu.add("--");
    	}
    }
    else{
    	risyu.add(split_text);
    }
    i += skip;
    skip = 1;
    next = 3;
}

//座標の重複なし配列を作る
ArrayList<Integer> pos_uniq = new ArrayList<Integer>();
for (int jj=0; jj<risyu_pos.size(); jj++){
	int pos = risyu_pos.get(jj);
	if ( !pos_uniq.contains(pos) ){
		pos_uniq.add(pos);
	}
};
Collections.sort(pos_uniq);

%>


<%
//risyu(履修状況)を4つの配列に変換する
ArrayList<String> subjects = new ArrayList<String>();
ArrayList<String> need_credit = new ArrayList<String>();
ArrayList<Double> complete = new ArrayList<Double>();
ArrayList<Double> taking = new ArrayList<Double>();

for (int j=0; j < risyu.size(); j+=4){
	subjects.add( risyu.get(j) );
	need_credit.add( risyu.get(j+1) );
	complete.add( Double.parseDouble(risyu.get(j+2)) );
	taking.add( Double.parseDouble(risyu.get(j+3)) );
}

%>

<%
//科目の階層情報を取得しよう
//parentに親のインデックス（何行目か）を格納
int[] parent = new int[risyu_pos.size()];
//rootにその科目が子有無を格納（子がいれば１，いなければ０）
int[] root = new int[risyu_pos.size()];

for (int t=2; t < parent.length; t++){
	if ( (int)risyu_pos.get(t) > (int)risyu_pos.get(t-1) ){
		parent[t] = t-1;
	}
	else if ( (int)risyu_pos.get(t) == (int)risyu_pos.get(t-1) ){
		parent[t] = parent[t-1];
	}
	else{
		for( int bt=t-1; bt>=0; bt-=1){
			if( (int)risyu_pos.get(t) == (int)risyu_pos.get(bt) ){
				parent[t] = parent[bt];
				break;
			}
		}
	}

	if ( t != parent.length-1 ){
		if ( (int)risyu_pos.get(t) >= (int)risyu_pos.get(t+1) ){
			root[t] = 1;
		}
	}
	else{
		root[t] = 1;
	}
}

/*for (int j = 0; j < subjects.size(); j++){
	if ( root[j]==1 ){
		System.out.println(subjects.get(j));
	}
}*/

%>

<%
//言語など，子の必要単位数の合計が親の必要単位数を超えていないか確認

//まず必要単位数を格納した配列を作成（--のところは0で置き換え）
int[] necessary = new int[need_credit.size()];
for (int j = 0; j < need_credit.size(); j++){
	if ( need_credit.get(j).equals("--") ){
		necessary[j] = 0;
	}
	else{
		int n = (int)Double.parseDouble(need_credit.get(j));
		necessary[j] = n;
	}
}


//親ノードの必要単位数が超えていたらそのインデックスをoverに格納
ArrayList<Integer> over = new ArrayList<Integer>();
for (int p=1; p<parent.length; p++){
	int count = 0;
	for (int q=1; q<parent.length; q++){
		if (parent[q] == p){
			count += necessary[q];
		}
	}
	if (count > necessary[p]){
		//商学部のための分岐（総合分野の必要単位数が書かれていないから）
		if (necessary[p]==0){
			//System.out.println("nes: " + necessary[p] + " p: " + p);
			//System.out.println("count: " + count);
			need_credit.set(p, Integer.valueOf(count).toString());
		}
		else{
			//System.out.println("over");
			over.add(p);
		}
	}
}
%>


<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>関西学院大学 卒業判定サイト 判定結果</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/style.css">
</head>
<body>
<div class="container">

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
<h2>判定結果</h2>
</div>

<!-- <table border=0> -->
<table class="table-c">
<tr>

<td valign="top">
	<table border=1>
	<tr><th bgcolor="lightgrey">学部</th><td><%=undergraduate %>学部</td></tr>
	<tr><th bgcolor="lightgrey">学科</th><td><%=program %></td></tr>
	<tr><th bgcolor="lightgrey">専攻・コース</th><td><%=course %></td></tr>
	<tr><th bgcolor="lightgrey">語学コード１</th><td><%=languages[0] %></td></tr>
	<tr><th bgcolor="lightgrey">語学コード２</th>
	<td>
	<%
	if(languages.length!=1){
		out.println(languages[1]);
	}
	else{
		out.println("");
	}
	%>
	</td></tr>
	</table>
</td>

<td valign="top">
	<!-- <table border=0> -->
	<table>
	<tr>　</tr>
	</table>
</td>


<td valign="top">
<div class="sc">
	<table border=1>
	<!--
	<tr bgcolor="lightgrey">
	<th rowspan="2" class="fixed01">　</th><th rowspan="2" class="fixed01">科目の分野・系列</th><th rowspan="2" class="fixed01">必要単位</th>
	<th colspan="2" class="fixed01">単位集計</th>
	</tr>
	<tr bgcolor="lightgrey">
	<th class="fixed02">修得</th><th class="fixed02">履修</th>
	</tr>
	-->
	<tr bgcolor="lightgrey">
	<th class="fixed01">　</th>
	<th class="fixed01">科目の分野・系列</th>
	<th class="fixed01">必要単位</th>
	<th class="fixed01">修得</th>
	<th class="fixed01">履修</th>
	</tr>


	<%
	//あとなん単位必要かを出力させるための配列の作成
	//足りていない単位数を格納
	//ArrayList<Double> lack_credit = new ArrayList<Double>();
	//足りていない行数を格納
	ArrayList<Integer> lack_subjects = new ArrayList<Integer>();
	//現在履修中の科目があるか判定
	boolean now_risyu = false;

	for (int j = 0; j < subjects.size(); j++){
		//単位足りてるか判定
		//必要単位数が書かれている行かどうか
		if ( !(need_credit.get(j).equals("--")) ){
			if ( over.contains(parent[j]) ){
				for (String lan: languages){
					if( lan.contains(subjects.get(j)) ){
						if ( Double.parseDouble(need_credit.get(j)) > complete.get(j) ){
							if ( Double.parseDouble(need_credit.get(j)) > (complete.get(j) + taking.get(j)) ){
								%><tr bgcolor="lightpink"><%
								double lack = Double.parseDouble(need_credit.get(j)) - (complete.get(j) + taking.get(j));
								//lack_credit.add(lack);
								lack_subjects.add(j);
							}
							else{
								%><tr bgcolor="lightblue"><%
								now_risyu = true;
							}
						}
						else{
							%><tr><%
						}
						break;
					}
				}
			}
			else{
				if ( Double.parseDouble(need_credit.get(j)) > complete.get(j) ){
					if ( Double.parseDouble(need_credit.get(j)) > (complete.get(j) + taking.get(j)) ){
						%><tr bgcolor="lightpink"><%
						double lack = Double.parseDouble(need_credit.get(j)) - (complete.get(j) + taking.get(j));
						//lack_credit.add(lack);
						lack_subjects.add(j);
					}
					else{
						%><tr bgcolor="lightblue"><%
						now_risyu = true;
					}
				}
				else{
					%><tr><%
				}
			}
		}
		%>
		<th bgcolor="lightgrey"><%= j+1%></th>
		<td>
		<%
		for (int jj=0; jj<pos_uniq.indexOf(risyu_pos.get(j)); jj++){
			out.println("　");
		}
		out.println(subjects.get(j));
		%>
		</td>

		<td><%= need_credit.get(j)%></td>
		<td><%= complete.get(j)%></td>
		<td><%= taking.get(j)%></td>
		</tr><%
	}
	%>

	</table>
</div>
</td>


<td valign="top">
	<!-- <table border=0> -->
	<table>
	<tr>　</tr>
	</table>
</td>

<td valign="top">
	<!-- 凡例の表 -->
	<table border=1>
	<tr> <th bgcolor="lightpink">必要単位数が足りていない</th> </tr>
	<tr> <th bgcolor="lightblue">履修中の単位が取得できれば，必要単位数を満たす</th> </tr>
	</table>

	<br>

	<font size=4>
	<b>
	<%
	//あと取得すべき科目と単位を表示
	if (lack_subjects.size() == 0){
		if (now_risyu){
			out.println("現在履修中の科目の単位を取得すれば，卒業に必要な単位数を満たします" + "<br>");
		}
		else{
			out.println("既に卒業に必要な単位数を満たしています" + "<br>");
		}
	}
	else{
		for (int j=lack_subjects.size()-1; j>=0; j--){
			int ind = lack_subjects.get(j);
			double lack = necessary[ind] - (complete.get(ind) + taking.get(ind));
			if ( lack > 0 ){
				out.println( "・" + (ind+1) + " 行目の " );
				out.println( "<font color=\"blue\">" + subjects.get(ind) + "</font>" +  " が ");
				out.println( "<font color=\"red\">" + lack + "</font>" + " 単位不足しています" + "<br>");
				while(parent[ind] != 0){
					int par = parent[ind];
					ind = par;
					double add = taking.get(par) + lack;
					taking.set(par, add);
				}
			}
		}
	}
	%>
	</b></font>

	<br>
	※卒業条件の詳細は、各学部の「履修心得」・「教育課程表」をご覧ください。<br>
	※判定結果に誤りがある場合がありますので，最終的な卒業可否の判断は各個人で行ってください。<br>
</td>

</tr>
</table>
<br>

</main>

<footer>
<div style="text-align:center">
<a href="./PrivacyPolicy" style="text-decoration:none;"><font size=4 color="white">
プライバシーポリシー
</font>
</a>
</div>
</footer>

</div>
</body>
</html>
