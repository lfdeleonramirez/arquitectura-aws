Decisiones técnicas

Justificación de arquitectura

Tomando en cuenta las mejores prácticas del AWS Cloud Adoption Framework -AWS CAF- y teniendo un enfoque en las diversas capacidades definidas como lo son la comercial, personal, gobernanza, plataforma, seguridad y operaciones, se establece el modelo de arquitectura propuesto teniendo como principal prioridad el asegurar la operación en todo momento y optimizando el costo, asegurando así un mayor margen de ingreso para la empresa contando con sistemas robustos y resilentes.

1. Uso de cloudformation
Dentro de las opciones a considerar se encontraba la opción de hacer uso de terrarform o cloudformation, se opta por generar toda la infraestructura a tráves de cloudformation ya que al ser la opción nativa de AWS la creación de recursos resulta más sencilla y su mantenimiento se ajusta a las nuevas versiones que puedan salir, adcional a esto la documentación que AWS provee sobre este servicio es abundante.

2. Uso de la región
La decisión de utilizar la región de virgina para el despligue se fundamenta en que es la que provee la mayor cantidad de servicios, lo cual representa una cantidad de mejoras y nuevas carácteristicas de forma periodica, adicional a esto que es la región que cuenta con la mayor cantidad de zonas de disponibilidad, lo que facilita un failover al momento de un incdente en alguna zona.

3. Manejo de la contraseña de base de datos por parametro
Inicialmente se contempló el uso de secret manager para la contraseña, sin embargo al existir un cloudformation encargado de la generación de toda la infraestructura se considera una mala práctica de seguridad el especificar en donde quedará el resguardo de la contraseña, cabe mencionar que al parametro de ingreso se le agrega la propiedad "no echo" con la finalidad de que esta contraseña no pueda verse  en los parametros y evitando su divulgación.

4. Políticas de IAM
Tomando en consideración el principio del privilgio mínimo se asignan los permisos administados por AWS para la intracción adecuada con los servicios de S3 y cloudwatch.

5. Seguridad
Con la finalidad de evitar que cualquier recurso que se encuentre en la vpc se pueda conectar, se define en los Grupos de seguridad que el acceso se encuentra límitiado a los Grupos de seguridad que cuentan con el permiso para realizar operaciones sobre los recursos creados (ec2 y rds).

6. Elección de tipos de instancia
Tanto en la instancia de ec2 (t2.micro) y rds (db.t3.micro ) se consideró el uso de estas para hacer uso de la capa gratuita durante las primeras ejecuciones priorizando la reducción de costos en las pruebas de funcionamiento

7. Alta disponibilidad y escalibilidad
La decisión del diseño de la estructura de red creando subredes publicas y privadas en distntas zonas de disponibilidad se realiza con la finalidad de estar preparados a fallos, regularmente cuando existen fallos internos en AWS existen zonas de disponibilidad que no cuentan con degradación esto permite el correcto funcionamiento de al menos un nodo mientras se pudieran presentar problemas

8. Riesgos a tener en consideración
Fallos en la implementación, se debe tener el cuidado adecuado con el cloudformation al momento de agregar nuevos recursos ya que a pesar de que cuenta con un rollback automático puede generar altos tiempos de espera si se tienen complicaciones para la creación o eliminación de uno o varios recursos.