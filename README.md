# 🎓 30 Aniversario Uniremington - Plataforma de Eventos

Proyecto académico para la asignatura **Lenguaje de Programación 3**, desarrollado para visualizar y gestionar la programación de la Semana de Aniversario (30 años) de la Corporación Universitaria Remington.

## 📝 Descripción

Esta es una aplicación web estática (Frontend) que separa la presentación visual de la información de los eventos. La interfaz está construida con **HTML5, CSS3 y JavaScript puro (Vanilla JS)**, mientras que los datos y detalles extendidos de cada evento se manejan de manera externa mediante archivos de **Microsoft Excel (.xlsx)**.

Adicionalmente, el proyecto incluye un sistema de galería fotográfica dinámica (Collage) tipo ventana modal, capaz de adaptarse inteligentemente a la cantidad de fotografías configuradas por evento.

## ✨ Características Principales

*   **Diseño Responsivo e Interactivo**: Interfaz moderna adaptable a dispositivos móviles y escritorio, con animaciones suaves y colores institucionales.
*   **Apertura Nativa de Excel**: Integración mediante el protocolo ms-excel:ofe|u| que permite abrir los archivos .xlsx de los eventos directamente en la aplicación de escritorio de Excel, en lugar de solo descargarlos.
*   **Collage Dinámico**: Visor de fotografías integrado en cada tarjeta de evento. Utiliza *CSS Grid* (uto-fit) para adaptar el diseño automáticamente según haya 1, 2, 3, 4 o más fotos por tarjeta.
*   **Servidor Local Automatizado**: Script en lote (iniciar.bat) que despliega un servidor HTTP local de Python, evitando problemas de restricciones CORS del navegador y garantizando que los enlaces locales funcionen perfectamente.

## 🚀 Requisitos

*   **Sistema Operativo**: Windows (para ejecutar .bat y abrir enlaces nativos de Excel).
*   **Python**: Se requiere tener Python instalado y agregado al PATH para que el script levante el servidor web local (http.server).
*   **Microsoft Office (Excel)**: Para la correcta visualización de las fichas de los eventos a través del botón "Abrir Excel".

## 🛠️ Cómo ejecutar el proyecto

1. Descarga o clona el repositorio/carpeta del proyecto.
2. Haz doble clic sobre el archivo **iniciar.bat**.
3. Se abrirá una terminal (PowerShell) iniciando un servidor local en el puerto 5520.
4. Tu navegador web predeterminado se abrirá automáticamente en http://127.0.0.1:5520/.
5. *Nota: Deja la terminal abierta mientras estés usando la página. Ciérrala cuando termines.*

## 📁 Estructura del Directorio

`	ext
30_ANIVERSARIO_UNIREMINGTON/
│
├── index.html            # Archivo principal con la estructura web y la lógica JS.
├── iniciar.bat           # Script de arranque del servidor local Python.
├── README.md             # Este archivo (Guía de inicio rápido).
├── DOCUMENTACION.md      # Documentación técnica extendida del código.
│
├── css/
│   └── style.css         # Hoja de estilos con variables, animaciones y diseño Grid/Flexbox.
│
├── data/
│   └── eventos/          # Archivos de Excel (.xlsx) que fungen como "Base de Datos".
│
└── img/                  # Imágenes y fotografías de evidencias y collage.
`

## 👨‍💻 Edición de Contenido (Fotos del Collage)

Para agregar o modificar las fotos que aparecen al hacer clic en las tarjetas, edita el archivo index.html. Busca la etiqueta <a class="thumb"...> de cada evento, y añade o modifica los atributos data-foto:

`html
<a class="thumb" href="..." 
   data-foto1="img/foto_inicio.jpg" 
   data-foto2="img/foto_desarrollo.jpg"
   data-foto3="img/foto_final.jpg">
`
*Si no hay fotos, el sistema mostrará un marcador de posición (placeholder) automático.*
