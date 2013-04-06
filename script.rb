require 'rubygems'
require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome
driver.manage.timeouts.implicit_wait = 10

driver.get "http://www.lan.com/es_cl/sitio_personas/index.html#lan_pestaniasCajaDeCompras_pestaniaLanpass"
box = driver.find_element(:css,"#lan_pestaniasCajaDeCompras_pestaniaLanpass")

def setAirport(airport, type, box, driver)
	element = box.find_element :css => "[name=campo#{type}]"
	element.send_keys airport
	first = driver.find_element(:css => ".ui-autocomplete-autocompletarAeropuertos#{type}Lanpass [role=menuitem] a")
	puts first.attribute('text')
	first.click
end

def setDate(date, type, box, driver)
	driver.execute_script("document.getElementsByName('campoFecha#{type}')[2].removeAttribute('readonly');")
	element = box.find_element(:name, "campoFecha#{type}")
	element.clear
	element.send_keys date
end


setAirport("SCL","Origen",box,driver)
setAirport("BUE","Destino",box,driver)
setDate("21/JUN/2013","Ida",box,driver)
setDate("24/JUN/2013","Vuelta",box,driver)
box.find_element(:css,"[type=submit]").click

wait = Selenium::WebDriver::Wait.new(:timeout => 10)
wait.until { driver.find_element(:name => "login") }

element = driver.find_element :css => "[name=login]"
element.send_keys "106095604"
element = driver.find_element :css => "[name=password]"
element.clear
element.send_keys "olsdcn"
element.submit

