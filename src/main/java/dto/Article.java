package dto;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

// 게시글 클래스
public class Article implements Serializable {


	private static final long serialVersionUID = 1L;
	
	private String title;// 제목
	private String user;// 작성자
	private String description;// 음식에 대한 간단한 설명
	private String recipe; // 레시피
	private String articleId; // 게시글 아이디
	private String filename; // 이미지 파일
	private String date;
	private int like; //좋아요 갯수
	private int like_article_quantity; // 좋아요 누른 게시글
	//맛분류
	private int spicy;
	private int sweet;
	private int salty;
	private int savory;
	private int umami;
	

	public Article() {
		super();
		generateDateAndId();
		
	}
	
	public Article(String title,String user) {
		this.title=title;
		this.user=user;
		generateDateAndId();
		
	}


	// 날짜와 articleId를 자동 생성하는 메서드
    private void generateDateAndId() {
        LocalDateTime now = LocalDateTime.now();

        DateTimeFormatter idFormat = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");
        this.articleId = now.format(idFormat);

        DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        this.date = now.format(dateFormat);
    }
    
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getArticleId() {
		return articleId;
	}

	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public int getLike() {
		return like;
	}

	public void setLike(int like) {
		this.like = like;
	}

	public int getLike_article_quantity() {
		return like_article_quantity;
	}

	public void setLike_article_quantity(int like_article_quantity) {
		this.like_article_quantity = like_article_quantity;
	}

	public String getRecipe() {
		return recipe;
	}

	public void setRecipe(String recipe) {
		this.recipe = recipe;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getSpicy() {
		return spicy;
	}

	public void setSpicy(int spicy) {
		this.spicy = spicy;
	}

	public int getSweet() {
		return sweet;
	}

	public void setSweet(int sweet) {
		this.sweet = sweet;
	}

	public int getSalty() {
		return salty;
	}

	public void setSalty(int salty) {
		this.salty = salty;
	}

	public int getSavory() {
		return savory;
	}

	public void setSavory(int savory) {
		this.savory = savory;
	}

	public int getUmami() {
		return umami;
	}

	public void setUmami(int umami) {
		this.umami = umami;
	}



	

}