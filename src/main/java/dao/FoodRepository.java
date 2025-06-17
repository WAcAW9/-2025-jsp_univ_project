package dao;
import java.sql.*;
import java.util.*;

import DB_Util.DBConnection;
import dto.Food;

public class FoodRepository {
    public List<Food> getAllFoods() throws Exception {
        List<Food> list = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
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

        return list;
    }
}