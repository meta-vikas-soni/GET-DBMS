package operations;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/*
 * Class containing method to get number of child categories
 * 
 */
public class CategoriesInParentCategory {
	private Connection connection;
	private List<CategoriesInParentCategoryPOJO> resultList = new ArrayList<CategoriesInParentCategoryPOJO>();

	/**
	 * Method to get Category title and count of its child categories
	 * 
	 * @return list of POJO consisting data
	 */
	public List<CategoriesInParentCategoryPOJO> getChildCategoryCount()
			throws SQLException {
		connection = JDBCConnection.getDatabaseConnection("e-store");

		// query string
		String queryToGetChildCategoryCount = "SELECT c.category_name, Count(sc.category_id) AS Count_Of_Child"
				+ " FROM category c"
				+ " INNER JOIN sub_category as sc"
				+ " ON c.category_id=sc.category_id"
				+ " GROUP BY c.category_name" + " ORDER BY c.category_name;";

		PreparedStatement preparedStatement = connection.prepareStatement(
				queryToGetChildCategoryCount, ResultSet.TYPE_SCROLL_SENSITIVE,
				ResultSet.CONCUR_UPDATABLE);
		// check if resultSet is empty or not
		if (resultList != null) {
			resultList.clear();
		}

		// executing query
		ResultSet resultSet = preparedStatement.executeQuery();

		if (resultSet.next()) {
			resultSet.previous();
			while (resultSet.next()) {
				resultList.add(new CategoriesInParentCategoryPOJO(resultSet
						.getString("Category_Name"), resultSet
						.getInt("count_Of_Child")));
			}
		} else {
			System.out.println("No Top Category Found !\n");
		}
		connection.close();
		return this.resultList;

	}
}