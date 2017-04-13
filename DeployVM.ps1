# Script para PowerCLI 5.5 para crear varias máquinas virtuales en un host.
# Cada creación de una VM es una tarea que será visible en el cliente web del vCenter.
# Versión: 0.1
# Autor: Diego M. Beltrán
#
### URL del vCenter
$vCenter="vCenter.home.local"
### Usuario administrador con permisos para crear VMs en el vCenter
$vCenterUser="usuario@home.local"
### Contraseña (No muy seguro...)
$vCenterUserPass="pass"
### Número de máquinas a generar
$vmNum = "8"
### Plantilla a clonar. Si es una VM (No template), hay que cambiar abajo el flag -Template por -VM
$plantilla = "clóname"
### El ESXi de destino. Si da igual el host destino, usar la línea comentada abajo
$ESXi = "esxi.home.local"
### Datastore destino. Cambiar cuando haya almacenamiento compartido
$datastore = "almacenamiento"
### La VApp de destino.
$vApp = "vApp"
### Prefijo para el nombre de las máquinas clonadas
$vmPrefijo = "VM"
#________________________________________
#
#
write-host "Conectando al vCenter Server con la URL: $vCenter`r`n" -foreground green
Connect-viserver $vCenter -user $vCenterUser -password $vCenterUserPass -WarningAction 0
1..$vmNum | foreach {
	$num="{0:D2}" -f $_
	$vmNombre= $vmPrefijo + $num
	# Quitado ya que a veces coge el host que no debe, y en el entorno actual no nos interesa.
	#$ESXi=Get-VMHost -state connected
	write-host "Creando VM con el nombre: $vmNombre..." -foreground green
	# El flag RunAsync permite la tarea asíncrona
	New-VM -Name $vmNombre -Template $plantilla -VMHost $ESXi -Datastore $datastore -VApp $vApp -RunAsync
	}