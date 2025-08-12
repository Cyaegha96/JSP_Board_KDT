/**
 * 
 */


$("#zoneCodeAPIBtn").on("click", function(){	

    	new daum.Postcode({
            oncomplete: function(data) {
                
                $("#inputZoneCode").val(data.zonecode);
                $("#inputAddress").val(data.address);
            }
        }).open();
    	
	});

$("#form").on("submit",function(){

    	console.log("전송 버튼 누름")
    	
    	//아이디 검사
	    
    	if($('#inputId').val() == ""){
            alert("아이디를 입력해주세요!")
            return false;
        }

        let regex = /^[a-z0-9_]{4,12}$/;
        if(!regex.test($('#inputId').val())){
            alert("아이디가 적합하지 않습니다!")
            return false;
        }
        
        if(!isDuplicateChecked){
		alert("아직 중복 검사를 하지 않았습니다!")
			return false;
        }

        //패스워드 검사
        
        if($('#inputPW').val() == ""){
            alert("패스워드를 입력해주세요!")
            return false;
        }
        

        //영문 숫자, 특수문자
        regex =/^([a-zA-Z0-9]|[^a-zA-Z0-9\s]){8,16}$/ 
        if(!regex.test($('#inputPW').val())){
            alert("패스워드가 적합하지 않습니다!")
            return false;
        }
        regex = /[a-zA-Z]+?/
        if(!regex.test($('#inputPW').val())){
            alert("패스워드에 최소 한번의 영문이 들어가지 않습니다!")
            return false;
        }

        regex = /[0-9]+?/
        if(!regex.test($('#inputPW').val())){
            alert("패스워드에 최소 한번의 숫자가 들어가지 않습니다!")
            return false;
        }

        regex = /[^a-zA-Z0-9\s]+?/
        if(!regex.test($('#inputPW').val())){
            alert("패스워드에 최소 한번의 특수기호가 들어가지 않습니다!")
            return false;
        }
        
        let pwInputCorrect = $('#inputPWCorrect').val();
        //8~16자의 영문, 숫자, 특수문자를 최소한 각각 한글자 이상 포함해야 함
        //if문 여러번 사용 가능

        if(pwInputCorrect == ""){
             alert("패스워드 확인을 입력해주세요!")
            return false;
        }

        if(pwInputCorrect != $('#inputPW').val()){
            alert("패스워드 확인이 일치하지 않습니다!");
            return false;
        }

        let nameInput = document.getElementById("inputName").value;
        //이름은 2~6글자의 한글로만 구성 가능

        if(nameInput == ""){
            alert("이름이 빈칸이에요");
            return false;
        }

        regex = /^[가-힣]{2,6}$/;
        if(!regex.test(nameInput)){
            alert("부모님이 주신 이름을 사용하세요");
            return false;
        }

        let emailInput = document.getElementById("inputEmail").value;
        //이메일은 영문 대/소문자 및 숫자만 사용가능
        //@기호가 하나는 포함되어야 하며    
        //.com이나 .co.kr처럼 입력 가능해야 함.
        //즉 이메일 형식에 맞게

        
        regex = /^[a-z0-9_]{4,12}@[a-zA-Z0-9]+(\.com|\.co\.kr)$/;
        if(!regex.test(emailInput)){
            alert("적합하지 않은 이메일입니다.");
            return false;
        }
        
        
        
    });