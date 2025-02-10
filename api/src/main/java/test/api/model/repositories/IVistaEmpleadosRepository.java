package test.api.model.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import test.api.model.views.VistaEmpleados;

@Repository
public interface IVistaEmpleadosRepository extends JpaRepository<VistaEmpleados, Long> {}
