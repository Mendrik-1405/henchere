package extract.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.google.gson.Gson;

import lombok.Data;

@Data
public class Cnt {

    @Autowired
    Gson gson;

    public ResponseEntity<SuccessResponse> returnSuccess(Object obj, HttpStatus status) {
        return new ResponseEntity<>(new SuccessResponse(obj), status);
    }

    public ResponseEntity<ErrorDisplay> returnError(Exception obj, HttpStatus status) {
        return new ResponseEntity<>(new ErrorDisplay(status, obj), status);
    }


}
