package operations;

/*
 * POJO Class for storing results of OrderDetails
 * 
 */
public class OrderDetailsPOJO {

	private String orderId;
	private String orderDate;
	private String orderAmount;

	public OrderDetailsPOJO(String orderId, String orderDate, String orderAmount) {
		this.orderId = orderId;
		this.orderDate = orderDate;
		this.orderAmount = orderAmount;
	}

	public String getOrderId() {
		return orderId;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public String getOrderAmount() {
		return orderAmount;
	}

}