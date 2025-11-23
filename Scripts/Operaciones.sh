#!/bin/bash
#Script para desplegar, actualizar y eliminar la infraestructura demo

# --- Variables de Configuración ---
NOMBRE_STACK="webapp-demo"
TEMPLATE="../Cloudformation/cf-arquitectura.yaml"
REGION="us-east-1" # Se establece la región de virgina por ser la que cuenta con mayores recursos disponibles
# ----------------------------------

# 1. Solicitar la Acción al Usuario
echo "Selecciona la acción que deseas realizar:"
echo "  [d] Desplegar o actualizar la infraestructura"
echo "  [e] Eliminar la infraestructura"
echo "  [s] Salir"
read -r -p "Ingresa d, e o s: " ACCION

# Convertir a minúsculas
ACCION=$(echo "$ACCION" | tr '[:upper:]' '[:lower:]')

# --- Estructura de Control (Case) ---

case "$ACCION" in
    d)
        # --- DESPLEGAR / ACTUALIZAR ---
        
        # Solicitud de Contraseña de BD
        read -s -r -p "Favor ingresa la contrasenia de BD (mín. 8 caracteres): " DBPASSWORD
        echo "" # Nueva línea
        
        # Ejecución y actualización del cloudformation
        aws cloudformation deploy \
            --region "$REGION" \
            --template-file "$TEMPLATE" \
            --stack-name "$NOMBRE_STACK" \
            --parameter-overrides DBPassword="$DBPASSWORD" \
            --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
            --no-fail-on-empty-changeset
            
        # Mostrar los outputs
        aws cloudformation describe-stacks \
            --stack-name "$NOMBRE_STACK" \
            --region "$REGION" \
            --query "Stacks[0].Outputs" \
            --output table
        ;;

    e)
        # --- ELIMINAR ---
        # Intentar obtener el nombre del Bucket S3 desde los Outputs
        S3_BUCKET_NAME=$(aws cloudformation describe-stacks \
            --stack-name "$NOMBRE_STACK" \
            --region "$REGION" \
            --query "Stacks[0].Outputs[?OutputKey=='S3BucketName'].OutputValue" \
            --output text 2>/dev/null || echo "None")
            
        # Vaciado del Bucket S3 (si existe)
        if [ "$S3_BUCKET_NAME" != "None" ]; then
            echo "Vaciando el bucket S3: s3://$S3_BUCKET_NAME"
            aws s3 rm "s3://$S3_BUCKET_NAME" --recursive
        else
            echo "No se encontró un Output para S3 Bucket. Continuando con la eliminación de la Stack."
        fi
        
        # Eliminar el CloudFormation Stack
        echo "Eliminando la stack de CloudFormation: $NOMBRE_STACK"
        aws cloudformation delete-stack --region "$REGION" --stack-name "$NOMBRE_STACK"
        ;;

    s)
        echo "Saliendo del script."
        exit 0
        ;;

    *)
        echo "Opción no válida. Saliendo."
        exit 1
        ;;
esac

exit 0