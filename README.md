# Ordenador de Etiquetas por NIC

Aplicación web simple para tomar el PDF de "Etiquetas de Viaje" (como los que
genera Transportes Unión, con formato `Etiquetas_Viaje_JUR_###_AAAAMMDD.pdf`)
y armar un PDF nuevo con las etiquetas en el orden de NIC (Número de
Seguimiento) que vos indiques, listo para imprimir.

No requiere instalación ni conexión a internet: es un único archivo HTML que
corre 100% en el navegador. El PDF nunca se sube a ningún servidor.

## Cómo usarla

1. Abrí `index.html` con doble clic (o servilo con cualquier servidor
   estático, por ejemplo `python3 -m http.server` y entrá a
   `http://localhost:8000`).
2. Cargá el PDF de etiquetas (arrastrándolo o haciendo clic para elegirlo).
   La app detecta automáticamente cada etiqueta y su NIC, mostrando destino,
   sucursal, bultos y fecha en una tabla.
3. En el cuadro de texto escribí o pegá los NIC en el orden en que querés
   imprimirlos (uno por línea, o separados por coma/espacio). El botón
   "Usar todos, en el orden del PDF" precarga la lista completa tal cual
   viene en el archivo original.
   - Si repetís un NIC, esa etiqueta se imprime más de una vez (útil para
     reimprimir una etiqueta perdida o dañada).
   - Si escribís un NIC que no está en el PDF cargado, la app lo marca como
     "no encontrado" y no lo incluye en el PDF final.
4. Elegí cuántas copias de cada etiqueta querés (por defecto, la misma
   cantidad que trae el PDF original — normalmente 2 por envío).
5. Hacé clic en "Generar PDF ordenado". Se descarga automáticamente el
   archivo `<nombre-original>_ordenado.pdf` y se abre en una pestaña nueva
   para imprimir directamente.

## Estructura

- `index.html` — la aplicación completa (HTML + CSS + JS).
- `vendor/` — copias locales de [pdf.js](https://mozilla.github.io/pdf.js/)
  (lectura del PDF de origen) y [pdf-lib](https://pdf-lib.js.org/) (armado
  del PDF de salida), para que la app funcione sin depender de una CDN.

## Cómo identifica cada etiqueta

Cada página del PDF de origen trae, debajo de "Número de Seguimiento:" y la
fecha, el número de seguimiento (NIC) como texto suelto. La app lee el texto
de cada página con pdf.js, toma ese número, y agrupa las páginas que
comparten el mismo NIC (normalmente 2 copias idénticas por envío). Al generar
el PDF final, copia esas páginas —en el orden que vos definiste— usando
pdf-lib, sin volver a renderizar ni perder calidad.
