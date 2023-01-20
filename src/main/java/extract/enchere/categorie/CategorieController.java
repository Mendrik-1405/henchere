package extract.enchere.categorie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import extract.controller.CrudController;
import extract.enchere.repository.CategorieRepos;

@RestController
@RequestMapping("/categorie")
public class CategorieController extends CrudController<Categorie, Integer, CategorieRepos, CategorieService> {

    @Autowired
    public CategorieController(CategorieService service) {
        super(service);
    }

}
