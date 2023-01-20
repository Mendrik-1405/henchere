package extract.auth;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity
public class Login {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    String email;

    String pwd;

    String nom;

    String prenom;

    String contact;

    int etat;

    public void loadBeforeSend() {
        this.setPwd(null);
    }
}
