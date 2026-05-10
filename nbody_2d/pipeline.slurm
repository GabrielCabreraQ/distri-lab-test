#!/bin/bash
#SBATCH --job-name=distri1
#SBATCH --partition=GPU
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=00:10:00
#SBATCH --output=logs_%j.out

echo "Ejecutando simulación N-Body en C++..."
# Aquí ejecutamos tu archivo real compilado
./nbody_2d

echo "Generando gráficos de reportes..."
# Aquí ejecutamos tus scripts de Python reales
python3 plot_reports.py

echo "Generando gráficos de escalabilidad..."
python3 plot_scaling.py
