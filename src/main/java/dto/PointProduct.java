package dto;

import java.io.Serializable;

public class PointProduct implements Serializable {
	private static final long serialVersionUID = 202505250123456789L;
	
	private String ProductName; // 제품명
	private String ProductCode; // 제품 코드
	
	private int ProductPrice; // 제품 가격
	private String ProductImage; // 제품 이미지
	private int remainingQuantity; //남은 수량 
	private String description; // 설명 
	
	public PointProduct() {
		super();
	}
	public PointProduct(String ProductName, String ProductCode) {
		this.ProductName = ProductName;
		this.ProductCode = ProductCode;
	}
	public String getProductName() {
		return ProductName;
	}
	public void setProductName(String productName) {
		ProductName = productName;
	}
	public String getProductCode() {
		return ProductCode;
	}
	public void setProductCode(String productCode) {
		ProductCode = productCode;
	}
	public int getProductPrice() {
		return ProductPrice;
	}
	public void setProductPrice(int productPrice) {
		ProductPrice = productPrice;
	}
	public String getProductImage() {
		return ProductImage;
	}
	public void setProductImage(String productImage) {
		ProductImage = productImage;
	}
	public int getRemainingQuantity() {
		return remainingQuantity;
	}
	public void setRemainingQuantity(int remainingQuantity) {
		this.remainingQuantity = remainingQuantity;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}

	
}