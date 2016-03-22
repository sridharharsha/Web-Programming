package csjobs.web.validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import csjobs.model.User;
import csjobs.model.dao.UserDao;

@Component
public class UserValidator implements Validator{
	
	@Autowired
	UserDao userDao;

	@Override
	public boolean supports(Class<?> cls) {
		
		return User.class.isAssignableFrom(cls);
	}

	@Override
	public void validate(Object target, Errors errors) {
		
		User user = (User) target;
		
		if(!StringUtils.hasText(user.getFirstName())){
			errors.rejectValue("firstName", "error.field.empty");
		}
		
		if(!StringUtils.hasText(user.getLastName())){
			errors.rejectValue("lastName", "error.field.empty");
		}
		
		if(!StringUtils.hasText(user.getEmail())){
			errors.rejectValue("email", "error.field.empty");
		}
		
		if(!StringUtils.hasText(user.getPassword())){
			errors.rejectValue("password", "error.field.empty");
		}

		if(!StringUtils.hasText(user.getPassword2())){
			errors.rejectValue("password2", "error.field.empty");
		}
		
		if(!StringUtils.hasText(user.getPhone())){
			errors.rejectValue("phone", "error.field.empty");
		}

		if(!StringUtils.hasText(user.getAddress())){
			errors.rejectValue("address", "error.field.empty");
		}
		
        String email = user.getEmail();
        if( StringUtils.hasText( email ) ){
        
            User u = userDao.getUserByEmail( email );
            if( u != null)
                errors.rejectValue( "email", "error.user.email.taken" );
        }
        
        String password = user.getPassword();
        if( StringUtils.hasText( password ) ){
            if( !password.equals( user.getPassword2() ) )
                errors.rejectValue( "password2", "error.user.password.notmatch" );
        }
		
	}

}
