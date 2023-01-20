package extract.transaction.entree;

import javax.persistence.Entity;
import javax.persistence.Table;

import extract.transaction.Mouvement;
import extract.transaction.MvtState;
import extract.transaction.repository.EntreeRepos;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@Entity
@Table(name = "Rnotaccept")
@EqualsAndHashCode(callSuper = true)
public class Entree extends Mouvement {
    public Entree() {
        this.setEtat(MvtState.Input.getValue());
    }

    public void accept(EntreeRepos e) {
        e.accept(this.getId());
    }

}
