package extract.enchere;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import extract.enchere.repository.MiseRepos;
import extract.model.HCrud;

@Service
public class MiseSer extends HCrud<Mise, Integer, MiseRepos> {

    @Autowired
    public MiseSer(MiseRepos repos) {
        super(repos);
        // TODO Auto-generated constructor stub
    }

}
