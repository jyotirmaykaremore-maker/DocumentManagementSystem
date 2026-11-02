package com.dao;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.model.LoginModel;
import com.model.UserDocuments;
import com.model.UserRegistration;

@Repository
public class UserDaoImpl implements UserDao {
	
	@Autowired
	private HttpServletRequest request;  // ye basically HTTPSession ke accesss karne keliye banaya

	@Autowired
	private SessionFactory sessionFactory;
	
	@Autowired
	private JavaMailSenderImpl mailsender;   //ye basically getUsername() java ne di method hai jo spring servlet xmll me jo email annd password diya hai unke jo alag se variable hai unhe acces karenga
	
	@Override
	public void addUser(UserRegistration user) {
		
		sessionFactory.getCurrentSession().persist(user);

	}

	@Override
	public void deleteUser(int id) {
		// TODO Auto-generated method stub

	}

	// YE chaeck kar rahi  email hai ya nhi data  base me 
	@Override
	public boolean checkEmail(String email) {
		
		String hql = " select email from UserRegistration where email='"+email+"'";
		
		String result = sessionFactory.getCurrentSession().createQuery(hql, String.class).uniqueResult();
		
		if(result != null) {
			return true;
		}
		
		return false;
		
	}

	// ye particular email pe otp send karta 
	@Override
	public void OTPSend(String email, String otp) {
	
		SimpleMailMessage ob  = new SimpleMailMessage();
		
		ob.setTo(email);
		ob.setFrom(mailsender.getUsername());  //JavaMailSenderImpl mailsender; is class ki java ne provide ki method hai  git me securityn keliye usse ki hai external variable add kar saku isiliye 
		ob.setSubject("OTP For Password ");
		ob.setText("Do not share this OTP with anyone :"+otp);
		
		mailsender.send(ob);
		
	}

	
	// password change 
	@Override
	public void updatePassword(String email, String password) {
		String hql = "Update UserRegistration set password ='"+password+"' where email='"+email+"'";
		
		  sessionFactory.getCurrentSession().createQuery(hql).executeUpdate();
		
	}
	
// user login ka code 
	@Override
	public List<UserRegistration>  getLogin(LoginModel log) {
		
		String hql = "from UserRegistration U where U.email='"+log.getEmail()+"' and U.password='"+log.getPassword()+"'";
		Query query=sessionFactory.getCurrentSession().createQuery(hql);
		
		List<UserRegistration> list = query.list();
		
		List<UserRegistration> list1 =list.size()>0 ? list :null;
		
		return list1;
	}

	// ye update karenga user ki profile
	@Override
	public void updateUser(UserRegistration user , int id) {
		
		String hql = "update UserRegistration set fname='"+user.getFname()+"',email='"+user.getEmail()+"',phone='"+user.getPhone()+"',gender='"+user.getGender()+"',address='"+user.getAddress()+"', filename='"+user.getFilename()+"'  where id="+id+"";
		
		sessionFactory.getCurrentSession().createQuery(hql).executeUpdate();
		
	}

	// particular id se database table me serow nikalnega user ki 
	@Override
	public UserRegistration getUserById(int id) {
		
		 return sessionFactory.getCurrentSession().get(UserRegistration.class, id);	
	}
	
	
	//ye jo profile image hai usse store karenga iss particular location pe 

	@Override
	public void saveProfile(CommonsMultipartFile profile) {

		    try {
		        // Upload folder ka path
		        String uploadPath = "D:\\upload";

		        File folder = new File(uploadPath);

		        // Folder nahi hai toh create karna vaise to hamne manully bana hai but agar bymistake vo uploads folder delete hua to ye automaticlly banan denga 
		        if (!folder.exists()) {
		            folder.mkdirs();
		        }

		        // File upload check
		        if (profile == null || profile.isEmpty()) {
		            return;
		        }

		        // File name lena
		        String filename = new File(profile.getOriginalFilename()).getName();// ye ky karta file ka name denga uska extension nhi qki .getName() lagaya to

		        // Image ko folder mein save karna
		        File destination = new File(folder, filename);

		        try (FileOutputStream out = new FileOutputStream(destination)) {
		        	
		            out.write(profile.getBytes());
		        }

		    } catch (Exception ex) {
		        ex.printStackTrace();
		    }
		}

	
	// documents ko upload karenge ki code hai
	@Override
	public void uploadDocument(List<CommonsMultipartFile> documents, int id) {
		
		Session session  = sessionFactory.getCurrentSession();
		
		UserRegistration user = session.get(UserRegistration.class, id);
		
		// agar user null ho to vo runtime exception denga
		if(user == null) {
			throw new RuntimeException("User Not Found");
		}
		
		 // Check karenge ki documents ki list empty toh nahi hai
	    if (documents == null || documents.isEmpty()) {
	        throw new RuntimeException("Please select at least one document");
	    }
		
		
		// D drive ka path banayeneb is folder me documents store honge apne   
		
		File folder = new File("D:\\DocumentsFolder\\");
		
		// ya dekhenge agar folder pahile hai ya nhi nhi honga to mkdir() se banayenge folder
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		
		// for loop banayenge jo list me documents aye unhe separate karne keliya 
		
		for(CommonsMultipartFile file :documents) {
			
			// ya check karenge file kitni hai agr nhi hongi to continue karenga 
			if(file == null  || file.isEmpty()) {
				continue;
			}
			
			//try catch me likhenge runtime exception a sakta hai karke 
			
			try {
				
				
				// original file ka name lenge 
				String originalFile = new File(file.getOriginalFilename()).getName();
				
				// ab ham unique file name banayege taki d drive confuse na ho data base me 
				//unique id se confusion nhi honga but drive honga vo same nam se file nhi banae deta isiliye
				
				String uniquefile = UUID.randomUUID().toString()+ "_"+originalFile;
				
				// file ke original name se D drive pe store karenga 
				
				File destination = new File(folder, uniquefile);  
				
				
				// jo loops se file nikale unhe transfer karenge destination pe 
				file.transferTo(destination);
				
				// ab database me us file ko save karenga 
				UserDocuments doc = new UserDocuments();
				
				doc.setFileName(originalFile); // file ka name jo nikala vo rakha sirf dashboar pe dikhne keliye 
				
				doc.setUniqueFilename(uniquefile); // unique file name store karenga and isse drive me file upload karenga save karnekeliye 
				
				doc.setFileType("DOCUMENT"); // documets ka type static rakha hai 
				
				doc.setUploadDate(new Date()); //upload karte time ka current data and time ke sath upload karenga data base me automatically
				
				doc.setUser(user); // forign key ke jariya jiss user ne upload kiya uski id ayenge 
				
				session.save(doc); // object ko save kiya data base me 
				
				
			}catch(Exception ex) {
				throw new RuntimeException("Document Upload Failed "+ex.getMessage()+ex);
			}
			
			
		}
		
	}
	
	
	
	// ye image upload karenga ka code hai 
		@Override
		public void uploadImage(List<CommonsMultipartFile> images, int id) {
			
			Session session = sessionFactory.getCurrentSession();
			
			UserRegistration user  = session.get(UserRegistration.class, id);
			
			
			if(user == null) {
				throw new RuntimeException("User Not Found");
			}
			
			
			// path denge folder ka 
			
			String folderPath= "D:\\DocumentsFolder\\Images\\";
			
			
			File folder = new File(folderPath);
			
			if(!folder.exists()) {
				folder.mkdirs();
			}
			
			
			//loop  image list ka
			
			for(CommonsMultipartFile image : images) {
				
				if(image == null || image.isEmpty()) {
					continue;
				}
				
				
				String contentType = image.getContentType(); // image content type denngi konse extension ki hai to
				
				if(contentType == null ||  !(contentType.equals("image/jpeg") ||  contentType.equals("image/png") || contentType.equals("image/webp"))) {
					
					throw new RuntimeException("Only JPG, PNG and WEBP images are allowed!");
				}
				
				
				String originalName = image.getOriginalFilename();
				
				String extension = originalName.substring(originalName.lastIndexOf("."));
				
				String uniqueName = UUID.randomUUID().toString()+extension;
				
				
				// ab distination denge ye jo unique file name banaya use kis path pe transfer karna hai
				
				File destination  = new File(folder, uniqueName);
				
				try {
					
					image.transferTo(destination); // ye folder me gaii
					
					UserDocuments doc = new UserDocuments(); // ye data base me ja rayegi
					
					doc.setFileName(originalName);
					doc.setUniqueFilename(uniqueName);
					doc.setFileType("IMAGE");
					
					doc.setUploadDate(new Date());
					
					doc.setUser(user);
					
					session.save(doc); // yaha save ho gai image data base and folder me d drive ke 
					
				}catch(Exception ex) {
					throw new RuntimeException("Unable to save image :"+ex);
				}
				
			}
			
			
		}
	
	

	// ye only documents count keliye hai
	@Override
	public int countOnlyDocumet(int id) {

	    String hql = "select count(*) from UserDocuments "
	               + "where fileType='DOCUMENT' and user_id=" + id;

	    Long count = (Long) sessionFactory.getCurrentSession()
	                    .createQuery(hql).uniqueResult();        // ye long me deta hai result

	    return count.intValue(); // iske int me convert kiye 
	}
	


	
	// total kitni image hai particular user ki vo count karenga 
		@Override
		public int countOnlyImage(int id) {
			
			String hql = "select count(*) from UserDocuments "
		               + "where fileType='IMAGE' and user_id=" + id;

		    Long count = (Long) sessionFactory.getCurrentSession()
		                    .createQuery(hql).uniqueResult();        // ye long me deta hai result

		    return count.intValue(); // iske int me convert kiye 
		}
		
		
		// user documents me ek partucular user ne kitne document uploads kiye hai sirf unhi ka data dikhenga 

		@Override
		public List<UserDocuments> getAllDoc( int userid) {
			
			String hql = "from UserDocuments where user_id="+userid+" and fileType='DOCUMENT'";
			
			List<UserDocuments> list = sessionFactory.getCurrentSession().createQuery(hql).list();
			return list;
		}

		
		
		// userDocuments me ek particular user ne kitne images upload ki hai unki grid me images dikhenga 
		@Override
		public List<UserDocuments> getAllImage(int id) {
			
			String hql = "from UserDocuments where user_id="+id+"and fileType='IMAGE'";
			
			List<UserDocuments> list  = sessionFactory.getCurrentSession().createQuery(hql).list();
			return list;
		}

		
		// particular user ki id se hame vo image ko viw karenge jo save hai unique name se drive me (Image section ki hai)
		@Override
		public UserDocuments getDocById(int id) {
			
			String hql = " from UserDocuments where docID="+id+"";
			UserDocuments user = (UserDocuments) sessionFactory.getCurrentSession().createQuery(hql).uniqueResult();
			return user;
		}

		
		// recently upload wale sirf 5 file dikhayenge  uske id ke according
		@Override
		public List<UserDocuments> recentFileImag(int id) {
			String hql  ="from UserDocuments where user_id="+id+"order by uploadDate desc";
			
			List<UserDocuments> recent = sessionFactory.getCurrentSession().createQuery(hql).setMaxResults(5).list();  //max 5 entry show karenge desecnding order me dqate wise
			return recent;
		}

		
		// partucular id se uss document ko delete karenge 
		@Override
		public void deleteDocById(int docID) {
		 UserDocuments doc = sessionFactory.getCurrentSession().get(UserDocuments.class, docID);
		 
		 sessionFactory.getCurrentSession().remove(doc);
			
		}

		
	
	
	
	

}
