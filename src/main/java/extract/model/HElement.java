package extract.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

import lombok.Data;

@MappedSuperclass
@Data
public class HElement<ID> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    ID id;
}
