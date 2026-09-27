# 📖 Documentación Técnica - 30 Aniversario Uniremington

Este documento proporciona una visión profunda de la arquitectura técnica, las decisiones de diseño y el funcionamiento interno del proyecto web desarrollado para la clase de **Lenguaje de Programación 3**.

---

## 1. Arquitectura del Proyecto

El proyecto sigue una arquitectura **Estática y Desacoplada**.
En lugar de depender de una base de datos tradicional (como MySQL o MongoDB) y de un backend complejo (como PHP, Node.js), el proyecto utiliza un enfoque de archivos planos:

*   **Capa de Presentación (Frontend):** `index.html` y `css/style.css` se encargan de la estructuración semántica y la UI interactiva.
*   **Capa de Almacenamiento (Persistencia):** En lugar de BD, la información densa (fecha, hora, lugar, asistentes) recae en documentos `.xlsx` alojados en `data/eventos/`. Esta separación facilita la modificación del cronograma por parte de personal no técnico (abriendo el Excel y editando) sin necesidad de tocar el código fuente.

---

## 2. Lógica JavaScript (index.html)

El archivo `index.html` posee dos scripts principales que controlan la interactividad. Todo el código JS se dispara bajo el evento `DOMContentLoaded` para asegurar que el árbol DOM esté completamente cargado antes de su manipulación.

### A. Intercepción y Formateo de Enlaces MS Excel
**Problema:** Normalmente, un enlace `<a href="documento.xlsx">` forzará al navegador a descargar el archivo.
**Solución:** Se utilizó el protocolo nativo de Microsoft Office URI Schemes (`ms-excel:ofe|u|`).
*   Se captura cualquier enlace terminado en `.xlsx` usando `querySelectorAll('a[href$=".xlsx"]')`.
*   Se convierte la ruta relativa (ej. `data/...`) a una URL absoluta mediante `new URL(..., window.location.href).href`. Esto es necesario porque Office rechaza rutas relativas.
*   Se concatena el esquema de apertura `ms-excel:ofe|u|` a la URL resultante. Al hacer clic, el sistema operativo transfiere la ejecución a Excel.

### B. Inyección Dinámica del Collage de Fotos
Para permitir un diseño donde una tarjeta pueda tener 1, 2, o $N$ fotografías, se implementó un algoritmo dinámico:
1.  **Listeners (Escuchadores):** Se interceptan todos los clics sobre los elementos `.thumb` y se cancela su comportamiento por defecto (que era abrir Excel) usando `e.preventDefault()`.
2.  **Lectura Iterativa (Loop):** El script usa un bucle `while (thumb.hasAttribute('data-foto' + i))` que itera consecutivamente leyendo atributos en el HTML como `data-foto1`, `data-foto2`, etc.
3.  **Inyección en el DOM:** Por cada ruta de imagen encontrada, el JS construye un bloque HTML (`<div class="collage-slot"><img src="..."></div>`) y lo concatena (inyecta) a la cuadrícula del modal `grid.innerHTML`.
4.  **Fallback (Alternativa visual):** Si el bucle no encuentra ninguna fotografía (`!foundAny`), inyecta un diseño SVG de advertencia ("No hay fotos asignadas").

---

## 3. Hoja de Estilos y CSS (style.css)

El archivo CSS hace un uso exhaustivo de las prácticas modernas de desarrollo web:

### A. Variables Nativas (Custom Properties)
El proyecto usa la pseudo-clase `:root` para centralizar la paleta de colores. Por ejemplo: `--navy: #00427e;` o `--red: #e40613;`. Esto garantiza consistencia visual y permite cambios masivos modificando una sola línea de código.

### B. Animaciones (@keyframes)
Se han implementado animaciones personalizadas para mejorar la experiencia de usuario:
*   `fadeUp`: Efecto de entrada donde los elementos aparecen de abajo hacia arriba y transicionan su opacidad.
*   `floatRing`: Rotación continua y traslación de elementos abstractos en el encabezado (fondo decorativo).
*   `glow30` y `shimmer`: Modifican el filtro `drop-shadow` y el `background-position` para crear un aspecto metálico/brillante sobre el gran número "30" del inicio.

### C. Cuadrícula Flexible y Adaptativa (CSS Grid)
El éxito del Collage dinámico reside en esta poderosa regla CSS:
```css
.collage-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1.5rem;
}
```
*   **`auto-fit`**: Inserta tantas columnas como quepan en el contenedor sin desbordarlo.
*   **`minmax(200px, 1fr)`**: Le dice al navegador que cada fotografía debe medir como mínimo `200px` de ancho. Si sobra espacio, se repartirá equitativamente (`1fr`) entre todas las fotos. 
Esto hace que el diseño del modal no necesite Media Queries complejos; automáticamente se divide en 1, 2, 3 o 4 cuadrículas según el número de fotos inyectadas por Javascript.

---

## 4. Servidor Local Automático (iniciar.bat)

Desplegar archivos HTML en el sistema de archivos (`file:///C:/...`) a menudo bloquea características modernas debido a las políticas CORS (Cross-Origin Resource Sharing) de los navegadores.
Para prevenir este comportamiento en entornos locales, se desarrolló el archivo `iniciar.bat`:

1.  **Check de Entorno (`where python`):** Verifica que el lenguaje Python esté instalado en la máquina anfitriona.
2.  **Servidor Web (Backend minimalista):** Ejecuta `python -m http.server 5520 --bind 127.0.0.1`. Esto habilita un pequeño servidor HTTP de un solo hilo que "sirve" el archivo `index.html` bajo una IP de localhost.
3.  **Lanzamiento del Navegador:** Usa una instrucción asíncrona de PowerShell (`Start-Process 'http://127.0.0.1:5520/'`) para abrir el proyecto en el navegador predeterminado del usuario.
