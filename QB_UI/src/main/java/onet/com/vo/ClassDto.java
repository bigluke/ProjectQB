package onet.com.vo;

import java.util.Date;

/*민지 10.12-클래스 테이블 DTO 작성*/

public class ClassDto {
	
	private String class_name;
	private String member_id;
	private Date class_start_date;
	private Date class_end_date;
	private int class_enable;
	
	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public Date getClass_start_date() {
		return class_start_date;
	}
	public void setClass_start_date(Date class_start_date) {
		this.class_start_date = class_start_date;
	}
	public Date getClass_end_date() {
		return class_end_date;
	}
	public void setClass_end_date(Date class_end_date) {
		this.class_end_date = class_end_date;
	}
	public int getClass_enable() {
		return class_enable;
	}
	public void setClass_enable(int class_enable) {
		this.class_enable = class_enable;
	}
	
	
}
