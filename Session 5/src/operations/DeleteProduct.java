package operations;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/*
 * Class containing method to delete products not ordered in last one year
 * 
 */
public class DeleteProduct {
	private Connection connection;

	/**
	 * Method deletes the Products which are not ordered from 1 year
	 * 
	 * @return number of products status updated
	 */
	public int deleteProductsNotPurchased() throws SQLException {

		connection = JDBCConnection.getDatabaseConnection("e-store");

		int result = 0;
		String queryToDeleteProduct = "UPDATE Products SET stock_status=0 "
				+ "WHERE prod_id NOT IN (SELECT c.cart_id FROM "
				+ "Cart c LEFT JOIN Orders o ON c.cart_id = o.cart_id "
				+ "WHERE DATEDIFF(now(),DATE(o.order_timestamp))<365)";

		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement(queryToDeleteProduct);

			connection.setAutoCommit(false);
			result = preparedStatement.executeUpdate();
			connection.commit();
		} catch (SQLException se) {
			System.out.println("SQL Exception occurred !");
			connection.rollback();
		}

		return result;
	}
}