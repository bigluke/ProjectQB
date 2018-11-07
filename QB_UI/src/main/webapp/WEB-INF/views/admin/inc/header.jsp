<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--header start-->
<header class="header black-bg">
    
    <!--logo start-->
    <a href="adminMain.do" class="logo"> <img src="${pageContext.request.contextPath}/img/logo1.png"
                                alt="QB_logo" class="QB_logo" style="height:45px;"/></a>
                        <!-- 로고 후보:logo1.png // logo22.png // logo 33.png 각각 테스트 해보고 마음에 드는걸로 결정.
                            다른 아이디어 (색깔 등등) 있으면 적극 수렴. -->
    <!--logo end-->

    <div class="top-menu">
        <ul class="nav pull-right top-menu">
            <!-- 정원 -->
            <div class="nav notify-row" id="top_menu">
                <ul class="nav top-menu">
                    <li>
                    <span id="className"></span>
                    <span id="memberName"></span><span>(${pageContext.request.userPrincipal.name})</span>
                    님 환영합니다.&nbsp;&nbsp;
                    </li>
                    <li id="header_inbox_bar">
                    <a href="${pageContext.request.contextPath}/admin/myMessage.do"> 
                    <i class="fa fa-envelope-o"></i>
                    <span class="badge bg-theme" id="message"style="background-color:red;"></span>
                    </a></li>
                    <li id="header_inbox_bar"><a href="${pageContext.request.contextPath}/admin/myPage.do"> 
                    <i class="fa fa-user"></i>
                    </a></li>
                    <!-- 드롭 -->
                              <li id="header_inbox_bar" class="dropdown">
            <a data-toggle="dropdown" class="dropdown-toggle" href="index.html#">
              <i class="fa fa-envelope-o"></i>
              <span class="badge bg-theme" id="message2"style="background-color:red;" ></span>
              </a>
            <ul class="dropdown-menu extended inbox" id="minji">
                 <div class="notify-arrow notify-arrow-green"></div>
              <li>
                <p class="green">You have new messages</p>
              </li>
              <%-- <li>
                <a href="${pageContext.request.contextPath}/admin/myMessage.do">
                  <span class="subject">
                  <span class="from"></span>
                  <span class="time"></span>
                  </span>
                  <span class="message" id="headermessagecontent">
                  </span>
                  </a>
              </li> --%>
              <li>
                <a href="${pageContext.request.contextPath}/admin/myMessage.do">모든 쪽지 보기</a>
              </li>
            </ul>
          </li>
               <!-- 드롭ㅡㅌ -->     
                    
                </ul>
            </div>
            <li><a class="logout" href="${pageContext.request.contextPath}/logout">Logout</a></li>
            <!--  -->
        </ul>
    </div>
</header>
<!--header end-->

<script type="text/javascript">
    
	$(document).ready(function(){
		
		
		$.ajax({
			url:"../common/memberCheck.do",
			type:"get",
			success:function(data){
				/* $('#className').text(data[0].class_name); */
				$('#memberName').text(data[0].member_name);
			},
			error:function(xml){
				
			}
		});
		
		$.ajax({
			url:"headerMessage.do",
			type:"get",
			success:function(data){
				for(var i = 0; i <data.length;i++){
					if(data[i].message_check==0){
						console.log(data[i].message_content);
						$('#minji').children().eq(1).append("<li><a href='${pageContext.request.contextPath}/admin/myMessage.do'><span class='subject'><span class='from'></span><span class='time'></span><span class='message' id='headermessagecontent'>"+data[i].message_content+"</span></a></li>");
		             
					}
						
				}
				
				 
			},
			err:function(err){
				console.log('err입니다');
			}
			
		});
	});


	</script>

