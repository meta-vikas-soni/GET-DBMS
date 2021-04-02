package operations;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/*
 * Class to retrieve information of orders from user Id
 * 
 */
public class OrderDetails {
	private Connection connection;
	private List<OrderDetailsPOJO> resultList = new ArrayList<OrderDetailsPOJO>();

	/**
	 * Method to get the Orders details of the given user Id
	 * 
	 * @param user
	 *            Id as integer
	 */
	public List<OrderDetailsPOJO> getOrderDetailsOfUser(int userId)
			throws SQLException {

		connection = JDBCConnection.getDatabaseConnection("e-store");
		// query format
		String queryToGetOrderDetails = "SELECT o.order_id, o.order_timestamp, c.total_price"
				+ " FROM Orders as o INNER JOIN Cart as c ON c.cart_id=o.cart_id WHERE c.item_status LIKE \"%Shipped%\" AND o.user_id="
				+ userId + " ORDER BY o.order_timestamp DESC";

		PreparedStatement preparedStatement = connection.prepareStatement(
				queryToGetOrderDetails, ResultSet.TYPE_SCROLL_SENSITIVE,
				ResultSet.CONCUR_UPDATABLE);
		// check if resultSet is empty or not
		if (resultList != null) {
			resultList.clear();
		}
		// executing the query
		ResultSet resultSet = preparedStatement.executeQuery();

		if (resultSet.next()) {
			resultSet.previous();
			while (resultSet.next()) {
				resultList.add(new OrderDetailsPOJO(resultSet
						.getString("o.order_id"), resultSet
						.getString("o.order_timestamp"), resultSet
						.getString("c.total_price")));
			}
		} else {
			System.out.println("No Orders information for this User !\n");
		}

		connection.close();
		return this.resultList;
	}
}