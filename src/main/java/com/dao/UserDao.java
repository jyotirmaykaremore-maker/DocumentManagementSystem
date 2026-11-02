package com.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.model.LoginModel;
import com.model.UserDocuments;
import com.model.UserRegistration;

public interface UserDao {

	public void addUser(UserRegistration user);
	
	public void deleteUser(int id);
	
	public UserRegistration getUserById(int id); // isse ky honga particular id se user milengea
	
	public boolean checkEmail(String email);  // ye c heck karenga data base me ye email exist karta hai nhi 
	
	public void OTPSend(String email, String otp); // particular email pe otp send karta ye  
	
	public void updatePassword(String email, String password); // particular email pe password change karengi
	
	public List<UserRegistration> getLogin(LoginModel log); // ye user ko system me login karne keliye hai
	
	public void updateUser(UserRegistration user, int id); // ye user ki details ko update karenga
	
	public void saveProfile(CommonsMultipartFile profile);  // ye basically jo profile photo lagai usse project ke ek folder me store karne keliye hai method

	public void uploadDocument(List<CommonsMultipartFile> documents, int id); // ye basically documents ko upload karne keliye use karenge
	
	public void uploadImage(List<CommonsMultipartFile> image, int id);  // ye basically images ko upload karenga database and drive isme bhi same concept document upload ka 

	
	public int countOnlyDocumet(int id);// ye basically kitne document hai data base me jinta type document hai vo dengi
	
	public int countOnlyImage(int id); // ye sirf total kitni image hai unhe count karengi
	
	
	public List<UserDocuments> getAllDoc( int userid); // baiscally sabhi document ki list denga UserDocument table ki but particular user wise
	
	public List<UserDocuments> getAllImage(int id);  // basically sabhi images ki list denga userdocuemnet table ki but but particular user wise useke login id ke acording 
	
	public UserDocuments getDocById(int id); // partucular user ke id ke according documents milenga
	
    public  List<UserDocuments> recentFileImag(int id); // receptly kitne file ya iamge upload hui vo dikhenge  sirf ek particular user ke hi
    
    public void deleteDocById(int docID); // particular id se document ko delete karenge 
    
	
	
}
