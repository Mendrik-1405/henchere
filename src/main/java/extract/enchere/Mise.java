package extract.enchere;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

import extract.auth.Login;
import extract.model.HElement;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Data
@EqualsAndHashCode(callSuper = true)
public class Mise extends HElement<Integer> {

    @OneToOne
    @JoinColumn(name = "enchereid")
    Enchere enchere;

    @OneToOne
    @JoinColumn(name = "loginid")
    Login login;

    double prix;

    LocalDateTime datemise;

    public Mise() {
        this.setDatemise(LocalDateTime.now());
    }

}
