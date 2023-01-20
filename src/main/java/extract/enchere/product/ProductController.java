package extract.enchere.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import extract.controller.CrudController;
import extract.enchere.repository.ProduitRepos;

@RestController
@RequestMapping("/product")
public class ProductController extends CrudController<Produit, Integer, ProduitRepos, ProductService> {

    @Autowired
    public ProductController(ProductService service) {
        super(service);
    }

}
