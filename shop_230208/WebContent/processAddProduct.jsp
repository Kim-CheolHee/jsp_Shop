<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>

<%
	request.setCharacterEncoding("utf-8");
	
	String url = application.getRealPath("/upload");  
	// 상대경로를 절대경로로 변환
	int maxSize = 5 * 1024 * 1024;
	// 그림 파일의 최대 크기 5메가바이트로 설정
	
	 MultipartRequest multi 
	 = new MultipartRequest(request,url,maxSize,"utf-8", 
			 new DefaultFileRenamePolicy());
	
		
	String productId = multi.getParameter("productId");
	String pname = multi.getParameter("pname");
	String unitPrice = multi.getParameter("unitPrice");
	String description = multi.getParameter("description");
	String manufacturer = multi.getParameter("manufacturer");
	String category = multi.getParameter("category");
	String unitsInStock = multi.getParameter("unitsInStock");
	String condition = multi.getParameter("condition");
	
	String filename = multi.getFilesystemName("productImage");
	
	Integer price;
	
	// 가격을 입력하지 않았으면 0으로 세팅
	if(unitPrice.isEmpty()) {
		price=0;
	} else {
		price = Integer.valueOf(unitPrice);
	}
	
	long stock;
	
	// 재고수량을 입력하지 않았으면 0으로 세팅
	if(unitsInStock.isEmpty()) {
		stock=0;
	} else {
		stock = Long.valueOf(unitsInStock);
	}
	
	ProductRepository dao = new ProductRepository();
	Product newProduct = new Product();
	newProduct.setProductId(productId);
	newProduct.setPname(pname);
	newProduct.setUnitPrice(price);
	newProduct.setDescription(description);
	newProduct.setManufacturer(manufacturer);
	newProduct.setCategory(category);
	newProduct.setUnitsInStock(stock);
	newProduct.setCondition(condition);
	newProduct.setFilename(filename);
	
	dao.addProduct(newProduct);
	response.sendRedirect("products.jsp");

%>












