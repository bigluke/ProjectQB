package onet.com.admin.dao;

import java.util.List;

import onet.com.vo.CategoryDto;

public interface AdminDao {
	/*���� - 10.08 �����з����� ����*/
	public List<CategoryDto> lgCategoryList();
	public List<CategoryDto> mdCategoryList();
	public List<CategoryDto> smCategoryList();
	
	/*���� - 10.08 �����з����� ����*/
}
