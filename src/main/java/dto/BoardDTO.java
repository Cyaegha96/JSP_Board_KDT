package dto;

import java.sql.Timestamp;

public class BoardDTO {

	private int seq;
	private String writer;
	private String title ;
	private String contents;
	private String write_date;
	private int view_count;
	public int getSeq() {
		return seq;
	}

	public BoardDTO() {

	}


	public BoardDTO(int seq, String writer, String title, String contents, String write_date, int view_count) {

		super();
		this.seq = seq;
		this.writer = writer;
		this.title = title;
		this.contents = contents;
		this.write_date = write_date;
		this.view_count = view_count;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}

}
