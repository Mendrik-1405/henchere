package extract.controller;

import java.security.NoSuchAlgorithmException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import extract.auth.Login;
import extract.auth.LoginSer;
import extract.auth.NoLogin;
import extract.auth.Token;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@RestController
@CrossOrigin
@EqualsAndHashCode(callSuper = true)
public class LoginCnt extends Cnt {
    @Autowired
    LoginSer loginSer;

    public ResponseEntity<?> login(Login login, int etat) {
        try {
            Token l = this.getLoginSer().login(login, etat);
            return this.returnSuccess(l, HttpStatus.OK);
        } catch (NoLogin e) {
            e.printStackTrace();
            return this.returnError(e, HttpStatus.NOT_FOUND);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return this.returnError(e, HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("/login/client")
    public ResponseEntity<?> loginClient(@RequestBody Login login) {
        return this.login(login, 0);
    }

    @PostMapping("/login/admin")
    public ResponseEntity<?> loginAdmin(@RequestBody Login login) {
        return this.login(login, 50);
    }

    public ResponseEntity<?> signup(Login login, int etat) {
        try {
            login.setEtat(etat);
            this.getLoginSer().signUp(login);
            return this.returnSuccess(login, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return this.returnError(e, HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("/login/incription/client")
    public ResponseEntity<?> createClient(@RequestBody Login login) {
        return this.signup(login, 0);

    }

    @PostMapping("/login/incription/admin")
    public ResponseEntity<?> createAdmin(@RequestBody Login login) {
        return this.signup(login, 50);

    }
}
