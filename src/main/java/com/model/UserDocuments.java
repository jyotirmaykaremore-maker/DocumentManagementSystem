package com.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
public class UserDocuments {

	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private int docID;
	private String fileType;
	private String fileName; // ye originale file name store karenga 
	private String uniqueFilename ; // ye unique file name banayenga taki laptop ki drive confuse na ho isiliye 
	

	// file upload hone ki date and time 
	@Temporal(TemporalType.TIMESTAMP)
	private Date uploadDate;
	
	
	// ek user ke multiple document or images ho sakte  forign key hai lagai
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id",nullable = false)    // yaha pe jo "user_id" liye waha kuch bhi likh sakte qki ye naye table me banaega alagse jaise UserRegistration table me id column hai same lene ki jarurat nhi
	private UserRegistration user;


	public String getUniqueFilename() {
		return uniqueFilename;
	}


	public void setUniqueFilename(String uniqueFilename) {
		this.uniqueFilename = uniqueFilename;
	}

	
	
	public int getDocID() {
		return docID;
	}


	public void setDocID(int docID) {
		this.docID = docID;
	}


	public String getFileType() {
		return fileType;
	}


	public void setFileType(String fileType) {
		this.fileType = fileType;
	}


	public String getFileName() {
		return fileName;
	}


	public void setFileName(String fileName) {
		this.fileName = fileName;
	}


	public Date getUploadDate() {
		return uploadDate;
	}


	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}


	public UserRegistration getUser() {
		return user;
	}


	public void setUser(UserRegistration user) {
		this.user = user;
	}
	
	
	
	
	
}
