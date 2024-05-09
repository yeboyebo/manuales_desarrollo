
## Mixin en SASS

Un mixin es una "función" en el sentido de que nos permite reutilizar código y que acepta argumenos, sin embargo, no es una función como tal.

Un mixin se define con el keyword @mixin seguido del nombre y los posibles parámetros:

 ```scss
@mixin mobile {
  @media screen and (max-width: 810px) {
      @content;
  }
}
 ```

 Y para utilizarlo lo incluímos(@inclide(parametros)) en algún selector:

  ```scss
.PedidoCli {
    .title {
      color: var( --main-color);
      @include mobile {
        color: red;
      }
    }
}
 ```


Ver https://sass-lang.com/documentation/at-rules/mixin/

## Usar mixin en App

Podemos usar los mixin en cualquier fichero scss sin necesidad de importarlos si importamos el siguiente fichero apps/{appName}/vite.config.ts:


 ```javascript
import ViteYaml from "@modyfi/vite-plugin-yaml";
import react from "@vitejs/plugin-react";
import { defineConfig } from "vite";
import path from "path";
const baseSrc = path.resolve(__dirname, "../../libs/styles");
const clientSrc = path.resolve(__dirname, "./styles");

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react(), ViteYaml()],
  css: {
    preprocessorOptions: {
      scss: { additionalData: 
        `@import "${baseSrc}/_mixin";
        @import "${clientSrc}/_clientMixin";` 
      },
    },
  },
});

 ```

 Tambien se puede usar un clientMixin para los que sean solo para una aplicacion en concreto.

En quimera-mono/libs/styles/_mixin.scss se encuentran los mixin generales, sobre todo relacionados con generar estilos solo para un tamaño de pantalla en concreto.