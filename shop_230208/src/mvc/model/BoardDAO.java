package mvc.model;

import java.util.ArrayList;

import common.JDBConnect;

public class BoardDAO extends JDBConnect {

		
	public BoardDAO() {
		super();
	}
	
	//board 테이블의 레코드 개수
	public int getListCount(String items, String text) {  // 검색 조건 및 내용을 넘겨줌
		
		int x = 0;
		String sql;
		
		if (items == null && text == null)   // 검색 조건이 없으면 전체 레코드 개수 출력
			sql = "select count(*) from board";
		else  // 검색 조건이 있으면 조건에 맞는 개수 출력
			sql = "select count(*) from board where " + items + " like '%" + text + "%'";  
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();

			if (rs.next()) 
				x = rs.getInt(1);
			
		} catch (Exception ex) {
			System.out.println("getListCount 오류 : " + ex);
		} 	
		return x;   // 최종적인 레코드 개수 출력
	}
	
	//board 테이블의 레코드 가져오기
	public ArrayList<BoardDTO> getBoardList(int page, int limit, String items, String text) {

		int total_record = getListCount(items, text);  //조건에 맞는 전체 행의 개수
		int start = (page - 1) * limit;   // 해당 페이지 게시물의 시작 지점
		int index = start + 1;
		String sql;

		if (items == null && text == null)
			sql = "select * from board order by num desc";  // 조건이 없으면 전체 게시물 중 최근 게시물부터 표시함
		else
			sql = "select * from board where " + items + " like '%" + text + "%' order by num desc";  // 조건이 있으면 조건에 맞는 게시물 중 최근 게시물부터 표시함

		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();

		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();

			while (rs.absolute(index)) {   // 반복문 이용하여 해당 게시물을 게시판에 넣음
				BoardDTO board = new BoardDTO();   
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setRegist_day(rs.getString("regist_day"));
				board.setHit(rs.getInt("hit"));
				board.setIp(rs.getString("ip"));
				list.add(board);

				if (index < (start + limit) && index <= total_record)
					index++;
				else
					break;
			}
			
			return list;
		} catch (Exception ex) {
			System.out.println("연결 오류 : " + ex);
		} 
		return null;
	}
	
	// board에 글 작성하기
	public void insertBoard(BoardDTO dto) {
		try {
			String query = "INSERT INTO board(id, name, subject, content, regist_day, hit, ip) VALUES(?, ?, ?, ?, ?, ?, ?)";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getSubject());
			psmt.setString(4, dto.getContent());
			psmt.setString(5, dto.getRegist_day());
			psmt.setInt(6, dto.getHit());
			psmt.setString(7, dto.getIp());
			psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("insertBoard() 예외 발생" + e);
		}
	}
	
	// 게시글 상세보기
	public BoardDTO getBoardByNum(int num) {
		BoardDTO dto = new BoardDTO();
		
		String query = "SELECT * FROM board WHERE num=?";
		
		// 게시글 조회수 증가
		updateHit(num);
		
		try {
			psmt = con.prepareStatement(query); // 쿼리문 준비
			psmt.setInt(1, num);
			rs = psmt.executeQuery(); // 쿼리문 실행
			if(rs.next()) { // rs에 결과가 있다면 
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setRegist_day(rs.getString("regist_day"));
				dto.setHit(rs.getInt("hit"));
				dto.setIp(rs.getString("ip"));
			}
		} catch (Exception e) {
			System.out.println("getBoardByNum() 예외 발생" + e);
		}
		return dto;
	}

	// 게시글 조회수 증가
	public void updateHit(int num) {
		
		String query = "UPDATE board SET hit=hit+1 WHERE num=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, num);
			psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("updateHit() 예외 발생 : " + e);
		}
		
	}

	// 게시글 삭제
	public void deleteBoard(int num) {
		
		String query = "DELETE FROM board WHERE num=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, num);
			psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("deleteBoard() 예외 발생 : " + e);
		}
		
	}
	
	// 게시글 수정
	public void updateBoard(BoardDTO dto) {
		
		String query = "UPDATE board SET subject=?, content=? WHERE num=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getSubject());
			psmt.setString(2, dto.getContent());
			psmt.setInt(3, dto.getNum());
			psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("updateBoard() 예외 발생 : " + e);
		}
		
	}
	
}
