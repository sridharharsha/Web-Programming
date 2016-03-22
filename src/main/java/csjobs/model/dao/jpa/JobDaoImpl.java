package csjobs.model.dao.jpa;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;


import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import csjobs.model.Job;
import csjobs.model.User;
import csjobs.model.dao.JobDao;

@Repository
public class JobDaoImpl implements JobDao{
	
    @PersistenceContext
    private EntityManager entityManager;
	
	@Override
	public List<Job> getPublishedJobs() {
		
		List<Job> publishedJobs = new ArrayList<Job>();
		List<Job> jobs = entityManager.createQuery("from Job order by id",Job.class).getResultList();
		
		for(Job job : jobs){
			if(job.isPublished() == true && job.isClosed() == false){
				publishedJobs.add(job);
			}
		}
		return publishedJobs;
	}

	@Override
	public Job getJobById(Long id) {

		return entityManager.find(Job.class, id);
	}

	@Override
	public List<Job> getOpenJobPositionsForApplicant(Long id) {
		
		List<Job> publishedJobs = new ArrayList<Job>();
		List<Job> jobs = entityManager.createQuery("select j from Job j where not exists (select a from Application a where a.job.id = j.id and a.applicant.id = :id) order by j.id desc",Job.class).setParameter("id", id).getResultList();
		
		for(Job job : jobs){
			if(job.isPublished() == true && job.isClosed() == false){
				publishedJobs.add(job);
			}
		}
		
		return publishedJobs;
	}

	@Override
	public List<Job> getAllJobs() {
	
		return entityManager.createQuery("from Job order by id desc",Job.class).getResultList();
		
	}

	@Override
	@Transactional
	@PreAuthorize ("hasRole('ROLE_ADMIN')")
	public Job saveJob(Job job) {
		
		return entityManager.merge(job);
	}

	@Override
	@PreAuthorize("principal.username == #user.email")
	public List<Job> getReviewerJobs(User user) {
		
		List<Job> reviewerJobs = new ArrayList<Job>();
		List<Job> jobs = entityManager.createQuery("select j from Job j join j.committeeMembers c where c.id = :id order by j.id desc",Job.class)
				.setParameter("id", user.getId()).getResultList();
		for(Job job : jobs){
			if(job.isPublished() == true && job.isClosed() == false){
				reviewerJobs.add(job);
			}
		}
		return reviewerJobs;
	}


}
