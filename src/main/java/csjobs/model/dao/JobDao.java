package csjobs.model.dao;

import java.util.List;

import csjobs.model.Job;
import csjobs.model.User;


public interface JobDao {
	
    List<Job> getPublishedJobs();
    
    Job getJobById( Long id );
    
    List<Job> getOpenJobPositionsForApplicant( Long id );
    
    List<Job> getAllJobs();
    
    Job saveJob( Job job);
    
    List<Job> getReviewerJobs( User user );

}
