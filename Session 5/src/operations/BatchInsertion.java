package operations;

import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/*
 * Class containing method to insert batch records
 * 
 */
public class BatchInsertion {
	private int[] productIdList = { 4, 4 };
	final int batchSize = 5;

	private Connection connection;

	/**
	 * Method to insert Batch data to the images table
	 * 
	 * @return count of record inserted
	 */
	public int insertBatchIntoImageTable() throws SQLException {

		connection = JDBCConnection.getDatabaseConnection("e-store");

		int result = 0;
		String queryForImageBatchInsertion = "INSERT INTO prod_image(prod_id,prod_image_path) VALUES (?,?)";

		try {

			PreparedStatement preparedStatement = connection
					.prepareStatement(queryForImageBatchInsertion);
			connection.setAutoCommit(false);

			for (int id : productIdList) {
				preparedStatement.setInt(1, id);
				preparedStatement.setString(2, "urlImage" + id + "_"
						+ getCurrentDate());
				preparedStatement.addBatch();
			}
			int[] noOfRowsUpdated = preparedStatement.executeBatch();
			// executing remaining records
			result = noOfRowsUpdated.length;
			connection.commit();
		} catch (SQLException se) {
			System.out.println("SQL Exception occurred !" + se.getErrorCode()
					+ " : " + se.getMessage());
			connection.rollback();
		}

		connection.close();
		return result;
	}

	private String getCurrentDate() {

		DateTimeFormatter dtf = DateTimeFormatter
				.ofPattern("yyyyMMddHHmmssSSS");
		LocalDateTime now = LocalDateTime.now();

		return dtf.format(now);
	}
}