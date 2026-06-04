library(RSelenium)

driver <- rsDriver(browser = "firefox", 
                   port = 4562L,
                   phantomver = NULL, chromever = NULL)

remote <- driver$client

remote$navigate(url = "http://inversionmunicipal.subdere.gov.cl/")

# elegir región (del 2 al 17)
remote$
  findElement("css selector", 
              "#id_region > option:nth-child(17)")$
  clickElement()

# apretar botón buscar
remote$
  findElement("css selector", 
              "input.form-control")$
  clickElement()


# apretar botón descargar
remote$
  findElement("css selector", 
              "#resumen > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > a:nth-child(1)")$
  clickElement()
