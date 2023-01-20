package extract.model;

import java.util.List;


public interface HModel<T, Id> {

    public T create(T obj);

    public List<T> getAll();

    public T update(T obj);

    public void delete(Id obj);

    public T findById(Id id);
}
