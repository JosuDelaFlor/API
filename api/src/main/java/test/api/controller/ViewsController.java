package test.api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import test.api.model.services.ViewsService;
import test.api.model.views.VistaEmpleados;

@RestController
@RequestMapping(path = "/views")
@Tag(name = "Gestion de views (Peticiones GET)")
public class ViewsController {
    
    @Autowired
    private ViewsService viewsService;

    @GetMapping(path = "/vista-empleados")
    @Operation(summary = "Vista empleados")
    private @ResponseBody Iterable<VistaEmpleados> vistaEmpleados() {
        return viewsService.vistaEmpleados();
    }

}
