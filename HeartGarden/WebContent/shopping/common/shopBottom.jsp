<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>푸터 페이지</title>
<style>
/* 하단 푸터 */
footer { font-size: 0.7em; color: gray;}
footer hr { width: 100%; color: lightgray;}
footer a { text-decoration: none; color: gray;}
footer span { font-size: 0.5em;}
.b1-1, .b1-2, .b1-3, .b1-4 { float: left; width: 20%; padding: 2.5%;}
.b1-3 div { float: left; width: 20%; padding: 2%; text-align: center;}

.bottom2 ul { list-type: none;}
.bottom2 ul li { display: inline-block; float: left; width: 100px; text-align: center; 
font-size: 0.8em; padding: 10px; border: 1px solid lightgray; margin-bottom: 30px;}
</style>
</head>
<body>
<footer>
	<hr>
	<div class="bottom1">
		<div class="b1-1">
			<p>CS Center</p>
			<p><img src="../../imageFile/phone.png" width="32"> 1500-5060</p>
			<p>
			OPEN AM 11:00 ~ PM 05:00<br>
			LUNCH PM 12:00 ~ PM 01:00<br>
			CLOSE SAT/SUN/HOLIDAY
			</p>
		</div>
		<div class="b1-2">
			<p>BANK INFO</p>
			<p>
			농협 351-1080-2690-88<br>
			국민 061700-04-235005<br>
			예금주 정성가든<br>
			</p>
			<p><a href=""><img src="../../imageFile/bank.png" width="32"> 인터넷 뱅킹</a></p>
		</div>
		<div class="b1-3">
			<p>STORE GUIDE</p>
			<p>
			<div><a href=""><img src="../../imageFile/notice.png" width="30"><br>NOTICE</a></div>
			<div><a href=""><img src="../../imageFile/order.png" width="30"><br>ORDER</a></div>
			<div><a href=""><img src="../../imageFile/review.png" width="30"><br>REVIEW</a></div>
			<div><a href=""><img src="../../imageFile/question.png" width="30"><br>QnA</a></div>
			</p>
		</div>
		<div class="b1-4">
			<p>RETURN AND EXCHANGE</p>
			<p>
				<a href=""><img src="../../imageFile/delivery.png" width="30">택배/배송</a><br>
				<span>택배: CJ 대한통운, 1588-1255<br>(월~금 08:00~18:00/토 09:00~13:00/매주 일요일 휴무)</span>
			</p>
			<p>
				<a href=""><img src="../../imageFile/exchange.png" width="30">교환/반품</a><br>
				<span>경기도 고양시 덕양구 통이로 1154번길 23-6 정성가든</span>
			</p>
		</div>
	</div>
</footer>
</body>
</html>