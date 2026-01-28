enum TypeAction {
  autorizacion('SOLICITUDCREDITOAUTORIZAR'),
  asignacion('SOLICITUDCREDITOASIGNACION'),
  cerrar('ANALISISSOLICITUDCREDITOCERRAR'),
  menuCartera('MENUCARTERAMOVIL'),
  llenarSolicitudes('LLENARSOLICITUDESMOVIL'),
  llenarKiva('LLENARKIVAMOVIL'),
  crearGrupoCredito('CREARGRUPOCREDITO');

  final String codigo;

  const TypeAction(this.codigo);
}
