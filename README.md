# Ordenador de Etiquetas por NIC

Aplicación web simple para tomar el PDF de "Etiquetas de Viaje" (como los que
genera Transportes Unión, con formato `Etiquetas_Viaje_JUR_###_AAAAMMDD.pdf`)
y armar un PDF nuevo con las etiquetas en el orden de NIC (Número de
Seguimiento) que vos indiques, listo para imprimir. También permite
escanear el código de barras de cada bulto e imprimir esa etiqueta al
instante, una por una.

Es un único archivo (`index.html`) que corre 100% en el navegador — no
necesita instalación, ni conexión a internet, ni servidor. El PDF nunca se
sube a ningún lado.

## Instalación (Windows, recomendado — un solo ícono)

1. Descomprimí el ZIP en cualquier carpeta.
2. Ejecutá **`Instalar.bat`** (doble clic) una sola vez.
   - Copia la app a una carpeta fija en tu usuario.
   - Te deja un ícono **"Etiquetas NIC"** en el escritorio.
   - Si no tenés Google Chrome instalado, te avisa y no continúa — instalalo
     desde https://www.google.com/chrome/ y volvé a ejecutar `Instalar.bat`.
3. Después de instalarlo, ya podés borrar la carpeta del ZIP si querés — la
   app quedó copiada aparte. De ahora en más, **usá siempre el ícono
   "Etiquetas NIC" del escritorio** para abrir la app: abre directo en modo
   automático, sin cartel de impresión al escanear (ver más abajo).

Antes de escanear en serio, andá a la pestaña **Configuración** de la app y
usá **"Imprimir etiqueta de prueba"** para confirmar que la impresora
predeterminada y el tamaño de etiqueta están bien.

### Alternativa sin instalar nada

Si preferís no correr el instalador, `index.html` funciona igual con doble
clic directo (o sirviéndolo con cualquier servidor estático). En ese caso,
al escanear se va a abrir el diálogo de impresión normal de Windows en vez
de imprimir sola — confirmás con Enter o un clic en "Imprimir".

## Cómo usarla

1. Cargá uno o más PDF de etiquetas (arrastrándolos juntos, o eligiendo
   varios en el diálogo de archivos). También podés ir agregando más PDF
   después, sin perder los que ya cargaste — por ejemplo, para juntar en una
   misma sesión de escaneo los listados de viaje de varios días. Cada
   archivo cargado aparece en una lista con la cantidad de etiquetas que
   trae y un botón **"Quitar"** para sacarlo (y "Vaciar todo" para arrancar
   de cero). La app detecta automáticamente cada etiqueta y su NIC en todos
   los PDF cargados, mostrando destino, sucursal, bultos, fecha y de qué
   archivo salió cada una en una sola tabla. Si el mismo NIC aparece en más
   de un PDF, se queda con la primera copia cargada y avisa cuántas
   repeticiones ignoró.
2. En el cuadro de texto escribí o pegá los NIC en el orden en que querés
   imprimirlos (uno por línea, o separados por coma/espacio). El botón
   "Usar todos, en el orden del PDF" precarga la lista completa tal cual
   viene en los archivos cargados.
   - Si repetís un NIC, esa etiqueta se imprime más de una vez (útil para
     reimprimir una etiqueta perdida o dañada).
   - Si escribís un NIC que no está en ningún PDF cargado, la app lo marca
     como "no encontrado" y no lo incluye en el PDF final.
3. Elegí cuántas copias de cada etiqueta querés (por defecto, la misma
   cantidad que trae el PDF original — normalmente 2 por envío).
4. Hacé clic en "Generar PDF ordenado". Se descarga automáticamente el PDF
   y se abre en una pestaña nueva para imprimir directamente.

## Escaneo rápido (imprimir de a una etiqueta con un lector de código de barras)

Además del modo por lote de arriba, la sección **"5. Escaneo rápido"**
permite imprimir una sola etiqueta por vez a medida que vas escaneando el NIC
de cada bulto físico:

1. Apenas cargás el/los PDF, la app empieza a preparar en segundo plano el
   dibujo de cada etiqueta (se ve un cartel "Preparando etiquetas para
   impresión rápida… X/Y" debajo del recuadro de escaneo). Conviene esperar
   a que termine antes de arrancar a escanear fuerte, así cada etiqueta sale
   al instante en vez de tener que dibujarse en el momento. Si escaneás
   antes de que termine, igual funciona — esa etiqueta puntual tarda un
   toque más la primera vez.
2. Hacé clic dentro del recuadro de escaneo (queda marcado "Listo para
   escanear").
3. Escaneá el código de barras del bulto (o escribí el NIC a mano) y
   apretá Enter. Un lector de código de barras común (USB o Bluetooth,
   tipo "pistola") funciona como si fuera un teclado: escribe el número y
   Enter solo, así que no hace falta nada especial de configuración.
4. La app manda esa etiqueta a imprimir al instante. Si abriste la app con
   el ícono "Etiquetas NIC" (instalado con `Instalar.bat`), sale directo sin
   ningún cartel; si abriste `index.html` normal, se abre el diálogo de
   impresión de Windows y confirmás con Enter o un clic en "Imprimir".
5. Si el NIC no está en ningún PDF cargado, la app avisa en rojo y hace un
   sonido distinto, sin mandar nada a imprimir.
6. Cada escaneo queda anotado en la tabla de abajo (hora, NIC, destino,
   estado), con un botón **"Reimprimir"** por si una etiqueta se atascó o
   salió mal.

Por defecto imprime 1 copia por escaneo; podés cambiarlo con el selector
"Copias por escaneo" arriba del recuadro.

## Configuración de la impresora

Todo esto está también explicado, paso a paso, dentro de la pestaña
**Configuración** de la app:

- Poné la impresora Zebra como **predeterminada** en Windows (Configuración
  → Impresoras y escáneres → elegirla → "Establecer como predeterminada"; si
  aparece "Dejar que Windows administre mi impresora predeterminada",
  apagalo para que no la cambie sola).
- Revisá en las preferencias de la impresora que el tamaño de papel/etiqueta
  configurado sea el de tu rollo (10x10cm / 4x4in aprox.).
- Usá el botón **"Imprimir etiqueta de prueba"** (pestaña Configuración)
  para confirmar que todo el circuito funciona antes de escanear en serio.

Usá el ícono/modo automático solo en la PC fija que esté al lado de la
impresora: en ese modo, cualquier cosa que la página mande a imprimir sale
directo a la impresora predeterminada, sin ningún diálogo de confirmación.

## Estructura

- `index.html` — la aplicación completa (HTML + CSS + JS), incluidas las
  copias de [pdf.js](https://mozilla.github.io/pdf.js/) (lectura de los PDF
  de origen) y [pdf-lib](https://pdf-lib.js.org/) (armado del PDF de
  salida) ya insertadas adentro del mismo archivo — no depende de ninguna
  carpeta aparte ni de una CDN, así que es un solo archivo totalmente
  portable.
- `Instalar.bat` — instalador de un solo uso para Windows: copia la app a
  `%LocalAppData%\EtiquetasNIC` y crea el ícono "Etiquetas NIC" en el
  escritorio, apuntando a Chrome en modo de impresión silenciosa.
- `nic.ico` — el ícono que usa ese acceso directo.

## Cómo identifica cada etiqueta

Cada página del PDF de origen trae, debajo de "Número de Seguimiento:" y la
fecha, el número de seguimiento (NIC) como texto suelto. La app lee el texto
de cada página con pdf.js, toma ese número, y agrupa las páginas que
comparten el mismo NIC (normalmente 2 copias idénticas por envío). Al generar
el PDF final, copia esas páginas —en el orden que vos definiste— usando
pdf-lib, sin volver a renderizar ni perder calidad.
