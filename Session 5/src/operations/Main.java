package operations;

import java.sql.SQLException;
import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

public class Main {

	public static void menu() {
		System.out.println("Menu :\n" + "1. Get Order Information Of User\n"
				+ "2. Insert Batch Data in Image Table\n"
				+ "3. Delete Products Which are not ordered from one year\n"
				+ "4. Display Top Category Title with child counts\n"
				+ "5. EXIT\n");
	}

	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in);
		int choice = 0;
		while (true) {
			menu();
			System.out.println("Enter your choice : ");
			choice = scan.nextInt();

			switch (choice) {

			case 1:
				OrderDetails orderDetails = new OrderDetails();
				System.out.println("\nEnter user id : ");
				try {
					List<OrderDetailsPOJO> resultList = orderDetails
							.getOrderDetailsOfUser(scan.nextInt());
					// if there are no records, empty list is returned
					if (resultList == null)
						break;

					System.out.println("Number Of Records :"
							+ resultList.size() + "\n");
					for (OrderDetailsPOJO value : resultList) {
						System.out.println("ORDER ID: " + value.getOrderId());
						System.out.println("ORDER DATE: "
								+ value.getOrderDate());
						System.out.println("ORDER AMOUNT: "
								+ value.getOrderAmount());
						System.out
								.println("-------------------------------------------------------\n");
					}
				} catch (SQLException e) {
					System.out.println(e.getMessage());
				}
				break;

			case 2:
				BatchInsertion batchInsertion = new BatchInsertion();
				try {
					Integer result = batchInsertion.insertBatchIntoImageTable();
					if (result == null) {
						break;
					}
					System.out.println(result
							+ " Rows added as batches of 5 images !\n");
					System.out
							.println("-------------------------------------------------------\n");

				} catch (NullPointerException e) {

				} catch (SQLException e) {
					System.out.println(e.getMessage());
				}
				break;

			case 3:
				DeleteProduct productDeletion = new DeleteProduct();
				try {
					Integer result = productDeletion
							.deleteProductsNotPurchased();
					if (result == null) {
						break;
					}
					System.out.println(result
							+ " Products Status Changed to Inactive !\n");
					System.out
							.println("-------------------------------------------------------\n");

				} catch (SQLException e) {
					System.out.println(e.getMessage());
				}
				break;

			case 4:
				CategoriesInParentCategory categoriesInParentCategory = new CategoriesInParentCategory();
				List<CategoriesInParentCategoryPOJO> resultList;
				try {
					resultList = categoriesInParentCategory
							.getChildCategoryCount();
					// if there are no records, empty list is returned
					if (resultList == null)
						break;

					for (CategoriesInParentCategoryPOJO val : resultList) {
						System.out.println(val.getCategoryName() + "  "
								+ val.getCategoryCount());
					}
					System.out
							.println("-------------------------------------------------------\n");
				} catch (SQLException e) {
					System.out.println(e.getMessage());
				}

				break;

			case 5:
				System.out.println("Okay, Bye!!");
				System.exit(0);

			default:
				System.out.println("Invalid choice entered !\n");

			}
		}
	}
}
