package extract.enchere.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import extract.enchere.Enchere;

public interface EnchereRepos extends JpaRepository<Enchere,Integer> {
    
}
