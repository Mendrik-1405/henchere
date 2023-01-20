package extract.transaction.repository;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import extract.transaction.entree.Entree;

public interface EntreeRepos extends JpaRepository<Entree, Integer> {

    @Transactional
    @Modifying
    @Query(value = "call acceptrecharge(:id)", nativeQuery = true)
    public void accept(@Param("id") Integer id);

}
