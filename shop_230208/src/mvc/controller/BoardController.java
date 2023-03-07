package mvc.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import java.util.List;
import java.util.ArrayList;
import java.util.Date;

import mvc.model.BoardDTO;
import mvc.model.BoardDAO;

public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final int LISTCOUNT = 5;    
   
    public BoardController() {
        super();
      
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		if(command.equals("/BoardListAction.do")) {  // 기존에 등록된 글 목록 페이지 출력함
			requestBoardList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./list.jsp");
			rd.forward(request, response);
		} else if (command.equals("/BoardWriteForm.do")) { // 글 등록 페이지 출력함
			RequestDispatcher rd = request.getRequestDispatcher("./writeForm.jsp");
			rd.forward(request, response);
		} else if (command.equals("/BoardWriteAction.do")) { // 작성글 DB등록 및 게시판으로 이동
			requestBoardWrite(request);
			RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");
			rd.forward(request, response);
		} else if (command.equals("/BoardViewAction.do")) { // 게시판 세부내용 출력
			requestBoardView(request);
			request.getRequestDispatcher("./view.jsp").forward(request, response);
		} else if (command.equals("/BoardDeleteAction.do")) { // 게시글 삭제
			requestBoardDelete(request);
			request.getRequestDispatcher("/BoardListAction.do").forward(request, response);
		} else if (command.equals("/BoardUpdateAction.do")) { // 게시글 수정
			requestBoardUpdate(request);
			request.getRequestDispatcher("/BoardListAction.do").forward(request, response);
		}
	}
	
	// 게시글 수정
	public void requestBoardUpdate(HttpServletRequest request) {
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = new BoardDTO();
		
		int num = Integer.parseInt(request.getParameter("num"));
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
		dto.setNum(num);
		dto.setSubject(subject);
		dto.setContent(content);
		
		dao.updateBoard(dto);
		dao.close();
	}

	// 게시글 삭제
	public void requestBoardDelete(HttpServletRequest request) {
		BoardDAO dao = new BoardDAO();
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		dao.deleteBoard(num);
		dao.close();
	}
	
	// 페이지 상세보기
	public void requestBoardView(HttpServletRequest request) {
		BoardDAO dao = new BoardDAO();
		
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		BoardDTO dto = new BoardDTO();
		dto = dao.getBoardByNum(num);
		dao.close();
		
		request.setAttribute("num", num);
		request.setAttribute("page", pageNum);
		request.setAttribute("dto", dto);
	}
	
	// 작성글 등록하기
	public void requestBoardWrite(HttpServletRequest request) {
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = new BoardDTO();
		
		dto.setId(request.getParameter("id"));
		dto.setName(request.getParameter("name"));
		dto.setSubject(request.getParameter("subject"));
		dto.setContent(request.getParameter("content"));
		String now = new SimpleDateFormat("yyyy/MM/dd(hh:mm:ss)").format(new Date());
		dto.setRegist_day(now);
		dto.setHit(0);
		dto.setIp(request.getRemoteAddr()); // ip주소 가져오기
		
		dao.insertBoard(dto);
		dao.close();
	}
	
	
	// 등록된 글 목록 가져오기
	public void requestBoardList(HttpServletRequest request) {
		BoardDAO dao = new BoardDAO();
		List<BoardDTO> boardlist = new ArrayList<BoardDTO>();
			
		int pageNum=1;
		int limit=LISTCOUNT;
			
		if(request.getParameter("pageNum")!=null)
			pageNum=Integer.parseInt(request.getParameter("pageNum"));
					
		String items = request.getParameter("items");  //검색 항목
		String text = request.getParameter("text");    //검색 내용
			
		int total_record=dao.getListCount(items, text); //조건에 맞는 행 개수
		boardlist = dao.getBoardList(pageNum, limit, items, text); 
		// 페이지개수, 한 화면에 표시할 행 개수, 검색 항목, 검색 내용을 boardlist에 대입 
			
		int total_page;   // 전체 페이지
			
		if (total_record % limit == 0){    
		// 전체 게시물 개수에서 한 페이지당 표시할 개수를 나눈 나머지가 0과 같으면
		// 예) 한 페이지당 10개씩 게시물을 표시함, 전체 게시물이 100개
		// 100 / 10 ->  나머지 0   전체 페이지수는 10으로 표시함
		   	total_page =total_record/limit;
		   	Math.floor(total_page);  
		}
		else{
		// 예) 한 페이지당 10개씩 표시, 전체 게시물이 105개이면
		// 전체 페이지 수는 10개에 더하기 1을 추가하여 11페이지가 나와야 함
		   total_page =total_record/limit;
		   Math.floor(total_page); 
		   total_page =  total_page + 1; 
		}		
	   
	   	request.setAttribute("pageNum", pageNum);		  
	   	request.setAttribute("total_page", total_page);   
		request.setAttribute("total_record",total_record); 
		request.setAttribute("boardlist", boardlist);
		dao.close();
	}
	
}
