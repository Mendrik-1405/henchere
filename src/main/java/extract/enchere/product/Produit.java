package extract.enchere.product;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

import extract.auth.Login;
import extract.enchere.Photo;
import extract.enchere.categorie.Categorie;
import extract.model.HElement;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Entity
@Data
@EqualsAndHashCode(callSuper = false)
public class Produit extends HElement<Integer> {
    String designation;
    String description;
    double prixmin;
    double prixmax;
    @OneToOne
    @JoinColumn(name = "loginid")
    Login login;

    @JoinColumn(name = "photoid")
    @OneToOne
    Photo photo;

    @OneToOne
    @JoinColumn(name = "categorieid")
    Categorie categorie;
}
