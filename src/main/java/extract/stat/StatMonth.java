package extract.stat;

import javax.persistence.Entity;
import javax.persistence.Table;

import extract.model.HElement;

@Table(name = "vstatMonth")
@Entity
public class StatMonth extends HElement<Integer> {
    double total_ventes;
    int semaine;
}
