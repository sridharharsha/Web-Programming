package csjobs.web.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import csjobs.model.Job;
import csjobs.model.User;
import csjobs.model.dao.JobDao;
import csjobs.model.dao.UserDao;

@Controller
public class JobController {
	
	@Autowired
	private JobDao jobDao;
	
	@Autowired
	private UserDao userDao;
	
    
    @RequestMapping("/addJob.html")
    public String addJob( ModelMap models){
    	
    	String email = SecurityContextHolder.getContext().getAuthentication().getName();
    	if( email != null && !email.isEmpty() ){
        	User user = userDao.getUserByEmail(email);
        	List<User> reviewers = new ArrayList<User>();
        	List<User> allUsers = userDao.getUsers();
        	for(User u : allUsers){
        		if(u.isReviewer()){
        			reviewers.add(u);
        		}
        	}
        	models.put("reviewers", reviewers);
        	models.put("user", user);
        	return "addJob";
    	}
    	return "redirect:login.html";
    }
    
    @RequestMapping(value = "/addJob.html", method = RequestMethod.POST)
    public String addJob(@RequestParam String title,@RequestParam String description,@RequestParam(required = false) String publishDate,
    		@RequestParam(required = false) String closeDate,HttpServletRequest request) throws ParseException{
    	
    	Job job = new Job();
    	job.setTitle(title);
    	job.setDescription(description);
    	
    	Date originalPubDate = null;
    	if(publishDate != null && !publishDate.isEmpty()){
    		originalPubDate = new SimpleDateFormat("M/d/yyyy").parse(publishDate);
    	}
    	
    	job.setPublishDate(originalPubDate);
    	
    	Date originalCloseDate = null;
    	
    	if(closeDate != null && !closeDate.isEmpty()){
    		originalCloseDate = new SimpleDateFormat("M/d/yyyy").parse(closeDate); 
    	}
    	job.setCloseDate(originalCloseDate);

    	Long committeChairId = Long.parseLong(request.getParameter("committeeChair"));
    	User committeChairUser = userDao.getUser(committeChairId);
    	job.setCommitteeChair(committeChairUser);

    	String members[] = request.getParameterValues("chkRev");
    	
    	Set<User> committeeMembers = new HashSet<User>();
    	
    	for(int i=0;i<members.length;i++){
    		Long memberId = Long.parseLong(members[i]);
    		User member = userDao.getUser(memberId);
    		committeeMembers.add(member);
    	}
    	
    	committeeMembers.add(committeChairUser);
    	List<User> committee = new ArrayList<User>();
    	committee.addAll(committeeMembers);
    	job.setCommitteeMembers(committee);

    	jobDao.saveJob(job);
    	return "redirect:dashboard.html";
    }
    
    @RequestMapping("/edit.html")
    public String edit(ModelMap models,@RequestParam Long id){
    	
    	String email = SecurityContextHolder.getContext().getAuthentication().getName();
    	if( email != null && !email.isEmpty()){
    		
        	Job job = jobDao.getJobById(id);
        	List<User> allReviewers = new ArrayList<User>();
        	List<User> reviewers = new ArrayList<User>();
        	List<User> allUsers = userDao.getUsers();
        	for(User u : allUsers){
        		if(u.isReviewer()){
        			reviewers.add(u);
        			allReviewers.add(u);
        		}
        	}
        	
            Set<User> committe = new HashSet<User>();
            for( User member : job.getCommitteeMembers() )
            	committe.add( member );
            Iterator<User> iterator = reviewers.iterator();
            while( iterator.hasNext() )
                if( committe.contains( iterator.next() ) ) iterator.remove();

            models.put("user",userDao.getUserByEmail(email));
        	models.put("committee", committe);
        	models.put("reviewers", reviewers);
        	models.put("allReviewers", allReviewers);
        	models.put("job", job);
        	
        	return "editJob";
    	}
    	return "redirect:login.html";

    }
    
    @RequestMapping(value = "/edit.html", method = RequestMethod.POST)
    public String edit(@RequestParam Long id,@RequestParam String title,@RequestParam String description,@RequestParam(required = false) String publishDate,
    		@RequestParam(required = false) String closeDate,HttpServletRequest request) throws ParseException{
    	
    	Job job = jobDao.getJobById(id);
    	job.setTitle(title);
    	job.setDescription(description);
    	
    	Date originalPubDate = null;
    	if(publishDate != null && !publishDate.isEmpty()){
    		originalPubDate = new SimpleDateFormat("M/d/yyyy").parse(publishDate);
    	}
    	
    	job.setPublishDate(originalPubDate);
    	
    	Date originalCloseDate = null;
    	
    	if(closeDate != null && !closeDate.isEmpty()){
    		originalCloseDate = new SimpleDateFormat("M/d/yyyy").parse(closeDate); 
    	}
    	job.setCloseDate(originalCloseDate);

    	Long committeChairId = Long.parseLong(request.getParameter("committeeChair"));
    	User committeChairUser = userDao.getUser(committeChairId);
    	job.setCommitteeChair(committeChairUser);

    	String members[] = request.getParameterValues("chkRev");
    	
    	Set<User> committeeMembers = new HashSet<User>();
    	
    	for(int i=0;i<members.length;i++){
    		Long memberId = Long.parseLong(members[i]);
    		User member = userDao.getUser(memberId);
    		committeeMembers.add(member);
    	}
    	
    	committeeMembers.add(committeChairUser);
    	List<User> committee = new ArrayList<User>();
    	committee.addAll(committeeMembers);
    	job.setCommitteeMembers(committee);

    	jobDao.saveJob(job);
    	return "redirect:dashboard.html";
    }


}
