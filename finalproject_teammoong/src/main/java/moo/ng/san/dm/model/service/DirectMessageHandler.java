package moo.ng.san.dm.model.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;



//최초접속 시 : 현재 내가 읽지 않은 쪽지 수를 가져옴
//다른사람이 접속한 사람한테 쪽지를 보낸 경우 : 접속한 사람의 쪽지 수 update
public class DirectMessageHandler extends TextWebSocketHandler{

	@Autowired
	private DmService service;
	
	//쪽지 실시간 알림에 접속한 회원을 관리할 Map (Key :  id, value:접속세션)
	private HashMap<String, WebSocketSession> connectionMemberList;
	
	public DirectMessageHandler() {
		super();
		connectionMemberList = new HashMap<String, WebSocketSession>();
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//접속했을때 자동실행
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//★ws.send했을때는 무조건 이 메소드가 실행됨
		String receiveMsg = message.getPayload(); //ws.send로 보내준 값 받아오는거
		
		JsonElement element =JsonParser.parseString(receiveMsg);//가져온 값을 JSON으로 바꿔줌
		String type = element.getAsJsonObject().get("type").getAsString();
		
		if(type.equals("enter")) {
			String memberId = element.getAsJsonObject().get("memberId").getAsString();
			connectionMemberList.put(memberId,session); //최초접속이므로, 접속한 회원의 아이디를 map에 추가
			//현재 읽지 않은 쪽지를 조회해서 되돌려줘야 하기 때문에 service에 요청
			int dmCount = service.selectDmCount(memberId);
			JsonObject obj = new JsonObject();
			obj.addProperty("type", "myDmCount");
			obj.addProperty("dmCount", dmCount); // 객체처리 완
			String resultStr = new Gson().toJson(obj); //<--보내주는건 String타입이어야 하므로 객체를 스트링타입으로 변형
			TextMessage tm = new TextMessage(resultStr); //전송양식
			session.sendMessage(tm);
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	}
	
}//DirectMessageHandler