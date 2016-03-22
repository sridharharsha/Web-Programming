package csjobs.web.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import csjobs.model.Application;
import csjobs.model.Degree;
import csjobs.model.File;
import csjobs.model.Job;
import csjobs.model.User;
import csjobs.model.dao.ApplicationDao;
import csjobs.model.dao.DegreeDao;
import csjobs.model.dao.FileDao;
import csjobs.model.dao.JobDao;
import csjobs.model.dao.UserDao;
import csjobs.web.validator.UserValidator;

@Controller
public class UserController {
	
    @Autowired
    private UserDao userDao;
    
    @Autowired
    private JobDao jobDao;
    
    @Autowired
    private UserValidator userValidator;
    
    @Autowired
    private DegreeDao degreeDao;
    
    @Autowired
    private ApplicationDao applicationDao;
    
    @Autowired
    private FileDao fileDao;
    
	@Autowired
	private ServletContext context;

    @RequestMapping({"/index.html","/login.html"})
    public String home( ModelMap models){

    	models.put("jobs", jobDao.getPublishedJobs());
    	return "home";
    }
    
    @RequestMapping(value = "/register.html", method = RequestMethod.GET)
    public String register( ModelMap models ){
    	models.put("user", new User());
    	return "register";
    }
    
    @RequestMapping(value = "/register.html", method = RequestMethod.POST)
    public String register( @ModelAttribute User user, BindingResult result ){
    		
    	userValidator.validate(user, result);
    	if(result.hasErrors()){
    		return "register";
    	}
    	Set<String> roles = new HashSet<String>();
    	String roleName = "ROLE_APPLICANT";
    	roles.add(roleName);
    	user.setRoles(roles);
    	user = userDao.saveUser(user);
       	return "redirect:login.html";
    	
    }
    
    @RequestMapping("/dashboard.html")
    public String dashboard( ModelMap models){
    	
    	String email = SecurityContextHolder.getContext().getAuthentication().getName();
    	if(email != null && !email.isEmpty()){
    		
        	User user = userDao.getUserByEmail(email);
        	if(user != null){

        		if(user.isAdmin() == true){
        			models.put("user", user);
        			models.put("jobs", jobDao.getAllJobs());

        			return "admin";

        		}else if(user.isReviewer() == true){
        			
        			List<Job> reviewerJobs = jobDao.getReviewerJobs(user);
        			if(reviewerJobs != null && reviewerJobs.size() > 0){
        				models.put("jobs", reviewerJobs);
        			}
        			models.put("user", user);
        			return "reviewer";

        		}else{
        			
        			List<Application> applications = user.getApplications();
        			List<Job> publishedJobs = jobDao.getPublishedJobs();

        			if(applications != null && applications.size() > 0){
        				
        				models.put("jobsApplied", user.getApplications());
        				models.put("openJobs", jobDao.getOpenJobPositionsForApplicant(user.getId()));

        			}else{
        				models.put("openJobs", publishedJobs);
        			}
        			models.put("user", user);
        			return "applicant";
        		}
        	}
    	}
    	return "redirect:login.html";
    }
    

    
	private java.io.File getFileDirectory(){
		String path = context.getRealPath("/WEB-INF/files");
		return new java.io.File(path);
	}

    
    @RequestMapping("/apply.html")
    public String apply( ModelMap models, @RequestParam Long jobId,HttpSession session){
    	
    	String email = SecurityContextHolder.getContext().getAuthentication().getName();
    	if( email != null && !email.isEmpty()){
    		
        	models.put("user", userDao.getUserByEmail(email));
        	models.put("jobApplying", jobDao.getJobById(jobId));
        	//models.put("application", new Application());
        	return "apply";

    	}
    	return "redirect:login.html";
    }
    
    @RequestMapping(value = "/apply.html", method = RequestMethod.POST)
    public String apply(@RequestParam(required = false) MultipartFile cv,@RequestParam(required = false) MultipartFile research,
    					@RequestParam(required = false) MultipartFile teaching,HttpServletRequest request)
    					throws IllegalStateException, IOException{

    	String email = SecurityContextHolder.getContext().getAuthentication().getName();
    	if( email != null && !email.isEmpty() ){
    		User user = userDao.getUserByEmail(email);
    		
        	Application application = new Application();
        	application.setCurrentJobTitle(request.getParameter("currentJobTitle"));
        	application.setCurrentJobInstitution(request.getParameter("currentJobInstitution"));
        	application.setCurrentJobYear(Integer.parseInt(request.getParameter("currentJobYear")));

        	List<Degree> degrees = new ArrayList<Degree>();
        	Integer degreeCnt = Integer.parseInt(request.getParameter("degreeCnt"));
        	for(int i=1; i<=degreeCnt; i++){

        		Degree degree = new Degree();
        		String degreeName = request.getParameter("saveDegName"+i);
        		String university = request.getParameter("saveUnivName"+i);
        		Integer year = Integer.parseInt(request.getParameter("saveYear"+i));
        		degree.setName(degreeName);
        		degree.setSchool(university);
        		degree.setYear(year);
        		degrees.add(degree);
        		
        	}
        	application.setDegrees(degrees);
        	application.setSubmitDate(new Date());
        	application.setApplicant(user);
        	Long jobId = Long.parseLong(request.getParameter("jobId"));
        	Job job = jobDao.getJobById(jobId);
        	application.setJob(job);
        	
        	if(cv != null && !cv.isEmpty()){

        		File applicantCV = new File();
            	applicantCV.setName(cv.getOriginalFilename());
            	applicantCV.setType(cv.getContentType());
            	applicantCV.setSize(cv.getSize());
            	applicantCV.setDate(new Date());
            	applicantCV.setOwner(application.getApplicant());
            	applicantCV = fileDao.saveFile(applicantCV);
            	cv.transferTo(new java.io.File(getFileDirectory(),cv.getOriginalFilename()+applicantCV.getId()));
            	application.setCv(applicantCV);
        	}
        	
        	if(research != null && !research.isEmpty()){
        		
        		File applicantResearch = new File();
            	applicantResearch.setName(research.getOriginalFilename());
            	applicantResearch.setType(research.getContentType());
            	applicantResearch.setSize(research.getSize());
            	applicantResearch.setDate(new Date());
            	applicantResearch.setOwner(application.getApplicant());
            	applicantResearch = fileDao.saveFile(applicantResearch);
            	research.transferTo(new java.io.File(getFileDirectory(),research.getOriginalFilename()+applicantResearch.getId()));
            	application.setResearchStatement(applicantResearch);

        	}
        	
        	if(teaching != null && !teaching.isEmpty()){
        		
        		File applicantTeaching = new File();
        		applicantTeaching.setName(teaching.getOriginalFilename());
        		applicantTeaching.setType(teaching.getContentType());
        		applicantTeaching.setSize(teaching.getSize());
        		applicantTeaching.setDate(new Date());
        		applicantTeaching.setOwner(application.getApplicant());
        		applicantTeaching = fileDao.saveFile(applicantTeaching);
        		teaching.transferTo(new java.io.File(getFileDirectory(),teaching.getOriginalFilename()+applicantTeaching.getId()));
            	application.setTeachingStatement(applicantTeaching);

        	}
        	
        	application = applicationDao.saveApplication(application);
        	
        	List<Application> applications = new ArrayList<Application>();
        	applications.add(application);
        	user.setApplications(applications);
        	job.setApplications(applications);
        	
        	
        	return "redirect:dashboard.html";
    	}
    	return "redirect:login.html";
    	
    }
    
    @RequestMapping("/application-info.html")
    public String application(ModelMap models, @RequestParam Long id, @RequestParam Long jobId ){
    	
    	String email = SecurityContextHolder.getContext().getAuthentication().getName();
    	if( email != null && !email.isEmpty() ){
    		
    		User user = userDao.getUserByEmail(email);
        	Application application = applicationDao.getApplication(id);
        	Job job = jobDao.getJobById(jobId);
        	if(user.isReviewer() == true){
        		if(job.getCommitteeMembers().contains(user) || job.getCommitteeChair().equals(user)){

        			models.put("isReviewer", user.isReviewer());
                	models.put("job",job);
                	models.put("degrees", application.getDegrees());
                	models.put("application", application);
                	models.put("user", user);
        			
        		}else{
        			models.put("inValidUser", true);
        		}
        	}else{
            	models.put("isAdmin", user.isAdmin());
            	models.put("isApplicant", user.isApplicant());
            	models.put("job",job);
            	models.put("degrees", application.getDegrees());
            	models.put("application", application);
            	models.put("user", user);
        	}
        	
        	return "application-info";

    	}
    	return "redirect:login.html";
    	
    }
    
    @RequestMapping("/download.html")
    public String download( HttpServletResponse response,@RequestParam Long fileId ) throws IOException{
    	
    	File file = fileDao.getFile(fileId); 
    	response.setContentType("text/plain");
    	response.setHeader("Content-Disposition", "attachment; filename="+file.getName());
    	System.out.println();
    	FileInputStream in = new FileInputStream(new java.io.File(getFileDirectory(),file.getName()+file.getId()));
    	OutputStream outputStream = response.getOutputStream();
    	byte buffer[] = new byte[2048];
    	int bytesRead;
    	
    	while((bytesRead = in.read( buffer )) > 0){
    		outputStream.write(buffer, 0, bytesRead);
    	}
    	in.close();
    	return null;
    }
    
    @RequestMapping("/applications.html")
    public String applications( @RequestParam Long id , ModelMap models ){
    	
    	String email = SecurityContextHolder.getContext().getAuthentication().getName();
    	if(email != null && !email.isEmpty() ){
    		User user = userDao.getUserByEmail(email);
    		
    		
    		Job job = jobDao.getJobById(id);
    		if( user.isReviewer() == true ){
    			if(job.getCommitteeMembers().contains(user) || job.getCommitteeChair().equals(user)){
    	    		List<Application> applications = applicationDao.getApplicationsByJobId(job,user);
    	    		models.put("job", job);
    	    		if(applications != null && applications.size() > 0){
    	    			models.put("applications",applications);
    	    		}
    	    		models.put("user", user);

    			}else{
    				models.put("inValidUser", true);
    			}
    		}else{
    			models.put("user", user);
    			models.put("job", job);
        		List<Application> applications = applicationDao.getApplicationsByJobId(job,user);
        		
        		if(applications != null && applications.size() > 0){
        			models.put("applications",applications);
        		}

    		}
    		
    		
    		return "applications";
    	}
    	return "redirect:login.html";
    }

    

}
