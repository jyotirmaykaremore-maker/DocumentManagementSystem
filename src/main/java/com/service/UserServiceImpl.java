package com.service;


import java.util.List;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.dao.UserDao;
import com.model.LoginModel;
import com.model.UserDocuments;
import com.model.UserRegistration;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userdao;
	
	
	@Transactional
	@Override
	public void addUser(UserRegistration user) {
		userdao.addUser(user);

	}

	@Transactional
	@Override
	public void deleteUser(int id) {
		// TODO Auto-generated method stub

	}

	@Transactional
	@Override
	public boolean checkEmail(String email) {
		// TODO Auto-generated method stub
		return userdao.checkEmail(email);
	}

	@Override
	public void OTPSend(String email, String otp) {
		userdao.OTPSend(email, otp);
		
	}

	@Transactional
	@Override
	public void updatePassword(String email, String password) {
		userdao.updatePassword(email, password);
		
	}

	@Transactional
	@Override
	public List<UserRegistration> getLogin(LoginModel log) {
		
		return userdao.getLogin(log);
		
	}

	@Transactional
	@Override
	public void updateUser(UserRegistration user, int id) {
		userdao.updateUser(user, id);
		
	}

	@Transactional
	@Override
	public UserRegistration getUserById(int id) {
		
		return userdao.getUserById(id);
	}

	@Override
	public void saveProfile(CommonsMultipartFile profile) {
		userdao.saveProfile(profile);
		
	}
	
	
    @Transactional
	@Override
	public void uploadDocument(List<CommonsMultipartFile> documents, int id) {
		userdao.uploadDocument(documents, id);
		
	}
    
    
    @Transactional
   	@Override
   	public void uploadImage(List<CommonsMultipartFile> image, int id) {
   		userdao.uploadImage(image, id);
   		
   	}
   	
    

    @Transactional
	@Override
	public int countOnlyDocumet(int id) {
		
		return userdao.countOnlyDocumet(id);
	}

    
   
	
	@Transactional
	@Override
	public int countOnlyImage(int id) {
		
		return userdao.countOnlyImage(id);
	}

	
	@Transactional
	@Override
	public List<UserDocuments> getAllDoc( int userid) {
		
		return userdao.getAllDoc( userid);
	}

	@Transactional
	@Override
	public List<UserDocuments> getAllImage(int id) {
		
		return userdao.getAllImage(id);
	}

	
	
	@Transactional
	@Override
	public UserDocuments getDocById(int id) {
		
		return userdao.getDocById(id);
	}

	@Transactional
	@Override
	public List<UserDocuments> recentFileImag(int id) {
		
		return userdao.recentFileImag(id);
	}

	
	@Transactional
	@Override
	public void deleteDocById(int docID) {
		userdao.deleteDocById(docID);
		
	}


}
