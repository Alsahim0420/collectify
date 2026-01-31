#!/bin/bash

# Script para generar reporte de cobertura con lcov

echo "🧪 Ejecutando tests y generando reporte de cobertura..."

# Limpiar reportes anteriores
rm -rf coverage/
rm -f coverage/lcov.info
rm -f coverage/lcov.info.cleaned

# Ejecutar tests con cobertura
flutter test --coverage

# Verificar que lcov está instalado
if ! command -v lcov &> /dev/null; then
    echo "⚠️  lcov no está instalado. Instalando..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install lcov
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update && sudo apt-get install -y lcov
    else
        echo "❌ Por favor instala lcov manualmente para tu sistema operativo"
        exit 1
    fi
fi

# Generar reporte lcov
if [ -f "coverage/lcov.info" ]; then
    echo "📊 Generando reporte lcov..."
    
    # Limpiar el archivo lcov.info (remover archivos de test y archivos generados)
    lcov --remove coverage/lcov.info \
        '*/test/*' \
        '*/generated/*' \
        '*.g.dart' \
        '*.freezed.dart' \
        -o coverage/lcov.info.cleaned
    
    # Generar reporte HTML
    genhtml coverage/lcov.info.cleaned -o coverage/html
    
    echo "✅ Reporte de cobertura generado en coverage/html/index.html"
    
    # Mostrar resumen de cobertura
    echo ""
    echo "📈 Resumen de cobertura:"
    lcov --summary coverage/lcov.info.cleaned
    
    # Verificar que la cobertura sea mayor al 80% (falla si no se cumple)
    COVERAGE=$(lcov --summary coverage/lcov.info.cleaned 2>&1 | grep -oP '\d+\.\d+%' | head -1 | sed 's/%//')
    MIN_COVERAGE=80
    if (( $(echo "$COVERAGE >= $MIN_COVERAGE" | bc -l) )); then
        echo "✅ Cobertura de tests: ${COVERAGE}% (objetivo: >= ${MIN_COVERAGE}%)"
    else
        echo "❌ Cobertura de tests: ${COVERAGE}% (objetivo: >= ${MIN_COVERAGE}%)"
        exit 1
    fi
else
    echo "❌ No se encontró el archivo coverage/lcov.info"
    exit 1
fi
