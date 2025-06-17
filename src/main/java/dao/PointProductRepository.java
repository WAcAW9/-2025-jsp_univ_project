
package dao;

import dto.PointProduct;
import DB_Util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PointProductRepository {
    private static PointProductRepository instance = new PointProductRepository();

    public static PointProductRepository getInstance() {
        return instance;
    }

    public PointProduct getPointProductById(String productCode) {
        PointProduct product = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM PointProduct WHERE ProductCode = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, productCode);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                product = new PointProduct();
                product.setProductCode(rs.getString("ProductCode"));
                product.setProductName(rs.getString("ProductName"));
                product.setProductPrice(rs.getInt("ProductPrice"));
                product.setProductImage(rs.getString("ProductImage"));
                product.setRemainingQuantity(rs.getInt("RemainingQuantity"));
                product.setDescription(rs.getString("Description"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }

    public List<PointProduct> getAllProducts() {
        List<PointProduct> productList = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM PointProduct";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PointProduct product = new PointProduct();
                product.setProductCode(rs.getString("ProductCode"));
                product.setProductName(rs.getString("ProductName"));
                product.setProductPrice(rs.getInt("ProductPrice"));
                product.setProductImage(rs.getString("ProductImage"));
                product.setRemainingQuantity(rs.getInt("RemainingQuantity"));
                product.setDescription(rs.getString("Description"));
                productList.add(product);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    public void insertProduct(PointProduct product) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO PointProduct (ProductCode, ProductName, ProductPrice, ProductImage, RemainingQuantity, Description) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, product.getProductCode());
            ps.setString(2, product.getProductName());
            ps.setInt(3, product.getProductPrice());
            ps.setString(4, product.getProductImage());
            ps.setInt(5, product.getRemainingQuantity());
            ps.setString(6, product.getDescription());
            ps.executeUpdate();

            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


} 
