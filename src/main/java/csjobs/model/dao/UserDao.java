package csjobs.model.dao;

import java.util.List;


import csjobs.model.User;

public interface UserDao {
	
    User getUser( Long id );

    List<User> getUsers();
    
    User getUserByEmail(String email);
    
    User saveUser( User user);

}
