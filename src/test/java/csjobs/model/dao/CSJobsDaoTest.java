package csjobs.model.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.testng.AbstractTransactionalTestNGSpringContextTests;
import org.testng.annotations.Test;

@Test(groups = "CSJobsDaoTest")
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class CSJobsDaoTest extends AbstractTransactionalTestNGSpringContextTests {

    @Autowired
    UserDao userDao;
    @Autowired
    JobDao jobDao;

//    @Test
//    public void getUsers()
//    {
//        assert userDao.getUsers().size() == 7;
//    }
//    
//    @Test
//    public void getAllJobs(){
//    
//        assert jobDao.getPublishedJobs().size() == 2;
//    }
    
//    @Test
//    public void getReviewerJobs(){
//    	assert jobDao.getAllJobsForReviewer((long) 4).size() == 2;
//    }
//    
//    @Test
//    public void getJobForSingleApplicant(){
//    	Long appId = (long) 1;
//    	Long jobId = (long) 1;
//    	assert jobDao.getApplicantForSingleJob(jobId, appId) != null;
//    }


}