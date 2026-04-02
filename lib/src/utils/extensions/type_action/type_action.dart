enum TypeAction {
  autorizacion('SOLICITUDCREDITOAUTORIZAR'),
  asignacion('SOLICITUDCREDITOASIGNAR'),
  cerrar('ANALISISSOLICITUDCREDITOCERRAR'),
  menuCartera('MENUCARTERAMOVIL'),
  llenarSolicitudes('LLENARSOLICITUDESMOVIL'),
  llenarKiva('LLENARKIVAMOVIL'),
  crearGrupoCredito('CREARGRUPOCREDITO'),
  solicitudCreditoModificar('SOLICITUDCREDITOMODIFICAR'),
  comite('ACTASCOMITE'),
  aprobarComiteGrupal('APROBARCOMITEGRUPAL'),
  autorizacionSolicitudGrupal('AUTORIZARSOLICITUDGRUPAL'),
  asignacionSolicitudGrupal('ASIGNARSOLICITUDGRUPAL'),
  moduloOtp('MODULOOTP');

  final String codigo;

  const TypeAction(this.codigo);
}
