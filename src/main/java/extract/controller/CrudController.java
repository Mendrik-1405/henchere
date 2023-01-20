package extract.controller;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import extract.model.HCrud;
import extract.model.HElement;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;

@AllArgsConstructor
@Data
@EqualsAndHashCode(callSuper = false)
public class CrudController<E extends HElement<ID>, ID, R extends JpaRepository<E, ID>, S extends HCrud<E, ID, R>>
        extends Cnt {
    public S service;

    @PostMapping("")
    public ResponseEntity<?> create(@RequestBody E obj,
            @RequestParam(name = "idUser", required = false) ID id) throws Exception {
        return this.returnSuccess(service.create(obj), HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> findById(@PathVariable("id") ID id,
            @RequestParam(name = "idUser", required = false) ID idUsers) {
        return this.returnSuccess(service.findById(id), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable ID id,
            @RequestParam(name = "idUser", required = false) ID idUsers) {
        this.getService().delete(id);
        return this.returnSuccess("", HttpStatus.NO_CONTENT);
    }

    @GetMapping("")
    public ResponseEntity<?> findAll(@RequestParam(name = "idUser", required = false) ID id) {
        return returnSuccess(service.getAll(), HttpStatus.OK);
    }

    @PutMapping("")
    public ResponseEntity<?> update(@RequestBody E obj,
            @RequestParam(name = "idUser", required = false) ID id) throws Exception {
        return this.returnSuccess(service.update(obj), HttpStatus.OK);
    }

}
