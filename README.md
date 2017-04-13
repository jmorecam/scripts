# Scripts
Scripts para mi curro y el día a día

## DeployVM.ps1
Script de PowerShell/PowerCLI. Sirve para automatizar el despliegue de un número definido de máquinas virtuales, clonadas a partir de una plantilla u otra máquina virtual, en uno o varios host ESXi gestionados por un vCenter Server.

Se usan funciones del shell (PowerCLI 5.5) que provee VMWare para crear las tareas asíncronas visibles en el cliente web del vCenter y registrar las máquinas creadas.

Se recomienda el uso conjunto con Ansible para modificar el hostname, y otros aspectos.

Para usar en Linux, seguir (infinitivo del verbo seguir, no imperativo que sería "seguid") estas instrucciones:

http://www.virten.net/2016/10/getting-started-with-powercli-for-linux-powercli-core/
