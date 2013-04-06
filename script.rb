require 'rubygems'
require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome
driver.manage.timeouts.implicit_wait = 10

driver.get "http://www.lan.com/es_cl/sitio_personas/index.html#lan_pestaniasCajaDeCompras_pestaniaLanpass"
box = driver.find_element(:css,"#lan_pestaniasCajaDeCompras_pestaniaLanpass")
element = box.find_element :css => "[name=campoOrigen]"
element.send_keys "SCL"

#wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
#first = wait.until { driver.find_element(:css => "[role=menuitem] a") }
first = driver.find_element(:css => ".ui-autocomplete-autocompletarAeropuertosOrigenLanpass [role=menuitem] a")
puts first.attribute('text')
first.click

element = box.find_element :css => "[name=campoDestino]"
element.send_keys "BUE"
first = driver.find_element(:css => ".ui-autocomplete-autocompletarAeropuertosDestinoLanpass [role=menuitem] a")
puts first.attribute('text')
first.click

driver.execute_script("document.getElementsByName('campoFechaIda')[2].removeAttribute('readonly');")
element = box.find_element(:name, "campoFechaIda")
element.clear
element.send_keys "21/ABR/2013"

driver.execute_script("document.getElementsByName('campoFechaVuelta')[2].removeAttribute('readonly');")
element = box.find_element(:name, "campoFechaVuelta")
element.clear
element.send_keys "29/ABR/2013"

element.submit
wait = Selenium::WebDriver::Wait.new(:timeout => 10)
wait.until { driver.find_element(:name => "login") }

element = driver.find_element :css => "[name=login]"
element.send_keys "106095604"
element = driver.find_element :css => "[name=password]"
element.clear
element.send_keys "olsdcn"
element.submit

