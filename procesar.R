library(dplyr)
library(readxl)
library(janitor)
library(purrr)

# inv_subd <- read_xlsx("datos/subdere/original/reporte_6a1d914085116.xlsx")

rutas <- list.files("datos/proyectos_subdere/original", full.names = T)

# cargar todos en carpeta
archivos <- rutas |>
  map(read_xlsx)

inv_subd <- archivos |>
  map(mutate, CANTIDAD_DE_DIAS = as.numeric(CANTIDAD_DE_DIAS)) |>
  list_rbind()
# inv_subd <- read_xlsx("datos/subdere/original/reporte_6a1d914085116.xlsx")

inv_subd |> glimpse()

inv_subd |>
  count(ETAPA)

# limpieza
inv_subd_2 <- inv_subd |>
  clean_names() |>
  rename(
    codigo_comuna = codigo_comuna_ine,
    año = ano_de_creacion,
    dias = cantidad_de_dias
  ) |>
  mutate(codigo_comuna = as.numeric(codigo_comuna)) |>
  distinct()

inv_subd_2 |>
  distinct(region)

inv_subd_2 |>
  distinct(etapa)

inv_subd_2 |>
  distinct(estado) |>
  print(n = Inf)

inv_subd_2 |>
  distinct(tipologia)
#
# # filtros ----
# inv_subd_3 <- inv_subd_2 |>
#   # filter(año >= 2018) |>
#   filter(
#     programa %in%
#       c(
#         "(PMU) PROGRAMA MEJORAMIENTO URBANO",
#         "(PMB) PROGRAMA MEJORAMIENTO DE BARRIOS",
#         "(PRBIPE) REVITALIZACIÓN DE BARRIOS E INFRAESTRUCTURA PATRIMONIAL EMBLEMÁTICA",
#         "(FRC) FONDO RECUPERACIÓN DE CIUDADES",
#         "(PMB-IRA) PMB TRADICIONAL"
#       )
#   ) |>
#   filter(
#     etapa %in%
#       c(
#         "PROYECTOS CON RECURSOS ASIGNADOS",
#         "PROYECTOS EN EJECUCION",
#         "PROYECTOS CERRADOS"
#       )
#   ) |>
#   filter(
#     !estado %in%
#       c("Proyecto Dejado sin Efecto", "Proyecto Con Término Anticipado")
#   )
# # filter(
# #   estado %in%
# #     c(
# #       "100% Girado",
# #       "En Proceso de Cierre",
# #       "Proyecto Terminado",
# #       "Proyecto Cerrado",
# #       "Proyecto Con Término Anticipado"
# #     )
# # )
#
# inv_subd_3 |>
#   distinct(estado)

#
# inv_subd_4 <- inv_subd_3 |>
#   group_by(codigo_comuna, año) |>
#   summarize(
#     proyectos_monto = sum(aporte_subdere, na.omit = T),
#     proyectos_dias = sum(dias, na.omit = T),
#     proyectos_n = n()
#   ) |>
#   ungroup()
#
# inv_subd_4

# guardar
arrow::write_parquet(
  inv_subd_2,
  "datos/datos_subdere.parquet"
)
