package extract.enchere;

import java.sql.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

import extract.auth.Login;
import extract.enchere.product.Produit;
import extract.model.HElement;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Data
@EqualsAndHashCode(callSuper = false)
public class Enchere extends HElement<Integer> {
    String designation;
    @Column(name = "datedebut")
    Date debut;
    @Column(name = "datefin")
    Date fin;
    @Column(name = "prixminimise")
    double prixMin;
    int etat;
    @OneToOne
    @JoinColumn(name = "loginid")
    Login login;

    @OneToOne
    @JoinColumn(name = "Produitid")
    Produit produit;
}
