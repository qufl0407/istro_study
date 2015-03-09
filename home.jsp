<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
    <meta charset="utf-8">
    <TITLE>처음으로 해보는 리스트</TITLE>

    <script src = "http://jashkenas.github.io/underscore/underscore-min.js"></script>
    <script src = "http://code.jquery.com/jquery.min.js"></script>

    <script src = "http://maxcdn.bootstrapcdn.com"></script>
    <script src = "http://jashkenas.github.io/underscore/underscore-min.js"></script>
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" rel="stylesheet" type="text/css" />


    <script>
    	$(document).ready(function() {
	        //select
	        $.post("/test/selectSports", function (list) {
	            data = list;
	            _.each(data, function (obj) {
	                var $tr = $("<tr>"
	                + "<td><input type='checkbox' class='check' value='" + obj.id + "'></td>"
	                + "<td>" + obj.id + "</td>"
	                + "<td>" + obj.sports1 + "</td>"
	                + "<td>" + obj.sports2 + "</td>"
	                + "<td>" + obj.sports3 + "</td>"
	                + "<td>" + obj.sports4 + "</td>"
	                + "</tr>");
	                $tr.appendTo("table[name=table01] tbody");
	            });
	        }, "json");
	        

	        
	        $("button[name=listRender]").click(function (){
	        	$("table[name=table01] tbody tr").remove();
		        $.post("/test/selectSports", function (list) {
		            data = list;
		            _.each(data, function (obj) {
		                var $tr = $("<tr>"
		                + "<td><input type='checkbox' class='check' value='" + obj.id + "'></td>"
		                + "<td>" + obj.id + "</td>"
		                + "<td>" + obj.sports1 + "</td>"
		                + "<td>" + obj.sports2 + "</td>"
		                + "<td>" + obj.sports3 + "</td>"
		                + "<td>" + obj.sports4 + "</td>"
		                + "</tr>");
		                $tr.appendTo("table[name=table01] tbody");
		            });
		        }, "json");
	        });
	
	        
			//리스트 등록
	        $("button[name=REG]").click(function () {
	            $(".REG").toggle('slow');
    			$("button[name=REGCancle]").toggle('slow');
    			BTNToggle();
	        });
			
			
			//insert
	        $("button[name=REGEnd]").click(function () {
	        	if($("input[name=id]").val() == ""){
	        		alert("ID는 필수값입니다.");
	        		$("input[name=id]").focus();
	        	}else{
		            var obj ={};
		            obj["id"] = $("input[name=id]").val();
		            obj["sports1"] = $("input[name=sports1]").val();
		            obj["sports2"] = $("input[name=sports2]").val();
		            obj["sports3"] = $("input[name=sports3]").val();
		            obj["sports4"] = $("input[name=sports4]").val();
		            
		            var inscon = confirm("아래 내용을 저장하시겠습니까?\r\nID : "+obj["id"] 
		            					+"\r\n좋아하는 스포츠1 : " + obj["sports1"]+"\r\n좋아하는 스포츠2 : " 
		            					+ obj["sports2"]+"\r\n좋아하는 스포츠3 : " + obj["sports3"]+"\r\n좋아하는 스포츠4 : " 
		            					+ obj["sports4"]);
		            
		            if(inscon == true){
		            	var insertOk;
					//spring insert
			            $.post("/test/insertSports", obj, function(data){
			            	if(data["retVal"] == 1){
			            		alert("등록되었습니다.");
			            		$("button[name=listRender]").trigger('click');
			            	}else{
			            		alert("등록에 실패하였습니다.");
			            	}
			            });
		            }
		           
		            $(".REG").toggle('slow');
		            BTNToggle();
		            $("button[name=REGCancle]").toggle('slow');
		            $(".devInsertInfo").val("");
	        	}
	        });
			
			
	        $("button[name=REGCancle]").click(function () {
	            $(".REG").toggle('slow');
    			$("button[name=REGCancle]").toggle('slow');
	            BTNToggle();
	            $(".devInsertInfo").val("");
	        });
	
	        
			//수정 버튼 클릭
	        $("button[name=edit]").click(function () {
	        	if($(".check:checked").length == 0){
	    			alert("수정할 목록을 1개이상 체크해주세요.");
	    		}else{
	    			$(":checkbox").attr("disabled", true);
		        	$("button[name=editEnd]").toggle('slow');
		        	$("button[name=editCancle]").toggle('slow');
		        	BTNToggle();
	    			
		            _.each($(".check:checked"), function (obj) {
		                var trParent = $(obj).parent().parent();
		                //var temp1 = $(trParent.children().eq(2)).text();
		                //var temp1 = trParent.children();
		                //var dddd = trParent.children().eq(1);
		                trParent.children().eq(2).html($('<input type=text value=' + $(trParent.children().eq(2)).text()+'>'));
		                trParent.children().eq(3).html($('<input type=text value=' + $(trParent.children().eq(3)).text()+'>'));
		                trParent.children().eq(4).html($('<input type=text value=' + $(trParent.children().eq(4)).text()+'>'));
		                trParent.children().eq(5).html($('<input type=text value=' + $(trParent.children().eq(5)).text()+'>'));
		            });
	    		}
	        });
	
			
			//리스트 수정 후 저장
	        $("button[name=editEnd]").click(function () {

	        	$(":checkbox").attr("disabled", false);
	        	$("button[name=editEnd]").toggle('slow');
	        	$("button[name=editCancle]").toggle('slow');
	        	BTNToggle();
	        	
	            _.each($(".check:checked"), function (obj) {
	                var test = {}
	                var trParent = $(obj).parent().parent();
	                var name =  $(trParent.children().eq(2)).val();
	                var checkboxVal = $(obj).val();
	                var s1 = $(trParent.children().eq(2)).children().val();
	                var s2 = $(trParent.children().eq(3)).children().val();
	                var s3 = $(trParent.children().eq(4)).children().val();
	                var s4 = $(trParent.children().eq(5)).children().val();
	
	                test["id"] = checkboxVal;
	                test["sports1"] = s1;
	                test["sports2"] = s2;
	                test["sports3"] = s3;
	                test["sports4"] = s4;
	                
	                $.post("/test/updateSports", test, function(data){
	                });
	            });
	            $("button[name=listRender]").trigger('click');
	        });
			
			
	        $("button[name=editCancle]").click(function () {
	        	
				$("button[name=listRender]").trigger('click');
				
	        	$("button[name=editEnd]").toggle('slow');
				$("button[name=editCancle]").toggle('slow');
				$(":checkbox").attr("disabled", false);
				BTNToggle();
	        });
			
	        
	        //리스트 삭제
	        $("button[name=listDelete]").click(function () {
	    		if($(".check:checked").length == 0){
	    			alert("삭제할 목록을 1개이상 체크해주세요.");
	    		}else{
	    			var checLen = $(".check:checked").length;
	    			var delcon;
	                delcon = confirm(checLen+"개의 리스트를 삭제하시겠습니까?");
	                if(delcon == true){
	    			//spring delete
	    	        	_.each($(".check:checked"), function (obj) {
	    	                var test = {}
	    	                test["id"] = $(obj).val();
	    	                $.post("/test/deleteSports", test, function(data){
	    	                });
	    	            });
	    	        alert(checLen+"개의 리스트가 삭제되었습니다.");
		            $("button[name=listRender]").trigger('click');
	                }
	    		}
	        });
	        
	        
	        $(".all").click(function () {
	        	
	        	//var chk = $(this).is(":checked");
	        	//var chk = $(".all").is(":checked");
	        	if($(".all").is(":checked")){
	        		$(".check").prop("checked", true);
	        		
	        	}else{
	        		$(".check").prop("checked", false);
	        		
	        	}
	        	
	        });
	        
    	});
    	
    	
    	
        function BTNToggle() {
			$("button[name=listRender]").toggle('slow');
            $("button[name=REG]").toggle('slow');
            $("button[name=edit]").toggle('slow');
			$("button[name=listDelete]").toggle('slow');
        };

        
    </script>

</HEAD>
<BODY>

<div name ="inputArea" class="REG" style="display:none" style="padding:100">
    <div class="form-group">
        <input type="text" class="form-control devInsertInfo" name="id" placeholder="ID (필수)">
    </div>
    <div class ="form-group">
        <input type="text" class="form-control devInsertInfo" name ="sports1" placeholder="좋아하는 스포츠1">
    </div>
    <div class ="form-group">
        <input type="text" class="form-control devInsertInfo" name ="sports2" placeholder="좋아하는 스포츠2">
    </div>
    <div class ="form-group">
        <input type="text" class="form-control devInsertInfo" name ="sports3" placeholder="좋아하는 스포츠3">
    </div>
    <div class ="form-group">
        <input type="text" class="form-control devInsertInfo" name ="sports4" placeholder="좋아하는 스포츠4">
    </div>
    <p>
        <button class="btn btn-sm btn-primary" name="REGEnd"><i class="glyphicon glyphicon-saved"></i>등록완료</button>
        <button class="btn btn-sm btn-primary" name="REGCancle"><i class="glyphicon glyphicon-saved"></i>등록취소</button>
    </p>
</div>

<div name="listArea" class="well">
    <p name="test">
        <button class="btn btn-sm btn-primary" name="listRender"><i class="glyphicon glyphicon-search"></i>조회</button>
        <button class="btn btn-sm btn-primary" name="REG"><i class="glyphicon glyphicon-saved"></i>등록</button>
        <button class="btn btn-sm btn-primary" name="REGCancle" style="display:none"><i class="glyphicon glyphicon-remove"></i>등록취소</button>
        <button class="btn btn-sm btn-primary" name="edit"><i class="glyphicon glyphicon-edit"></i>수정</button>
        <button class="btn btn-sm btn-primary" name="editEnd" style="display:none"><i class="glyphicon glyphicon-edit"></i>수정완료</button>
        <button class="btn btn-sm btn-primary" name="editCancle" style="display:none"><i class="glyphicon glyphicon-remove"></i>수정취소</button>
        <button class="btn btn-sm btn-primary" name="listDelete"><i class="glyphicon glyphicon-trash"></i>삭제</button>
    </p>

    <table name = "table01" class="table table-bordered table-condensed table-hover table-striped">
        <thead align="center">
        <th width=60><input type='checkbox' class='all'>전체</th>
        <th>ID</th>
        <th>좋아하는 스포츠1</th>
        <th>좋아하는 스포츠2</th>
        <th>좋아하는 스포츠3</th>
        <th>좋아하는 스포츠4</th>
        </thead>
        <tbody></tbody>
    </table>
</div>
</BODY>
</HTML>






