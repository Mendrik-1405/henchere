package extract.enchere;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.RequestMapping;

import extract.controller.CrudController;
import extract.enchere.repository.MiseRepos;


@RequestMapping("/enchere/encherir")
public class MiseCnt extends CrudController<Mise, Integer, MiseRepos, MiseSer> {

    @Autowired
    public MiseCnt(MiseSer service) {
        super(service);
    }

    
}
