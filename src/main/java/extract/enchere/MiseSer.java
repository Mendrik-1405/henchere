package extract.enchere;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import extract.model.HCrud;

@Service
public class MiseSer extends HCrud<Mise, Integer, JpaRepository<Mise, Integer>> {

    @Autowired
    public MiseSer(JpaRepository<Mise, Integer> repos) {
        super(repos);
        // TODO Auto-generated constructor stub
    }

}
