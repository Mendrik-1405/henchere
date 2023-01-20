package extract.enchere.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import extract.enchere.product.Produit;

public interface ProduitRepos extends JpaRepository<Produit,Integer> {
    
}
