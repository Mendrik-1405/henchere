package extract.auth;

import java.security.NoSuchAlgorithmException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Data;

@Data
@Service
public class LoginSer {
    @Autowired
    LoginRepos loginRepos;

    @Autowired
    TokenRepos tokenRepos;

    public Token login(Login login) throws NoLogin, NoSuchAlgorithmException {
        List<Login> ans = this.getLoginRepos().getBy(login.getEmail(), login.getPwd());
        if (ans.size() > 0) {
            Login answer = ans.get(0);
            Token token = new Token(answer);
            this.getTokenRepos().save(token);
            token.loadBeforeSend();
            return token;
        }
        throw new NoLogin();
    }

    public Token login(Login login, int etat) throws NoSuchAlgorithmException, NoLogin {
        Token token = this.login(login);
        if (token.getLogin().getEtat() != etat) {
            throw new NoLogin();
        }
        return token;
    }

    public Token loginClient(Login login) throws NoSuchAlgorithmException, NoLogin {
        return this.login(login, 0);
    }

    public Token loginAdmin(Login login) throws NoSuchAlgorithmException, NoLogin {
        return this.login(login, 50);
    }

    public void signUp(Login login) {
        this.getLoginRepos().save(login);
    }
}
