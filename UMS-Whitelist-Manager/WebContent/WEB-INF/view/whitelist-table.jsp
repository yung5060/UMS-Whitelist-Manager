<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<!DOCTYPE html>
<html style="overflow-y: scroll;">
<head>
<meta charset="EUC-KR">
<title>UMS 화이트리스트 관리자</title>
</head>
<style>
h2 {
	text-align: center;
}

#outter {
	display: block;
	width: 70%;
	margin: auto;
	background: #EAECEE;
	padding: 20px 40px;
	margin-top: 50px;
}

a {
	text-decoration: none;
}

table, tr, td {
	border: none;
	border-collapse: collapse;
	text-align: center;
	cursor: pointer;
}

tr.colored:nth-child(even) {
	background: #D5D8DC;
	color: #000;
}

tr.colored:nth-child(odd) {
	background: #BFC9CA;
	color: #000;
}

tr.colored:hover {
	background: #F2F3F4;
	font-weight: bold;
}

.btn1 {
	padding: 5px 10px;
	background: #154360;
	border: 0;
	outline: none;
	cursor: pointer;
	font-size: 14px;
	font-weight: 500;
	color: #FFFFFF;
	border-radius: 5px;
	transition: 0.3s;
}

.btn1:hover {
	background: #A9CCE3;
}

.btn1:focus {
	background: #A9CCE3;
}

.del-btn1 {
	padding: 5px 10px;
	background: #CB4335;
	border: 0;
	outline: none;
	cursor: pointer;
	font-size: 14px;
	font-weight: 500;
	color: #FFFFFF;
	border-radius: 5px;
	transition: 0.3s;
}

.del-btn1:hover {
	background: #F1948A;
}

.del-btn1:focus {
	background: #F1948A;
}

.btn-open-popup {
	padding: 5px 10px;
	background: #154360;
	border: 0;
	outline: none;
	cursor: pointer;
	font-size: 14px;
	font-weight: 500;
	color: #FFFFFF;
	border-radius: 5px;
	transition: 0.3s;
}

.btn-open-popup:hover {
	background: #A9CCE3;
}

.btn-open-popup:focus {
	background: #A9CCE3;
}

.modal {
	position: absolute;
	top: 0;
	left: 0;
	margin: 0px;
	width: 100%;
	height: 100%;
	display: none;
	background-color: rgba(0, 0, 0, 0.4);
}

.modal.show {
	display: block;
}

.modal_body {
	position: absolute;
	top: 40%;
	left: 50%;
	width: 400px;
	height: 400px;
	padding: 40px;
	text-align: center;
	background-color: rgb(255, 255, 255);
	border-radius: 5px;
	box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
	transform: translateX(-50%) translateY(-50%);
}

textarea {
	width: 100%;
	resize: none;
}
</style>

<link rel="icon" type="image/png"
	href="<c:url value= '/img/kbank.png' />" />

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" />
<body>
	<h2 style="margin-top: 30px; cursor: pointer;" onclick="titleLink()">UMS 화이트리스트 관리자</h2>

	<div class="modal">
		<div class="modal_body">
			<s:form modelAttribute="addByTextDto" action="saveByText">
				<h4 style="margin-top: -25px;">UMS 화이트리스트 추가</h4>
				<s:textarea style="height: 286px; margin-top: 10px;"
					class="form-control" path="phoneNumbers"
					placeholder="010XXXX0000
010XXXX0000
0100000XXXX
.
.
." />
				<input class="btn1" style="margin-top: 13px;" type="submit"
					value="저장하기" />
			</s:form>
		</div>
	</div>

	<div class="modal" id="modify_modal" onclick="rowExit()">
		<div class="modal_body" style="height: 200px;">
			<p class="h4" id="modal_phone_number">
				<s:form modelAttribute="whitelist" action="modifyProcess">
					<s:hidden path="CUST_INFO" value="" id="modal_cust_info" />
					<s:checkbox path="CHNL_DV_CD" value="S" />SMS&nbsp;&nbsp;
					<s:checkbox path="CHNL_DV_CD" value="L" />LMS&nbsp;&nbsp;
					<s:checkbox path="CHNL_DV_CD" value="M" />MMS&nbsp;&nbsp;
					<s:checkbox path="CHNL_DV_CD" value="K" />KKO<br>
					<input style="margin-top: 10px;" class="btn1" type="submit"
						value="저장하기" />
				</s:form>
			<button style="margin-top: 5px;" class="del-btn1" onclick="deleteLink()">삭제하기</button>
		</div>
	</div>

	<div id="outter">
		<button class="btn-open-popup">추가하기</button>
		<form action="<c:url value="list" />">
			<!-- <input class="form-control" id="ex3" type="text" name="searchNumber" placeholder="전화번호를 입력하세요" />
			<button class="btn1">검색하기</button>  -->
			<div class="input-group mb-3" style="margin-top: 10px;">
				<input type="text" name="searchNumber" class="form-control"
					placeholder="전화번호를 입력하세요" aria-describedby="basic-addon2" id="searchNum">
				<div class="input-group-append">
					<button class="btn btn-outline-secondary" type="button" onclick="changeSearchNum()">검색하기</button>
				</div>
			</div>
		</form>

		<!-- 옵션선택 끝 -->
		<table class="table" id="whitelistTable">
			<tr>
				<td>SMS</td>
				<td>LMS</td>
				<td>MMS</td>
				<td>KKO</td>
				<td>전화번호</td>
				<td>생성일</td>
				<div style="float: right;">
					<select id="cntPerPage" name="sel" onchange="selChange()">
						<option value="5">
							<c:if test="${paging.cntPerPage == 5}">selected</c:if>>5줄
							보기</option>
						<option value="10">
							<c:if test="${paging.cntPerPage == 10}">selected</c:if>>10줄
							보기</option>
						<option value="15">
							<c:if test="${paging.cntPerPage == 15}">selected</c:if>>15줄
							보기</option>
						<option value="20">
							<c:if test="${paging.cntPerPage == 20}">selected</c:if>>20줄
							보기</option>
					</select>
				</div>
			</tr>
			<c:forEach items="${viewAll}" var="w" varStatus="status">

				<tr class="colored">
					<td><c:choose>
							<c:when test="${fn:contains(w.CHNL_DV_CD, 'S')}">&#128504;</c:when>
							<c:otherwise>&nbsp;</c:otherwise>
						</c:choose></td>
					<td><c:choose>
							<c:when test="${fn:contains(w.CHNL_DV_CD, 'L')}">&#128504;</c:when>
							<c:otherwise>&nbsp;</c:otherwise>
						</c:choose></td>
					<td><c:choose>
							<c:when test="${fn:contains(w.CHNL_DV_CD, 'M')}">&#128504;</c:when>
							<c:otherwise>&nbsp;</c:otherwise>
						</c:choose></td>
					<td><c:choose>
							<c:when test="${fn:contains(w.CHNL_DV_CD, 'K')}">&#128504;</c:when>
							<c:otherwise>&nbsp;</c:otherwise>
						</c:choose></td>
					<td style="width: 300px;">
						<input type="hidden" value="${w.encrypted_CUST_INFO}" /> 
						<input type="hidden" value="${w.CHNL_DV_CD}" />
						${fn:substring(w.CUST_INFO,0,3) }-****-${fn:substring(w.CUST_INFO,7,11) }
					</td>
					<td style="width: 300px;">${w.PPRT_DTM}</td>
				</tr>
			</c:forEach>
		</table>

		<div style="display: block; text-align: center;">
			<c:if test="${empty paging.searchNumber }">
				<c:if test="${paging.startPage != 1 }">
					<a
						href="list?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
				</c:if>
				<c:forEach begin="${paging.startPage }" end="${paging.endPage }"
					var="p">
					<c:choose>
						<c:when test="${p == paging.nowPage }">
							<b>${p }</b>
						</c:when>
						<c:when test="${p != paging.nowPage }">
							<a href="list?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
						</c:when>
					</c:choose>
				</c:forEach>
				<c:if test="${paging.endPage != paging.lastPage}">
					<a
						href="list?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
				</c:if>
			</c:if>
			<c:if test="${not empty paging.searchNumber}">
				<c:if test="${paging.startPage != 1 }">
					<a
						href="list?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&searchNumber=${paging.searchNumber}">&lt;</a>
				</c:if>
				<c:forEach begin="${paging.startPage }" end="${paging.endPage }"
					var="p">
					<c:choose>
						<c:when test="${p == paging.nowPage }">
							<b>${p }</b>
						</c:when>
						<c:when test="${p != paging.nowPage }">
							<a
								href="list?nowPage=${p }&cntPerPage=${paging.cntPerPage}&searchNumber=${paging.searchNumber}">${p }</a>
						</c:when>
					</c:choose>
				</c:forEach>
				<c:if test="${paging.endPage != paging.lastPage}">
					<a
						href="list?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&searchNumber=${paging.searchNumber}">&gt;</a>
				</c:if>
			</c:if>
		</div>
	</div>
</body>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href = "list?nowPage=${paging.nowPage}&cntPerPage=" + sel;
	}
</script>
<script type="text/javascript">
	var deleteAddress = "";
	
	function titleLink() {
		window.location.href = 'list';
	}
	
	
	function deleteLink() {
		if(!(confirm('해당 기록을 삭제하시겠습니까?'))) {
			return false;
		} else {
			location.href = deleteAddress;
		}
		
	}
</script>
<script type="text/javascript">
      const body = document.querySelector('body');
      const modal = document.querySelector('.modal');
      const btnOpenPopup = document.querySelector('.btn-open-popup');
      
      function rowClicked() {
 	   		var table = document.getElementById('whitelistTable');
 	   		var rowList = table.rows;
 	   		
 	   		for (i=1; i<rowList.length; i++) {
 	   			
 	   			var row = rowList[i];
 	   			
 	   			row.onclick = function() {
 	   				return function() {
 	   					
 	   					var encrypted_custInfo = this.cells[4].getElementsByTagName('input')[0].value;
 	   					var phone = this.cells[4].innerText;
 	   					var codes = this.cells[4].getElementsByTagName('input')[1].value;
 	   					var searchNumber = "";
 	   					var urlParams = new URLSearchParams(window.location.search);
 	   					deleteAddress = "deleteProcess?custInfo=" + encrypted_custInfo;
 	   					var codelist = codes.split(",");
 	   					var $checkboxes = $("input[type=checkbox]");
 	   	   	   			$checkboxes.each(function(idx, element){
 	   	   		   		if(codelist.indexOf(element.value) != -1) {
 	   	   			   		element.setAttribute("checked", "checked");
 	   	   		   		} else {
 	   	   			   		element.removeAttribute("checked");
 	   	   		   		}
 	   	   	   			});
 	   	   	   			
 	   	   	   			document.getElementById("modal_cust_info").value = encrypted_custInfo;
 	   	   	   			document.getElementById("modal_phone_number").innerHTML = phone;
 	   	   	   			
		 	   	   	   	const modal2 = document.getElementById('modify_modal');
		 	     		modal2.classList.toggle('show');
		
		 	           if (modal2.classList.contains('show')) {
		 	             body.style.overflow = 'hidden';
		 	           }
 	   				};
 	   			}(row);
 	   		}
 	   	}
      window.onload=rowClicked();
      
      function rowExit() {
    	  const modal2 = document.getElementById('modify_modal');
    	  if (event.target === modal2) {
    		  modal2.classList.toggle('show');

              if (!modal2.classList.contains('show')) {
                body.style.overflow = 'auto';
              }
            }
    	 }

      btnOpenPopup.addEventListener('click', () => {
        modal.classList.toggle('show');

        if (modal.classList.contains('show')) {
          body.style.overflow = 'hidden';
        }
      });
      
      window.onkeyup = function(e) {
    	  const modal2 = document.getElementById('modify_modal');
    		var key = e.keyCode ? e.keyCode : e.which;
    		if (key === 27) {

    	          if (modal.classList.contains('show')) {
    	            modal.classList.toggle('show');
    	          }
    	          
    	          if (modal2.classList.contains('show')) {
    	            modal2.classList.toggle('show');
    	          }
    	        }
    	}

      modal.addEventListener('click', (event) => {
        if (event.target === modal) {
          modal.classList.toggle('show');

          if (!modal.classList.contains('show')) {
            body.style.overflow = 'auto';
          }
        }
      });
</script>

</html>