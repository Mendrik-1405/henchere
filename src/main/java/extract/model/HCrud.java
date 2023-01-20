package extract.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import extract.enchere.Mise;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class HCrud<T extends HElement<ID>, ID, R extends JpaRepository<T, ID>> implements HModel<T, ID> {
    R repos;

    @Override
    public T create(T obj) {
        return this.getRepos().save(obj);
    }

    @Override
    public List<T> getAll() {
        return this.getRepos().findAll();
    }

    @Override
    public T update(T obj) {
        return this.getRepos().save(obj);
    }

    @Override
    public void delete(ID obj) {
        this.getRepos().deleteById(obj);
    }

    @Override
    public T findById(ID obj) {
        return this.getRepos().findById(obj).orElse(null);
    }

}
