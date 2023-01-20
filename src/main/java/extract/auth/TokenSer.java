package extract.auth;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Data;

@Data
@Service
public class TokenSer {
    @Autowired
    TokenRepos tokenRepos;

    public void reloadToken() {
        this.getTokenRepos().removeToken();
    }

    public void askAccess(int id, int... etat) throws NoAuth {
        if (!this.canAccess(id, etat)) {
            throw new NoAuth();
        }
    }

    public boolean canAccess(int id, int... etat) {
        this.reloadToken();
        int state = 0;
        if (etat.length > 0) {
            state = etat[0];
        }
        List<Token> ans = this.getTokenRepos().getByLogin(id);
        if (ans.size() > 0) {
            return ans.get(0).getLogin().getEtat() == state;
        }
        return false;
    }
}
