package extract.stat;

import org.springframework.beans.factory.annotation.Autowired;

import extract.model.HCrud;

public class StatMonthSer extends HCrud<StatWeek, Integer, StatWeekRepos> {

    @Autowired
    public StatMonthSer(StatWeekRepos repos) {
        super(repos);
        //TODO Auto-generated constructor stub
    }

}