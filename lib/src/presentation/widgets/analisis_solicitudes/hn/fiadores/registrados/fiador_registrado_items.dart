import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_fiadores/analisis_fiadores_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';

/// Valores seleccionados de los catálogos en el formulario de fiadores en solo
/// lectura (SPEC 10). `campo` es la llave del JSON sin `Codigo`/`Nombre`, p. ej.
/// `'EstadoCivil'` lee `EstadoCivilNombre`. Si el nombre viene vacío se muestra
/// el código. Devuelven `null` si el código está vacío.
extension FiadorRegistradoItems on AnalisisFiadoresCubit {
  String _nombre(String campo, String codigo) {
    final nombre = fiadorRegistrado?.nombre(campo) ?? '';
    return nombre.isNotEmpty ? nombre : codigo;
  }

  /// Para `SearchDropdownWidget`.
  Item? itemRegistrado(String campo, String codigo) {
    if (codigo.isEmpty) return null;
    return Item(name: _nombre(campo, codigo), value: codigo);
  }

  /// Para `CatalogoActividadesCNBSDropdown`.
  ActiivdadCNBS? actividadRegistrada(String campo, String codigo) {
    if (codigo.isEmpty) return null;
    return ActiivdadCNBS(
      nombre: _nombre(campo, codigo),
      valor: codigo,
      esAPNFD: false,
    );
  }

  /// Para `CatalogoValorNacionalidad`.
  ItemNacionalidad? nacionalidadRegistrada(String campo, String codigo) {
    if (codigo.isEmpty) return null;
    return ItemNacionalidad(
      id: 0,
      valor: codigo,
      nombre: _nombre(campo, codigo),
      relacion: '',
    );
  }
}
