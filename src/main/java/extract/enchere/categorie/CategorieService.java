package extract.enchere.categorie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import extract.enchere.repository.CategorieRepos;
import extract.model.HCrud;

@Service
public class CategorieService extends HCrud<Categorie, Integer, CategorieRepos> {

    @Autowired
    public CategorieService(CategorieRepos repos) {
        super(repos);
    }

}
