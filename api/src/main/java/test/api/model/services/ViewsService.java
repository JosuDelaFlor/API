package test.api.model.services;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import test.api.model.repositories.IVistaEmpleadosRepository;
import test.api.model.views.VistaEmpleados;

@Service
public class ViewsService {
    
    @Autowired
    private IVistaEmpleadosRepository vistaEmpleadosRepository;

    private static final Logger LOGGER = LoggerFactory.getLogger(ViewsService.class);

    public List<VistaEmpleados> vistaEmpleados() {
        List<VistaEmpleados> resultList = new ArrayList<>();

        try {
            resultList = vistaEmpleadosRepository.findAll();

            if (resultList.isEmpty()) {
                LOGGER.warn("\nLos datos de la View VistaEmpleados estan vacios");
            }

            LOGGER.info("\nDatos de la ViewVistaEmpleados recividos correctamente");
        } catch (Exception e) {
            LOGGER.error("\nHa habido un problema al recivir los datos de la View VistaEmpleados", e);
        }

        return resultList;
    }

}
