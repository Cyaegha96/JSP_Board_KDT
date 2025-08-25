<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>채팅방 </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="bg-light">
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card shadow" style="width: 400px;">
            <div class="card-header text-center bg-primary text-white">
               사이트 채팅방
            </div>
            <div id="messages" class="card-body overflow-auto" style="height: 300px;"></div>
            <div class="card-footer d-flex">
                <input type="text" id="msg-input" class="form-control me-2" placeholder="메시지 입력">
                <button id="send-btn" class="btn btn-primary">보내기</button>
            </div>
        </div>
    </div>

    <script>
        var username = '${loginId}';
        var socket = new WebSocket("ws://10.5.5.12/ChatingServer");

        socket.onopen = function() { console.log("연결 성공!"); };
        socket.onmessage = function(event) {
            var msgDiv = $('<div>').addClass('alert alert-success p-2').text(event.data);
            $('#messages').append(msgDiv);
            $('#messages').scrollTop($('#messages')[0].scrollHeight);
        };

        $('#send-btn').click(function() {
            var msgInput = $('#msg-input');
            if (msgInput.val().trim() !== "") {
                var msgDiv = $('<div>').addClass('alert alert-primary p-2 text-end').text(msgInput.val());
                $('#messages').append(msgDiv);
                socket.send(username + ": " + msgInput.val());
                msgInput.val('');
                $('#messages').scrollTop($('#messages')[0].scrollHeight);
            }
        });

        $('#msg-input').keypress(function(e) {
            if (e.which === 13) $('#send-btn').click();
        });
    </script>
</body>
</html>
