import { defineConfig } from 'vite';
import ViteRails from "vite-plugin-rails";
import tailwindcss from '@tailwindcss/vite';
import autoprefixer from "autoprefixer";

export default defineConfig({
    plugins: [tailwindcss(), ViteRails()],
    css: {
        preprocessorOptions: { scss: { api: 'modern-compiler' } },
        postcss: { plugins: [autoprefixer()] },
    },
    build: { sourcemap: false },
    server: {
        host: 'localhost',
        port: 3036,
        strictPort: true,
        open: true,
    },
})
