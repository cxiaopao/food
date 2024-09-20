import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import AutoImport from  'unplugin-auto-import/vite';
import Components from 'unplugin-vue-components/vite'
import { ElementPlusResolver } from 'unplugin-vue-components/resolvers'
import tailwindcss from  'tailwindcss'
import autoprefixer from 'autoprefixer'
import {resolve} from 'path'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    AutoImport({
        imports: ['vue'],   
        resolvers: [ElementPlusResolver()],
      }), 
    Components({
      resolvers: [ElementPlusResolver()],
    }), 
  ],
  resolve:{
    alias:{
      '@': resolve(__dirname, "src")
    }
  },
  css: {
    postcss: {
      plugins: [
        tailwindcss, 
        autoprefixer,
      ]
    }
  }
})
