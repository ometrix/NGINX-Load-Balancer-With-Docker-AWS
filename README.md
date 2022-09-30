# NGINX-Load-Balancer-With-Docker-AWS
Un balanceador de carga creado con terraform para se auto desplegado

Esta es una configuracion que define una VPC con tres instancias de EC2 en 3 diferentes zonas de disponibilidad
esto nos permite crear un balanceador de carga, cada instancia corre NGINX en las zona A y B se han configurado 
como servidor HTTP y en la Zona C se ha configurado como un proxy inverso apuntando a las instancias de las zonas
A y B mediante las interfaces locales de RED de la VPC.

Esta configurado el sistema RoundRobin que es el por defecto de Nginx que balancea la carga en 50% en cada Instancia.

