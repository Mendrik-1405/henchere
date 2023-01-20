package extract.transaction.entree;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import extract.model.HCrud;
import extract.transaction.repository.EntreeRepos;

@Service
public class EntreeSer extends HCrud<Entree, Integer, EntreeRepos> {

    @Autowired
    public EntreeSer(EntreeRepos repos) {
        super(repos);
    }

    public void accept(Entree entree) {
        entree.accept(this.getRepos());
    }

}
