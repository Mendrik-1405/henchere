package extract.transaction.entree;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import extract.auth.TokenSer;
import extract.controller.CrudController;
import extract.transaction.repository.EntreeRepos;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@RestController
@RequestMapping(value = "/recharge")
@EqualsAndHashCode(callSuper = false)
public class EntreeController extends CrudController<Entree, Integer, EntreeRepos, EntreeSer> {
    @Autowired
    TokenSer tokenSer;

    @Autowired
    public EntreeController(EntreeSer service) {
        super(service);
    }

    @PostMapping("/compte")
    public ResponseEntity<?> accept(@RequestBody Entree entree, @RequestParam(name = "id") Integer idAdmin) {
        try {
            this.getTokenSer().askAccess(idAdmin,50);
            this.getService().accept(entree);
            return this.returnSuccess(entree, HttpStatus.OK);
        } catch (Exception e) {
            return this.returnError(e, HttpStatus.NOT_FOUND);
        }
    }
}
