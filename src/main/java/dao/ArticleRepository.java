package dao;
// 게시글 데이터 접근 클래스
import java.util.ArrayList;
import dto.Article;

public class ArticleRepository {

	private ArrayList<Article> listOfArticles= new ArrayList<Article>();
	// addArticle
	private static ArticleRepository instance= new ArticleRepository();
	
	
	public static ArticleRepository getInstance() {
		return instance;
	}
	
	//자바 빈즈로 사용할 게시글 데이터 접근 클래스
	public ArticleRepository() {
		Article article1=new Article("토마토 파스타","파스타장인");
		article1.setDescription("집에서도 고급스러운 파스타 만들기!");
		article1.setDate("2024-11-21 12:24:45");
		article1.setArticleId("1");
		article1.setSpicy(0);
		article1.setSweet(3);
		article1.setSalty(0);
		article1.setSavory(0);
		article1.setUmami(2);
		article1.setFilename("1.jpg");
		article1.setRecipe("토마토 스파게티만들기,토마토 스파게티 만드는 법\r\n"
				+ "<br><br>\r\n"
				+ "1. 스파게티면을 250g을 준비해주세요.<br><br>\r\n"
				+ "2. 파슬리가루와 파머산치즈가루는 없으면 패스하셔도 상관없어요. 스파게티소스는 시판용을 가지고 조리했습니다<br><br>\r\n"
				+ "3. 제일 먼저 끓는물에 소금1/2티스푼,올리브유1티스푼을 넣고<br><br>\r\n"
				+ "4. 스파게티면을 8분정도 삶아주었어요 개인차가 있겠지만 저는 8분정도 끓여주어야 꼬들하니 식감이 좋더라구요. 8분이 지난 스파게티면은 찬물에 헹구지 말고 체에 걸러서 물기만 제거해주세요.<br><br>\r\n"
				+ "5. 브로콜리는 1송이를 먹기 좋은 크기로 잘라준뒤 끓는물에 소금1/2티스푼을 넣고 살짝 데쳐준뒤 찬물에 헹구어서 준비합니다.<br><br>\r\n"
				+ "6. 방울토마토,통마늘,양송이버섯,햄,베이컨,양파를 먹기 좋은 크기로 잘라서 준비합니다.<br><br>\r\n"
				+ "7. 넓은 팬에 올리브유 1스푼을 넣고 마늘과 양파를 넣어 양파가 투명해질때까지 볶아주세요.<br><br>\r\n"
				+ "8. 양파가 투명해지면 베이컨과 햄을 넣고 볶아줍니다.<br>\r\n"
				+ "9. 베이컨이 쪼그라드는 느낌이 나면 시판 소스와 토마토,양송이버섯,브로콜리를 넣고 섞어주세요.<br><br>\r\n"
				+ "10. 여기에 삶아 놓았던 스파게티면을 넣고 잘 섞어주면 시판 소스를 이용한 토마토스파게티 완성입니다!<br><br>");
		Article article2=new Article("볶음밥","볶음밥킬러");
		article2.setDescription("자취생이 하기좋은 간단한 볶음밥");
		article2.setDate("2025-06-05 00:21:15");
		article2.setArticleId("2");
		article2.setSpicy(1);
		article2.setSweet(2);
		article2.setSalty(1);
		article2.setSavory(3);
		article2.setUmami(0);
		article2.setFilename("2.jpg");
		article2.setRecipe("볶음밥 간단하게 만드는 법!<br><br>\r\n"
				+ "1. 대파는 깨끗이 씻어 1㎝ 두께로 썬다. 첫 번째 볶음밥 맛있게 만드는법 비결은 대파를 넉넉히 넣어 주면 더 맛있답니다.<br><br>\r\n"
				+ "2. 베이컨은 2㎝ 크기로 썬다.<br><br>\r\n"
				+ "3. 계란은 소금 한꼬집 넣어 풀어준다.<br><br>\r\n"
				+ "4. 팬에 기름을 살짝 두르고 약 불에서 스크램블을 만든다<br><br>\r\n"
				+ "5. 스크램블은 따로 덜어 내고 팬에 기름을 살짝 두르고 대파, 베이컨을 넣어 센 불에서 휘리릭 볶아 불 향을 준다..<br><br>\r\n"
				+ "6. 베이컨이 충분히 익었을 때 간장을 재료 위에 넣지 말고 팬 가장자리에 직접 닿게 뿌려 불 향이 나게 볶아 준다.<br><br>\r\n"
				+ "7. 불을 약하게 줄여 계란 스크램블과 밥을 넣어 밥알을 풀어주는 느낌으로 볶는다.<br><br>\r\n"
				+ "8. 재료와 밥이 어우러져 맛있게 볶아지면 센 불에서 가볍게 한번 더 볶아 고슬고슬하게 볶아준다.<br><br>\r\n"
				+ "9. 마지막에 간을 보아 소금으로 간을 맞춘 다음 참기름 돌려주면 백종원 볶음밥 레시피 완성입니다.<br><br>");
		// 리스트에 추가
		listOfArticles.add(article1);
		listOfArticles.add(article2);
	}
	// 게시글 목록을 가져오는 메소드 
	public ArrayList<Article> getAllArticles(){
		return listOfArticles;
	}

	
	// 게시글 상세 정보 가져오기
	public Article getArticleById(String articleId) {
		Article articleById = null;
		
		for(int i=0;i<listOfArticles.size();i++) {
			Article article= listOfArticles.get(i);
			if(article!=null&&article.getArticleId()!=null&&article.getArticleId().equals(articleId)) {
				articleById=article;
				break;
			}
		}
		return articleById;
	}
	
	// addArticle
	public void addArticle(Article article) {
		listOfArticles.add(article);
	}
}