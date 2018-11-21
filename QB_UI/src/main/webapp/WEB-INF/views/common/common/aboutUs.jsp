<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
#map {
 height: 400px;
 width: 100%;
}

.flex-container {
 display: -webkit-flex;
 display: flex;
 -webkit-flex-flow: row wrap;
 flex-flow: row wrap;
 text-align: center;
}

.flex-container>* {
 padding: 15px;
 -webkit-flex: 1 100%;
 flex: 1 100%;
}

.article {
 text-align: left;
}

header {
 background: black;
 color: white;
}

footer {
 background: #aaa;
 color: white;
}

.nav {
 background: none;
}

.nav ul {
 list-style-type: none;
 padding: 0;
}

.nav ul a {
 text-decoration: none;
}

@media all and (min-width: 768px) {
 .nav {
  -webkit-flex: 1 auto;
  flex: 1 auto;
  -webkit-order: 1;
  order: 1;
 }
 .article {
  -webkit-flex: 5 0px;
  flex: 5 0px;
  -webkit-order: 2;
  order: 2;
 }
 footer {
  -webkit-order: 3;
  order: 3;
 }
}

.button {
 background-color: #4CAF50; /* Green */
 border: none;
 color: white;
 text-align: center;
 text-decoration: none;
 display: inline-block;
 font-size: 22px;
 margin: 4px 2px;
 -webkit-transition-duration: 0.4s; /* Safari */
 transition-duration: 0.4s;
 cursor: pointer;
 width: 100%;
 height: 80px;
}

.button5 {
 background-color: white;
 color: black;
 border: 2px solid #555555;
}

.button5:hover {
 background-color: #555555;
 color: white;
}
.img{
width:100px; 
border-radius:50px;
}
.sub1{
   width:39px;
   border-radius:10px;
   font-size: 9px;
   height:15px;
   background: #A50000;
   color:white;
}
.sub2{
   width:15px;
   border-radius:50px;
   font-size: 9px;
   height:15px;
   background: #2F9D27;
   color:white;
}
.bus{
color:#0169ce;
}
</style>
<section id="main-content">
	<section class="wrapper site-min-height">
		<div class="col-lg-12 mt">
			<div class="row content-panel">
				<div class="panel-heading">
					<header class="panel-heading wht-bg">
						<h4 class="gen-case">
							<i class="fa fa-angle-right"></i>&nbsp;&nbsp;&nbsp;오시는 길
						</h4>
					</header>
				</div>
				<div style="margin-left:50px;">
					<h4 style="margin-left:0px;">비트캠프 서초점</h4>
					<br>
					<p>주소 : 서울시 서초구 서초동 1327-15 비트아카데미빌딩 404호</p>
					<p>전화 : 02-3486-9600</p>
				</div>
				<article class="article" style="margin-left:35px; padding-top:20px;padding-bottom:150px;">
					<!-- 구글 맵 출력 태그 -->
					<div id="map" style="width:760px; height:350px;" ></div>
					<p>강남역5번 출구로 나와 직진 → 삼성화재 건물(빨간색건물) 에서 우회전 후 직진</p>
					<hr style="width:760px; margin-left:0px;">
					<p style="font-weight: bold;display:inline-block;">주변 지하철역</p> &nbsp;&nbsp;<p style="display:inline-block;"class="sub1">신분당선</p><p style="display:inline-block; color:#0169ce;">신분당선(강남)</p>
					&nbsp;&nbsp;<p style="display:inline-block;"class="sub2">&nbsp;&nbsp;2</p><p style="display:inline-block; color:#0169ce;">2호선강(강남)</p>
					<div>
					<p style="font-weight: bold;display:inline-block;">주변 버스정류장</p> &nbsp;&nbsp;<p class="bus"style="display:inline-block;">강남역티월드 (22-654)  강남역도시에빛 (22-600)  신분당선강남역 (22-010)</p>
					</div>  <!-- 구글맵 API 키 -->
   <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAsXbEQ9aeugj_K1kmEVToG1-9ZZE-E9Js"></script>
  </article> 
			</div>
		</div>
	</section>
</section>
<script>
 function initMap() { /*구글맵 실행 함수*/
  var uluru = { /*맵 초기 경도 위도 값 설정*/
   lat : 37.494572,
   lng : 127.027522
  }; 
  var map = new google.maps.Map(document.getElementById('map'), { /*구글맵 <div id="map">에 생성*/
   zoom : 6, /*맵 확대 값 초기화*/
   center : uluru  /*설정한 위도 경도로 위치 설정*/
  
  });
 }
 window.onload = function() {

  var image = new google.maps.MarkerImage(new google.maps.Size(10, 10)); /*마크 이미지 생성 및 크기 설정*/

   var uluru = {
    lat : 37.494572,
    lng : 127.027522
   };
   var map = new google.maps.Map(document.getElementById('map'), {
    zoom : 17,
    center : uluru
   });  
   var marker = new google.maps.Marker({/*마커 생성*/
    position : uluru, /*마커 위치 지정*/
    map : map, /*구글맵*/
    icon : image, /*마커 이미지 */
    title : '서초점' /*마커 title*/
   });
   var content = "비트캠프_서초점<br/><br/>Tel: 010-1234-1234";
   var infowindow = new google.maps.InfoWindow({
    content : content
   });
   google.maps.event.addListener(marker, "click", function() {
    infowindow.open(map, marker);
   });
   /*마커 클릭 시 생성되는 말풍선 실행함수*/

  
 }
</script>