require 'rubygems'
require 'selenium-webdriver'

$driver = Selenium::WebDriver.for :chrome
$sel = Selenium::WebDriver.for :chrome

$driver.manage.timeouts.implicit_wait = 10

$driver.get "http://www.poderjudicial.cl/modulos/BusqCausas/FallosCorteSuprema/sentencia/BCA_detalle_meses.php?era=2012&mes=1"
$output = ""

def getLinkForCause(rolyear)
	$sel.manage.timeouts.implicit_wait = 2

	$sel.get "http://poderjudicial.cl/modulos/TribunalesPais/TRI_EstadoCausa.php?corte=0&codigotribunal=6050000&opc_menu=7"

	rol = $sel.find_element(:css, "input[name=rol][type=TEXT]")
	ano = $sel.find_element(:css, "input[name=ano][type=TEXT]")
	rol.send_keys rolyear.split("-")[0]
	4.times do
		ano.send_keys :backspace
	end
	ano.send_keys rolyear.split("-")[1]
	submit = $sel.find_element(:name, "sub1")
	submit.click

	first_link = $sel.find_element(:css,"a")
	link = first_link.attribute('href')
	return link
end

def printRelevantRows(rows, day)
	rows.each do |row|
		tds = row.find_elements(:css, "td")
		$output += "'#{day}/1/2012,"
		$output += tds[1].text + ","
		$output += "Corte Suprema,"
		$output += tds[3].text + ","
		$output += "'" + tds[6].text + "',"
		$output += getLinkForCause(tds[1].text) + "\n"
	end
end

def getRolForDate(day)
	$driver.execute_script("javascript:listar(#{day},1,2012,'ENERO');")
	$driver.switch_to.window $driver.window_handles[1]

	rows = $driver.find_elements(:xpath,"//tr[contains(.,'(Trabajo)')]")
	printRelevantRows(rows,day)
	rows = $driver.find_elements(:xpath,"//tr[contains(.,'(Laboral)')]")
	printRelevantRows(rows,day)

	$driver.close
	$driver.switch_to.window $driver.window_handles[0]
end



getRolForDate(31)
getRolForDate(30)
getRolForDate(27)
getRolForDate(26)
getRolForDate(25)
getRolForDate(24)
getRolForDate(23)
getRolForDate(20)
getRolForDate(19)
getRolForDate(18)
getRolForDate(17)
getRolForDate(16)
getRolForDate(13)
getRolForDate(12)
getRolForDate(11)
getRolForDate(10)
getRolForDate(9)
getRolForDate(6)
getRolForDate(5)
getRolForDate(4)
getRolForDate(3)
getRolForDate(2)

begin
  file = File.open("output.csv", "w")
  file.write($output) 
rescue IOError => e
  #some error occur, dir not writable etc.
ensure
  file.close unless file == nil
end
