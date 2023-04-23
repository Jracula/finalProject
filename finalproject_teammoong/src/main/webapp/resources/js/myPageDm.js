function getReceiveDm(){
    const memberId = $("#memberId").val();
    $.ajax({
        url : "/myDmList.do",
        data : {dmReceiver:memberId},
        success : function(list){
            const tbody = $(".receiveDmTbl>tbody");
            tbody.empty();
            for(let i = 0 ; i<list.length ; i++){
                const dm = list[i];
                const tr = $("<tr>");
                
                const td1 = $("<td>");
                td1.text(dm.rnum);
                
                const td2 = $("<td>");
                td2.text(dm.dmContent);
                td2.css("cursor","pointer");
                td2.attr("onclick","dmDetail("+dm.dmNo+");");
                
                const td3 = $("<td>");
                td3.text(dm.dmSenderName);
                
                const td4 = $("<td>");
                td4.text(dm.dmDate);
                
                const td5 = $("<td>");
                if(dm.dmReadChk == 0){
                    tr.addClass("bold");
                    td5.text("읽지않음");
                }else{
                    td5.text("읽음");
                }
                tr.append(td1).append(td2).append(td3).append(td4).append(td5);
                tbody.append(tr);
            }
        }
    })
}




function getSendDm(){
    const memberId = $("#memberId").val();
    $.ajax({
        url : "/myDmList.do",
        data : {dmSender:memberId},
        success : function(list){
            const tbody = $(".sendDmTbl>tbody");
            tbody.empty();
            for(let i = 0 ; i<list.length ; i++){
                const dm = list[i];
                const tr = $("<tr>");
                
                const td1 = $("<td>");
                td1.text(dm.rnum);
                
                const td2 = $("<td>");
                td2.text(dm.dmContent);
                td2.css("cursor","pointer");
                td2.attr("onclick","dmDetail("+dm.dmNo+");");
                
                const td3 = $("<td>");
                td3.text(dm.dmReceiverName);
                
                const td4 = $("<td>");
                td4.text(dm.dmDate);
                
                tr.append(td1).append(td2).append(td3).append(td4);
                tbody.append(tr);
            }
        }
    })
}




function dmDetail(dmNo){
    $.ajax({
        url : "/dmView.do",
        data : {dmNo:dmNo},
        success : function(dm){
            $("#viewSender").text("보낸 사람 : "+dm.dmSenderName+"("+dm.dmSender+")");
            $("#replyToId").val(dm.dmSender);
            $("#viewReceiver").text("받은 사람 : "+dm.dmReceiverName+"("+dm.dmReceiver+")");
            $("#viewDate").text("보낸 날짜 : "+dm.dmDateHour);
            $("#viewContent").text(dm.dmContent);
            $("#dmViewer").modal({
				 showClose: false,
	             fadeDuration: 100
	        });
            getReceiveDm();
        }
    })
}




function replyDm(){
	const memberId = $("#replyToId").val();
	location.href="/dmReply.do?receiver="+memberId;
}
