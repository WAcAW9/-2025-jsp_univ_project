package KNNRecommend;

import java.sql.*;
import java.util.ArrayList;

import DB_Util.DBConnection;  
import dto.Food;

public class KNNRecommend {

    // 음식 정보 불러오기
    private ArrayList<Food> loadFoodsFromDB() {
        ArrayList<Food> list = new ArrayList<>();

        try {
            Connection conn = DBConnection.getConnection();  // DBConnection 사용
            String sql = "SELECT * FROM FoodList";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Food food = new Food();
                food.setFoodCode(rs.getInt("FoodCode"));
                food.setSpicy(rs.getInt("Spicy"));
                food.setSweet(rs.getInt("Sweet"));
                food.setSalty(rs.getInt("Salty"));
                food.setSavory(rs.getInt("Savory"));
                food.setUmami(rs.getInt("Umami"));
                list.add(food);
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 사용자 Taste 불러오기
    private int[] getUserTaste(String userCode) {
        int[] taste = new int[5];

        try {
            Connection conn = DBConnection.getConnection();  // DBConnection 사용
            String sql = "SELECT UserSpicy, UserSweet, UserSalty, UserSavory, UserUmami FROM UserTaste WHERE UserCode = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userCode);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                taste[0] = rs.getInt("UserSpicy");
                taste[1] = rs.getInt("UserSweet");
                taste[2] = rs.getInt("UserSalty");
                taste[3] = rs.getInt("UserSavory");
                taste[4] = rs.getInt("UserUmami");
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return taste;
    }

    // 추천 함수 
    public int recommendFoodByUser(String userCode) {
        ArrayList<Food> foods = loadFoodsFromDB();
        int[] userTaste = getUserTaste(userCode);

        // 무한으로 초기화 
        int minDistance = Integer.MAX_VALUE;
        int recommended = -1;

        for (Food food : foods) {
            int dist = 0;
            dist += Math.pow(food.getSpicy() - userTaste[0], 2);
            dist += Math.pow(food.getSweet() - userTaste[1], 2);
            dist += Math.pow(food.getSalty() - userTaste[2], 2);
            dist += Math.pow(food.getSavory() - userTaste[3], 2);
            dist += Math.pow(food.getUmami() - userTaste[4], 2);

            if (dist < minDistance) {
                minDistance = dist;
                recommended = food.getFoodCode();
            }
        }

        return recommended;
    }
}