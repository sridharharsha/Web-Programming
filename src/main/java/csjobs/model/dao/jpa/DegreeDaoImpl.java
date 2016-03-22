package csjobs.model.dao.jpa;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import csjobs.model.Degree;
import csjobs.model.dao.DegreeDao;

@Repository
public class DegreeDaoImpl implements DegreeDao {
	
	@PersistenceContext
	private EntityManager entityManager;

	@Override
	public Degree saveDegree(Degree degree) {

		return entityManager.merge(degree);
	}

}
