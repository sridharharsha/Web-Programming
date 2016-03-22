package csjobs.model.dao;

import java.util.List;

import csjobs.model.Application;
import csjobs.model.Job;
import csjobs.model.User;


public interface ApplicationDao {
	
	Application saveApplication(Application application);
	
	Application getApplication(Long id);
	
	List<Application> getApplicationsByJobId( Job job, User user );

}
