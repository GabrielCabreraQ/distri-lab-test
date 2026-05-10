#!/bin/bash
#SBATCH --job-name=distri1
#SBATCH --partition=GPU
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=64G
#SBATCH --gres=gpu:1
#SBATCH --time=04:00:00
#SBATCH --output=logs_%j.out

echo "Ejecutando simulación N-Body en C++..."
# El programa generará los .dat con el prefijo "prueba_entorno"
./nbody_2d -scaling -N 50000 -iters 10 -threads 1,2,3,4,5,6,7,8,9,10,11,12 -schedule static -chunk 16 -output prueba_entorno

echo "Generando gráficos de reportes..."
# Le indicamos el nombre de salida para el gráfico de rendimiento
python3 plot_reports.py --performance-output Resultados_Benchmark/prueba_entorno_perf.png

echo "Generando gráficos de escalabilidad..."
# Le pasamos el .dat exacto que generó C++ y le damos nombre a las imágenes de salida
python3 plot_scaling.py --input Resultados_Benchmark/prueba_entorno_scaling.dat --output Resultados_Benchmark/prueba_entorno_scaling.png --amdahl-output Resultados_Benchmark/prueba_entorno_amdahl.png
