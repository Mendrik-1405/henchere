package extract.stat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import extract.controller.CrudController;

@RequestMapping("/stat/week")
@RestController
public class StatWeekCnt extends CrudController<StatWeek, Integer, StatWeekRepos, StatWeekSer> {

    @Autowired
    public StatWeekCnt(StatWeekSer service) {
        super(service);
    }

}
