package operations;

/*
 * Class for storing results of query - count child categories of parent category
 * 
 */
public class CategoriesInParentCategoryPOJO {

	private String categoryName;
	private int categoryCount;

	public CategoriesInParentCategoryPOJO(String categoryName, int categoryCount) {
		this.categoryName = categoryName;
		this.categoryCount = categoryCount;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public int getCategoryCount() {
		return categoryCount;
	}

}