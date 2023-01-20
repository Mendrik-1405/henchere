package extract.enchere;

import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

import extract.model.HElement;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@MappedSuperclass
@NoArgsConstructor
@AllArgsConstructor
public class Apropos extends HElement<Integer> {

    String designation;
}
