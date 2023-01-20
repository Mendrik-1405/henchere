package extract.enchere.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import extract.enchere.categorie.Categorie;

public interface CategorieRepos extends JpaRepository<Categorie, Integer> {

}
