package extract.enchere;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import extract.enchere.repository.EnchereRepos;
import extract.model.HCrud;

@Service
public class EnchereService extends HCrud<Enchere, Integer, EnchereRepos> {

    @Autowired
    public EnchereService(EnchereRepos repos) {
        super(repos);
    }

}
