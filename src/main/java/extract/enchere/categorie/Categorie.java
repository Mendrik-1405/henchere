package extract.enchere.categorie;

import javax.persistence.Entity;

import extract.enchere.Apropos;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Categorie extends Apropos  {
    
}
