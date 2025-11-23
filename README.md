Arquitectura solicitada

1. Estructura del repositorio
    
README
Cloudformation/cf-arquitectura.yaml
Diagramas/Arquitectura.png
Scripts/Operaciones.sh
Documentación Técnica/Decisiones.txt

2. Arquitectura del sistema
Se toma la decisión de desarrollar la arquitectura de esta forma tomando en cuenta los requerimientos de seguridad, aislando el computo y los datos para que no puedan ser accedidos de otra forma más que de las rutas establecidad en el balanceador de carga (ALB). Las cargas se encuentran distribuidas en diversas regiones asegurando la alta disponibilidad y evitando que cualquier fallo que pueda afectar a una zona tenga impacto en las operaciones, todas estas acciones fueron integradas en el script de cloudformation considerando esto como la mejor práctica, para escenarios donde se deba replicar la arquitectura.

3. Guía de despliegue y operación
En la sección de scripts se encuentran los comandos necesarios para realizar el despliegue a tráves del CLI de aws, estableciendo de esta forma mecanismos que permitan realizar la integración de la ejecución a tráves de estándares de CI/CD.

4. Automatización CI/CD (GitHub Actions)

5. Decisiones Técnicas y Justificación
En la sección de Documentación técnica se amplia el detalle de diversas decisiones que se tomando al momento de desarrollar la arquitectura.
