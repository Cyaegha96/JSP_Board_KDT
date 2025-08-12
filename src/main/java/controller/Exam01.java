package controller;

public class Exam01 {
	public static void main(String[] args) {
		//페이지네이션
		
		//1. 전체 레코드 수가 몇개인지?
		int recordTotalCount = 147;
		
		//2. 한페이지 안에 몇개의 게시글을 보여줄지?
		int recordCountPerPage = 10;
		
		//3. 한번에 네비게이터를 몇개씩 보여줄 것인지?
		
		int naviCountPerPage = 10;
		
		//4. 전체 몇 페이지가 생성될 것인지?
		
		int pageTotalCount = 0 ;
		if(recordTotalCount%recordCountPerPage > 0) {
			pageTotalCount  = recordTotalCount/recordCountPerPage + 1;
		}else {
			pageTotalCount  = recordTotalCount/recordCountPerPage;
		}
		
		//5. 내가 현재 있는 페이지 설정
		
		int currentPage = 11;
		
		if(currentPage <1) {
			currentPage = 1;
		}else if(currentPage > pageTotalCount) {
			currentPage  =pageTotalCount;
		}
		
		
		//내비게이터의 시작값과 끝값
		
		int startNavi = ((currentPage - 1)/ naviCountPerPage) * naviCountPerPage  +1;
		int endNavi = startNavi + naviCountPerPage-1;
		
		if(endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}
		
		System.out.println("현재 위치: "+currentPage);
		System.out.println("네비 시작: "+startNavi);
		System.out.println("네비 종료:" +endNavi);
		
		
		boolean needPrev = true;
		boolean needNext = true;
		
		if(startNavi == 1) {
			
			needPrev = false;
		}
		
		if(endNavi == pageTotalCount){
			needNext=false;
		}
		
		//ui
		if(needNext) {
			System.out.println("<");
		}
		for(int i=startNavi;i<=endNavi;i++) {
			System.out.println(i + " ");
		}
		if(needNext) {
			System.out.println(">");
		}
		
	}
}
