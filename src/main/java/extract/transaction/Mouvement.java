package extract.transaction;

// import javax.persistence.Entity;
import javax.persistence.MappedSuperclass;
import javax.persistence.OneToOne;
// import javax.persistence.Table;

import extract.auth.Login;
import extract.model.HElement;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

// @Entity
@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@MappedSuperclass
// @Table(name = "Recharge")
public class Mouvement extends HElement<Integer> {
    int etat;

    double montant;

    @OneToOne
    Login login;
}
