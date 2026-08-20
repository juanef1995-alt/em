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

## Escaneo rápido (imprimir de a una etiqueta con un lector de código de barras)

Además del modo por lote de arriba, la sección **"5. Escaneo rápido"**
permite imprimir una sola etiqueta por vez a medida que vas escaneando el NIC
de cada bulto físico:

1. Con el PDF ya cargado, hacé clic dentro del recuadro de escaneo (queda
   marcado "Listo para escanear").
2. Escaneá el código de barras del bulto (o escribí el NIC a mano) y
   apretá Enter. Un lector de código de barras común (USB o Bluetooth,
   tipo "pistola") funciona como si fuera un teclado: escribe el número y
   Enter solo, así que no hace falta nada especial de configuración.
3. La app arma al instante el PDF de esa sola etiqueta y abre el diálogo de
   impresión de Windows/Mac. Confirmás con Enter o un clic en "Imprimir" y
   sale la etiqueta.
4. Si el NIC no está en el PDF cargado, la app avisa en rojo y hace un sonido
   distinto, sin mandar nada a imprimir.
5. Cada escaneo queda anotado en la tabla de abajo (hora, NIC, destino,
   estado), con un botón **"Reimprimir"** por si una etiqueta se atascó o
   salió mal.

Por defecto imprime 1 copia por escaneo; podés cambiarlo con el selector
"Copias por escaneo" arriba del recuadro.

**Antes de usarlo la primera vez en una PC:**

- Configurá la impresora de etiquetas (Zebra) como **impresora
  predeterminada** de Windows, así el diálogo de impresión ya viene con
  ella seleccionada.
- La primera vez que imprimas, revisá que el diálogo tenga el tamaño de
  papel/etiqueta correcto y la escala en **"Tamaño real" / "100%"** (no
  "Ajustar a la página"), y guardá esa configuración — el navegador la
  recuerda para las próximas impresiones.

### Modo 100% automático (sin tocar nada al escanear)

Si querés que ni siquiera haya que confirmar el diálogo de impresión, usá el
archivo **`Abrir en modo automatico.bat`** que está en esta misma carpeta:

1. Primero, poné la impresora Zebra como **predeterminada** en Windows
   (Configuración → Impresoras y escáneres → elegirla → "Establecer como
   predeterminada"; si aparece "Dejar que Windows administre mi impresora
   predeterminada", apagalo para que no la cambie sola).
2. De ahora en más, abrí la app haciendo **doble clic en
   `Abrir en modo automatico.bat`** en vez de en `index.html`. Se abre
   Chrome en modo silencioso: cada etiqueta que la app mande a imprimir sale
   directo a la impresora predeterminada, sin ningún diálogo ni clic.
3. El `.bat` busca Chrome solo (no hace falta editar rutas a mano) y lo abre
   con un perfil separado, así funciona aunque ya tengas otra ventana de
   Chrome normal abierta.

Usalo solo en la PC fija que esté al lado de la impresora, ya que en ese modo
cualquier cosa que la página mande a imprimir sale directo, sin
confirmación.

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
