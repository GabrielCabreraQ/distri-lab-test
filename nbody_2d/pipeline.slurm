#!/bin/bash
#SBATCH --job-name=distri1
#SBATCH --partition=GPU
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --gres=gpu:1
#SBATCH --time=04:00:00
#SBATCH --output=logs_%j.out

echo "Ejecutando simulación N-Body en C++..."
# Aquí ejecutamos tu archivo real compilado
./nbody_2d -scaling -N 50000 -iters 10 -threads 1,2,4,8 -schedule static -chunk 16 -output prueba_entorno 

echo "Generando gráficos de reportes..."
# Aquí ejecutamos tus scripts de Python reales
python3 plot_reports.py

echo "Generando gráficos de escalabilidad..."
python3 plot_scaling.py
