package extract.stat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import extract.controller.CrudController;

@RequestMapping("/stat/month")
@RestController
public class StatMontCnt extends CrudController<StatWeek, Integer, StatWeekRepos, StatWeekSer> {

    @Autowired
    public StatMontCnt(StatWeekSer service) {
        super(service);
    }

}