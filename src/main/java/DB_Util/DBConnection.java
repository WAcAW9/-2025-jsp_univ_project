
package DB_Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DBConnection {

    private static final String URL      = "jdbc:mysql://localhost:3306/SchoolProjectJSP";
    private static final String USER     = "root";
    private static final String PASSWORD = "7482";

    
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); 
        } catch (ClassNotFoundException e) {
            throw new IllegalStateException("MySQL JDBC 드라이버를 찾을 수 없습니다.", e);
        }
    }

    
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // 외부에서 인스턴스화 방지
    private DBConnection() {}
}
