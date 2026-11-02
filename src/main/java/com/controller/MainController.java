package com.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.model.LoginModel;
import com.model.UserDocuments;
import com.model.UserRegistration;
import com.service.UserService;

@Controller
public class MainController {
	
	@Autowired
	private UserService userservice;

	// login page pe jane ki mapping 
	@RequestMapping("LoginForm")
	public String goToLoginForm() {
		return "Login";
	}
	
	// registration form ki mapping 
	@RequestMapping("register")
	public String getRegisterForm() {
		return "RegistrationForm";
	}
	
	// forget password ki mapping 
	
	@RequestMapping("forgotPassword")
	public String gotoEmailForm( HttpSession session) {
		
		session.removeAttribute("emailget");
		return "EmailForm";
	}
	
	// email check karenge exist kara rha hai ya nhi agr kar raha hai to uspe otp send karenge nhi to msg show karenge 
	@RequestMapping(value="sendOtp", method= RequestMethod.POST)
	public String getOtpOnRgeisterEmail(@RequestParam("email") String email, HttpSession session) {
		
		boolean found = userservice.checkEmail(email);
		
		if(found) {
			Random getOtp = new Random();
			
			String otp = String.valueOf(getOtp.nextInt(99999)+100000);
			
			session.setAttribute("Otp", otp);
			session.setAttribute("emailget", email);
			session.setAttribute("OtpMsg", "OTP Successfully Send");
			userservice.OTPSend(email, otp);
			return "EmailForm";
		}
			session.setAttribute("emailmsg", "Please Enter Register Email ID");
		    return "redirect:/forgotPassword";
	}
	
	
	// jo eamil pe otp aya usse verify karenge session ke through
	
	@RequestMapping(value ="verifyOtp", method=RequestMethod.POST)
	public String getOtp(@RequestParam ("otp") String otp ,HttpSession session) {
		
	   String emailOtp = (String)session.getAttribute("Otp");
	   
	   if(otp.equals(emailOtp)) {
		   
		   session.setAttribute("OtpVerifedSucc", "OTP verified successfully");
		   return "ChangePasswordForm";
	   }
	   
	   session.setAttribute("wrongOtp", "Please Enter a Valid OTP");
	   return "EmailForm";
	}
	
	// new password and confirm password ka check karenge agar dono same and barabr hai to usse password ko update karenge agar nhi to error show karenge 
	@RequestMapping(value="resetPassword", method=RequestMethod.POST)
	public String resetPassword(@RequestParam("newPassword") String newPassword , @RequestParam("confirmPassword") String confirmPassword ,HttpSession session ) {
		
		String email =(String) session.getAttribute("emailget");
		
		if (newPassword.equals(confirmPassword)) {
			
			userservice.updatePassword(email, confirmPassword);
			
			session.setAttribute("passwordChange", "Password Changed Successfully");
			
			return "Login";
		}
		
		session.setAttribute("WrongPass", "New Password And Confirm Password not Match");
		return "ChangePasswordForm";
		
	}
	
	
	// ye mapping basically registration page ke uper wali email verification keliye hai
	
	@RequestMapping(value="RegisterSendOtp" , method = RequestMethod.POST)
	public String sendOtpToEmail(@RequestParam("email") String email, HttpSession session) {
		
		boolean checkEmail = userservice.checkEmail(email);
		
		if(checkEmail) {
			session.setAttribute("EmailExist", "Email Already Register! Try with another email");
			return "redirect:/register";
		}
		
		Random generate  = new Random();
		String ottp = String.valueOf(generate.nextInt(99999)+100000);
		
		userservice.OTPSend(email, ottp);
		
		// abhi session me otp and  and email ko store karenge 
		session.setAttribute("emailStore", email);
		session.setAttribute("OtpStore", ottp);
		session.setAttribute("otpMsg", "OTP successfully send to your email!");
		return "redirect:/register";
	}
	
	// registration page ka hi hai otp verificatin ki mapping 
	@RequestMapping(value="RegisterVerifyOtp", method=RequestMethod.POST)
	public String getOtpVerify(@RequestParam("otp") String otp, HttpSession session) {
		
		String genrateOtp = (String) session.getAttribute("OtpStore"); // ye otp get kiya session se
		String email =(String) session.getAttribute("emailStore"); // email get kiya session se
		
		// abhi ham dekhenge agar email and otp ye agar page reload hua by mistake to  email and otp gayab huaye to verify nhi hona chiye
		if(genrateOtp == null || email == null) {
			session.setAttribute("otpNotMatch", "Email is clear please enter email and resend Otp!");
			return "redirect:/register";
		}
		
		
		if(otp.equals(genrateOtp)) {
			session.setAttribute("OtpMatch", "OTP verify successfully!");
			return "redirect:/register";
		}
		
		session.setAttribute("otpNotMatch", "Please enter valid OTP!");
		return "redirect:/register";
	}
	
	// jab page agr galti se relaod hua to sabhi data gayab hoga matlb sessions ka uski mapping 
	
	@RequestMapping(value="clearOtpOnReload", method=RequestMethod.GET)
	public String IfRealoadRegisterPage( HttpSession session) {
		
		// sabi jo session banaye unhe remove karenge registration page keliye
		
		session.removeAttribute("EmailExist");
		session.removeAttribute("emailStore");
		session.removeAttribute("OtpStore");
		session.removeAttribute("otpMsg");
		session.removeAttribute("OtpMatch");
		session.removeAttribute("otpNotMatch");
		
		
		
		return "RegistrationForm";
	}
	
	
	// registration page se login page gaye to and waps registration page aye to data remove hona chahiye 
	@RequestMapping("goToLoginPage")
	public String goToLoginFormRegister(HttpSession session) {
		
		// sabhi session ko remove karenge 
		
		session.removeAttribute("EmailExist");
		session.removeAttribute("emailStore");
		session.removeAttribute("OtpStore");
		session.removeAttribute("otpMsg");
		session.removeAttribute("OtpMatch");
		session.removeAttribute("otpNotMatch");
		session.removeAttribute("SuccessRegister");
		
		return "redirect:/LoginForm";
	}
	
	// abhi data ko data base me insert karne ki mapping hai 
	@RequestMapping(value="registration", method = RequestMethod.POST)
	public String getRegister(@ModelAttribute UserRegistration user, HttpSession session) {
		
		userservice.addUser(user);
		
		session.setAttribute("SuccessRegister", "User Registered Successfully");
		return "redirect:/goToLoginPage";
	}
	
	
	// user ne agar email password dalke login kiya to ky ayenga vo hai 
	@RequestMapping(value="loginpass", method= RequestMethod.POST)
	public String goTODashboard(LoginModel log, HttpSession session , Model model) {
		
		List<UserRegistration> list = userservice.getLogin(log); // ye login check kar raha 
		
		if(list != null &&  !list.isEmpty()) {
			
			UserRegistration user = list.get(0); //particular column me se login user ka fname denga
			
			
			session.setAttribute("emailID", log.getEmail());
			
			session.setAttribute("username",user.getFname());
			
			session.setAttribute("ID", user.getId());  // ye matlb jab profile update kar rahe to kaise karenge isilye isse session me store kiya
			
			model.addAttribute("user",user);
			
			return "redirect:/goTODashboard";
			
		}else {
			
			session.setAttribute("LoginFailed", "Login Failed please enter valid credentail");
			
			return "redirect:/goToLoginPage";
			
			
		}
	}
	
	
	// update karenge profile ko uski mapping 
	@RequestMapping(value="updateProfile", method=RequestMethod.POST)
	public String updateProfile(@RequestParam ("fname") String fname,
			@RequestParam ("email") String email,
			@RequestParam ("phone") String phone,
			@RequestParam ("gender") String gender,
			@RequestParam ("address") String address,
			@RequestParam ("profile") CommonsMultipartFile profile,HttpSession session) {
		
		int id = (int) session.getAttribute("ID"); //  ye jo login kara email id or password se uska id stor kiya session and usse get kiya
		
		
		
		String filename = profile.getOriginalFilename();
		
		if (filename == null && filename.isEmpty()) {
			filename = "ByDefaultProfile.jpg";
		}
		
		
		// abh vo profile isme store honi chahiye project me uploads folder me 
		
		userservice.saveProfile(profile); // iss profile ko ye folder me store karenga 
		
		UserRegistration user = new UserRegistration();
		
		user.setFname(fname);
		user.setEmail(email);
		user.setPhone(phone);
		user.setGender(gender);
		user.setAddress(address);
		user.setFilename(filename);
		
		// yaha pe jis email se login kiya uska email ka session and jo naya enter email profile uska session ka email jo niche ki mapping se liya hai 
		String verifiedEmail = (String) session.getAttribute("profileOtpEmail"); // naya wala email jo profile email enter kiya gaya hai
		
		boolean verified = Boolean.TRUE.equals(session.getAttribute("profileOtpVerified")); // ye boolean wala session verified tru hai ya false , isko aisa likha agr session set nhi hua to null ayenga or vo null pointer exception de sakta hai isiliye
		
		String oldEmail = (String) session.getAttribute("emailID"); // jis email se login huye vo old email upar ki mapping se sessin liya 
		
		// 
		
		//agar pahilse jo email hai and jo purana email hai ye same hai to condistion false hogi ! wajah se verifed karne ki jarurat nhi
		
		if(!email.equalsIgnoreCase(oldEmail) ) {
			
			/* Agar user ne apna email change kiya hai, toh check karenge ki OTP verify hua hai ya nahi,
			 OTP verification ke liye email session mein available hai ya nahi,
			 aur jis email par OTP verify hua tha, woh current email se match karta hai ya nahi.
			 Agar inmein se koi bhi condition true hui, toh profile update nahi hogi
			 aur user ko LoginForm page par redirect kar denge. */
			
			if(!verified || verifiedEmail== null || !verifiedEmail.equalsIgnoreCase(email)) {
				
				return "redirect:/LoginForm";
			}
			
		}
		
		// upar condition false hongi tabhi update honga data 
		
		userservice.updateUser(user, id); // update hua data but update hone ke bad firse nhi dikhnega profile me to hame data nikalna padenga pahile
		
		
		
		// step -2
		
		UserRegistration udpateuser = userservice.getUserById(id);  //jo session se nikali id hai vo dalenga 
		
		// waps same user wala session banayeneg update data denge  taki jsp me dikh sake 
		
		session.setAttribute("user", udpateuser); 
		
		// Welcome name aur email bhi update karenge
		session.setAttribute("username", udpateuser.getFname());
		session.setAttribute("emailID", udpateuser.getEmail());
		
		return "redirect:/goTODashboard"; // dashboard ko return kar denge
		
		
	}
	
	// profile  page var new email var otp chi mapping  ye json return kar raha matlb String
	
	@RequestMapping(value="/profile/sendOtp", method=RequestMethod.POST)
	@ResponseBody
	public String sendProfileOtp(@RequestParam("email")String email, HttpSession session) {
		
		Random number  = new Random();
		
		String otp = String.valueOf(number.nextInt(99999)+100000);
		
		
		// ek check lagyenge ky email ye pahile exist to nhi karta naya email enter wala 
		if(userservice.checkEmail(email)) {
			session.setAttribute("emailHaiYeRegister","Email Already Register");
			return "redirect:/goTODashboard";
		}
		
		// Otp and email ko session me store karenge
		
		session.setAttribute("profileOtp", otp);
		session.setAttribute("profileOtpEmail", email);
		session.setAttribute("profileOtpVerified", false);
		
		userservice.OTPSend(email, otp);
		
		return "OTP Sent Successfully"; 
	}
	
	// new Email pe aya otp verified karne ki mapping 
	
	@RequestMapping(value="/profile/verifyOtp", method=RequestMethod.POST)
	@ResponseBody
	public String verifyProfileOtp(@RequestParam("email")String email, @RequestParam("otp")String otp,HttpSession session) {
		
		String saveOtp = (String) session.getAttribute("profileOtp");
		
		String saveEmail = (String) session.getAttribute("profileOtpEmail");
		
		if(saveOtp != null && saveEmail != null && saveOtp.equals(otp) && saveEmail.equalsIgnoreCase(email) ) {
			
			session.setAttribute("profileOtpVerified", true);
			return "OTP Verified";
		}
		
		return "Invalid OTP";
	}
	
	
	// upload document ki mapping hai 
	@RequestMapping(value="/uploadDocument", method= RequestMethod.POST)
	public String uploadDocument(@RequestParam("documents") List<CommonsMultipartFile> documents, HttpSession session , RedirectAttributes redirectAttribute) {
		
		try {
			// login user ki id lenge 
			Integer id  = (Integer) session.getAttribute("ID");
			
			// agar id ye null hai to login page pe redirect honge 
			if(id == null) {
				return "redirect:/goToLoginPage";	
			}
			
			// document ko upload karenge 
			userservice.uploadDocument(documents, id);
			
			redirectAttribute.addFlashAttribute("msg", "Document uploaded successfully");
			
		}catch(Exception ex) {
			ex.printStackTrace();
			
			redirectAttribute.addFlashAttribute("error", "Document upload Failed");
		}
		
		return "redirect:/goTODashboard";
		
	}
	
	
	// upload image ki mapping  // document and image ki same hai mapping and bss halka minnor dao differnt hai
	
	@RequestMapping(value="/uploadImage", method=RequestMethod.POST)
	public String uploadImage(@RequestParam("images") List<CommonsMultipartFile> images, HttpSession session , RedirectAttributes redirectAttribute) {
		
		try {
			
			Integer id = (Integer) session.getAttribute("ID");
			
			if(id == null) {
				return "redirect:/goToLoginPage";
			}
			
			userservice.uploadImage(images, id);
			
			redirectAttribute.addFlashAttribute("msg", "Image uploaded successfully");
			
		}catch(Exception ex) {
			ex.printStackTrace();
			
			redirectAttribute.addFlashAttribute("error", "Image upload Failed");		
		}
		
		return "redirect:/goTODashboard";
	}
	
	
	
	
	
	
	// ek dashboar ki mapping get banai padengi taki vo redirectAttribute ka flass
	// dikh sake

	@RequestMapping(value = "/goTODashboard", method = RequestMethod.GET)
	public String showDashboard(HttpSession session, Model model) {

		Integer id = (Integer) session.getAttribute("ID");

		if (id == null) {
			return "redirect:/goToLoginPage";
		}

		UserRegistration user = userservice.getUserById(id);
		
		int countDocument = userservice.countOnlyDocumet(id); // document count hai 
		
		int countImage = userservice.countOnlyImage(id); // Image count hai 
		
		int totalFile = countDocument + countImage; // document and image ka count hai  addition
		
		model.addAttribute("documentCount", countDocument); // total documnet ka count hai
		
		model.addAttribute("imageCount", countImage); // total documnet ka count hai
		
		model.addAttribute("totalCount", totalFile); // total documnet ka count hai

		model.addAttribute("user", user); // user valid kartas ky jo login uer hai vohi hai n 
		
		List<UserDocuments> documents = userservice.getAllDoc(id); // particular usr ne kitne document upload kiya hai vo denkha usse model me dalke loop me chahlayenge 
		
		model.addAttribute("documents", documents); // model me add karenge and loop se print karenge
		
		List<UserDocuments> images = userservice.getAllImage(id); // partucular jo login user hai uske id ke according kitne images upload ki hai usne uaki list
		
		model.addAttribute("images",images);  // model me add karenga and print karenge loop se 
		
		List<UserDocuments> recent = userservice.recentFileImag(id); // iss particular id ne kitne file upload kiye usme se recent 5 show karenga list
		
		model.addAttribute("recentUploads",recent);

		return "dashboard";
	}

	
	// yaha ham jo image aai hai usse show karne keliye getMapping likhenge requstMapping bhi likh sakte uske liye methed get lenga padenga 
	
	@GetMapping("/viewImage")
	public void viewImage(@RequestParam("id") int id, HttpServletResponse response)throws IOException {
		
		UserDocuments document = userservice.getDocById(id);
		
		String uniqfilename = document.getUniqueFilename(); // unique filename lenge qki drive me ussiname se store hai n isiliye 
		
		File file  = new File("D:\\DocumentsFolder\\Images", uniqfilename);  // ye vo path hai jaha hamne uniqe name se upload ki hai file 
		
		response.setContentType("image/jpeg"); // browser ko bata rahe hai ye image hai karke type ki
		
		FileInputStream input = new FileInputStream(file);  // image ko read karke brower ko bhej rahe hai
		
		byte[] data  = new byte[(int) file.length()];
		
		input.read(data);// read kiye iamge ko
		
		response.getOutputStream().write(data);
		
		input.close();
		
	}
	
	
	// particular ide se partucular document ko download karne ki mapping 
	@GetMapping("/downloadDocument")
	public void downloadDoc(@RequestParam("id") int id, HttpServletResponse response) throws IOException {
		
		UserDocuments document  = userservice.getDocById(id); // particular document nikalenge ide se
		
		String uniquefile = document.getUniqueFilename(); // ussse id pe document ka unique name 
		
		// yaha pe apne image and document /image alag alag path me hai to file type se pata karenge agar image ho 
		//to alag path lenege and docuemnt ho to alag
		
		String path = "";
		
		if(document.getFileType().equals("DOCUMENT")) {
			
			path = "D:\\DocumentsFolder";
			
		}else if(document.getFileType().equals("IMAGE")) {
			
			path = "D:\\DocumentsFolder\\Images";
		}
		
		
		
		
		File file = new File(path,uniquefile);  //  drive se is file ka path lenege 
		
		response.setContentType("APPLICATION/OCTET-STREAM");  //browser ko downlaod karne keliye bolenge 
		
		response.setHeader("Content-Disposition","attachment;filename=\"" +document.getFileName()+"\"");
		
		
		ServletOutputStream out = response.getOutputStream();  // ye document and images binary files hai n uske liye hai , printwriter ye text ko write karne keliye hai isiliye nhi liya usee
		
		
		//file read karke download karwayenge 
		
		FileInputStream input  = new FileInputStream(file);
		
		int i;
		
		while((i= input.read()) != -1) {  // byte read kar raha agar isse baher likhe to infinity loop ki tarah download karenge 
			out.write(i);                 // int i = input.read() isko bahr nhi likhe loop ki condition me likhhte nhi infinite ho jayenga
		}
		
		input.close();
		out.close();
		
	}
	
	
	// document and image ko delete karne ki mapping 
	@RequestMapping(value="deleteDocument", method=RequestMethod.POST)
	public String deleteDoc(@RequestParam("id") int id) {
		
		userservice.deleteDocById(id);
		
		return "redirect:/goTODashboard#documents";
	}
	
	
	
}
