
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Phaser3 Clicker Game</title>
    <script src="https://cdn.jsdelivr.net/npm/phaser@3/dist/phaser.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body { margin: 0; background: #222; }
        canvas { display: block; margin: 0 auto; }
    </style>
</head>
<body>

<script>
let userId = "${loginId}";
console.log(userId)
let button1Count = 0;
let button2Count = 0;

class MyGame extends Phaser.Scene {
    constructor() {
        super('MyGame');
    }

    preload() {
    	this.load.image('button1', 'assets/1.svg');
        this.load.image('button2', 'assets/2.svg');
        this.load.image('button3', 'assets/3.svg');
    	
    }

    create() {
        // 중앙에 버튼 3개 배치
        this.button1 = this.add.sprite(200, 300, 'button1')
            .setInteractive();

        this.button2 = this.add.sprite(400, 300, 'button2')
            .setInteractive()
     

        this.button3 = this.add.sprite(600, 300, 'button3')
            .setInteractive()
           

        this.statusText = this.add.text(400, 100, "Point +0", { fontSize: '28px', fill: '#0f0' })
            .setOrigin(0.5);
        this.statusText2 = this.add.text(400, 500, "현재 점수:", { fontSize: '28px', fill: '#0f0' })
        .setOrigin(0.5);

        // 버튼 1 클릭 이벤트
        this.button1.on('pointerdown', () => {
        	$.ajax({
        	    url: "/api/point/add1",
        	    method: "POST",
        	    data: { userId }, // JSON.stringify 안 쓰고 바로 전송
        	    success: (res)  => {
                    button1Count++;
                    
                    this.statusText.setText("+1 Point!");
                    let currentPoint = res.currentPoint;
                    this.statusText2.setText("현재점수: " +currentPoint);

                  
                },
                error: (err) => console.error(err)
            });
        });

        // 버튼 2 클릭 이벤트
        this.button2.on('pointerdown', () => {
        	$.ajax({
        	    url: "/api/point/add3",
        	    method: "POST",
        	    data: { userId }, // JSON.stringify 안 쓰고 바로 전송
        	    success: (res)  => {
                    button2Count++;
                    this.statusText.setText("+3 Point!");
                    let currentPoint = res.currentPoint;
                    this.statusText2.setText("현재점수: " +currentPoint);
                    
                },
                error: (err) => console.error(err)
            });
        });

        // 버튼 3 클릭 이벤트
        this.button3.on('pointerdown', () => {
        	$.ajax({
        	    url: "/api/point/add5",
        	    method: "POST",
        	    data: { userId }, // JSON.stringify 안 쓰고 바로 전송
        	    success: (res)  => {
        	    	let currentPoint = res.currentPoint;
                    this.statusText2.setText("현재점수: " +currentPoint);
                    this.statusText.setText("+5 Point!");
                },
                error: (err) => console.error(err)
            });
        });
    }
}

const config = {
    type: Phaser.AUTO,
    width: 800,
    height: 600,
    scene: [MyGame]
};

new Phaser.Game(config);
</script>

</body>
</html>

