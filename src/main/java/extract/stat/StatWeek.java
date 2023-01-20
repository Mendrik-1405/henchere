package extract.stat;

import javax.persistence.Entity;
import javax.persistence.Table;

import extract.model.HElement;

@Table(name = "vstatWeek")
@Entity
public class StatWeek extends HElement<Integer> {
    double total_ventes;
    int semaine;
}
