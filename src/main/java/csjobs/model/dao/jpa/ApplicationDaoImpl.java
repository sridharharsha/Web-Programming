package csjobs.model.dao.jpa;



import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import csjobs.model.Application;
import csjobs.model.Job;
import csjobs.model.User;
import csjobs.model.dao.ApplicationDao;

@Repository
public class ApplicationDaoImpl implements ApplicationDao {
	
	@PersistenceContext
	private EntityManager entityManager;

	@Override
	@Transactional
	@PreAuthorize("hasRole('ROLE_APPLICANT') and principal.username == #application.applicant.email")
	public Application saveApplication(Application application) {

		return entityManager.merge(application);
	}

	@Override
	@PostAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_REVIEWER') or principal.username == returnObject.applicant.email")
	public Application getApplication(Long id) {
		
		return entityManager.find(Application.class, id);
	}

	@Override
	@PostAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_REVIEWER')")
	public List<Application> getApplicationsByJobId(Job job , User user) {
		
		return entityManager.createQuery("from Application where job.id = :id",Application.class).setParameter("id", job.getId()).getResultList();
	}

}
